/* number stencils for Really Useful Box 35L */

/* We want to fit between the buttresses, which are not actually parallel */

top_width = 153;
bottom_width = 160;
buttress_height = 220;
slope = ((bottom_width - top_width) / 2) / buttress_height;

function width_at_height(height) = bottom_width - slope * height;

stencil_top_offset = 150;
stencil_top_width = width_at_height(stencil_top_offset);

n_digits = 3;

digit_width = stencil_top_width / n_digits;
digit_height = digit_width * 1.6; /* not sure what it really should be */

stencil_base_offset = stencil_top_offset - digit_height;
stencil_base_width = width_at_height(stencil_base_offset);

bar_width = 6;

nub_width = 6;
nub_height = 8;

module nub() {
     square([nub_width, nub_height]);
}

module centre_bar(digit) {
     if (digit == "0" || digit == "4" || digit == "6" || digit == "8" || digit == "9") 
          translate([digit_width/2 - bar_width/2, 0]) square([bar_width, digit_height]);
}

module digit_stencil(digit) {
     translate([digit_width/2, digit_height*0.15]) text(text=digit, halign="center", valign="baseline", size=digit_height*0.66);
}

module left_digit(digit) {
     union() {
          difference () {
               polygon([[0, 0], [digit_width, 0], [digit_width, digit_height], [slope * digit_height, digit_height]]);
               digit_stencil(digit);
               translate([digit_width-nub_width, digit_height-nub_height]) nub();
          }
          centre_bar(digit);
          translate([digit_width, 0]) nub();
     }
}

module middle_digit(digit) {
     union() {
          difference () {
               polygon([[0, 0], [digit_width, 0], [digit_width, digit_height], [0, digit_height]]);
               digit_stencil(digit);
               translate([0, 0]) nub();
               translate([digit_width-nub_width, 0]) nub();
          }
          centre_bar(digit);
          translate([-nub_width, digit_height-nub_height]) nub();
          translate([digit_width, digit_height-nub_height]) nub();
     }
}

module right_digit(digit) {
     union() {
          difference () {
               polygon([[0, 0], [digit_width, 0], [digit_width - slope * digit_height, digit_height], [0, digit_height]]);
               digit_stencil(digit);
               translate([0, digit_height-nub_height]) nub();
          }
          centre_bar(digit);
          translate([-nub_width, 0]) nub();
     }
}

module row(digit) {
     left_digit(digit);
     translate([(digit_width+nub_width)*1.05, 0]) middle_digit(digit);
     translate([(digit_width+nub_width)*2.10, 0]) right_digit(digit);
}

for (i = [0:9]) {
     translate([(i % 2) * (digit_width+nub_width) * 3.3, round((i-0.9)/2) * digit_height * 1.05]) row(str(i));
}

