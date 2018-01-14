max_total_width = 642;
board_frame_depth = 19;

width = 300;
height = 50;

thickness = 3;

bulb_base_width = 16.5;
bulb_base_height = 10;

bracket_height = sqrt(height*height*2)/2;

spacing = 75;

module lamp_hole() {
     circle(d=35, centre=true);
}

module PIR_hole() {
     circle(d=25, centre=true);
}

module lamp_support_arch() {
     intersection() {
	  difference() {
	       circle(r=height, centre=true);
	       circle(r=28, centre=true);
	       translate([- bulb_base_width/2, 26]) { square([bulb_base_width, bulb_base_height]); }
	  }
	  translate([-height, 0]) square([height*2, height]);
     }
}

module frontage() {
     difference () {
	  union() {
	       intersection() {
		    square([height, height]);
		    translate([height, 0]) circle(r=height);
	       }
	       translate([height, 0]) square([width-(2*height), height]);
	       translate([width-height, 0]) {
		    intersection() {
			 square([height, height]);
			 circle(r=height);
		    }
	       }
	  }
	  translate([width/2, height/2]) {
	       translate([-spacing, 0]) lamp_hole();
	       PIR_hole();
	       translate([spacing, 0]) lamp_hole();
	  }
     }
}

module bracket() {
     union() {
	  intersection() {
	       translate([bracket_height, 0]) rotate([0,0,45]) square([height,height]);
	       square([bracket_height, bracket_height]);
	  }
	  translate([bracket_height*2 + board_frame_depth, 0]) {
	       intersection() {
		    rotate([0,0,45]) translate([-height, 0])
			 square([height,height]);
		    translate([-bracket_height, 0])
			 square([bracket_height, bracket_height]);
	       }
	  }
	  translate([bracket_height, 0])
	       square([board_frame_depth, bracket_height]);
	  translate([bracket_height+board_frame_depth, - board_frame_depth])
	       square([bracket_height, board_frame_depth]);
	  translate([bracket_height+board_frame_depth+(5+thickness), - (board_frame_depth + height)])
	       square([bracket_height-(5+thickness), height]);
     }
}

slide_in_width = 20;
slide_in_margin = 5;

module slide_in_plate(adjust) {
     translate([0, -adjust/2]) square([height+adjust, slide_in_width+adjust]);
}

module slide_in_rect() {
	  square([height+slide_in_margin, slide_in_width+2*slide_in_margin]);
}

module slide_in_cover() {
     difference() {
	  slide_in_rect();
	  translate([0,
		     /* todo: put in variable from slide_in_rect */
		     /* todo: shorten those pieces of the brackets */
			 ]) square([slide_in_length, thickness]);
	  }
}

module slide_in_surround() {
     difference() {
	  slide_in_rect();
	  translate([0, slide_in_margin]) slide_in_plate(+.5);
     }
}

frontage();
translate([265, 28]) rotate([180,0,90]) bracket();
translate([35, 28]) rotate([0,0,90]) bracket();
translate([50,120]) lamp_support_arch();
translate([width-50,120]) lamp_support_arch();
translate([135,52]) rotate([0,0,90]) {
     slide_in_surround();
     translate([0, slide_in_margin]) slide_in_plate(-.5);
}
translate([167,52]) rotate([0,0,90]) {
     slide_in_surround();
     translate([0, slide_in_margin]) slide_in_plate(-.5);
}
translate([49,51]) {
      slide_in_cover();
}
translate([width-(49+height),51]) {
      slide_in_cover();
}
