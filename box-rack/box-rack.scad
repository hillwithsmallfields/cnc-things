/* Not actually for CNC! */

box_offset = 400;

beam_width = 63;
beam_depth = 38;
beam_length = 2400;

height = beam_length;
depth = 478;
width = 4 * box_offset + 2 * (beam_width + beam_depth);

echo("width is", width);
echo("offcut is", beam_length - (width + depth));

boxes = floor((width - (2*(beam_width+beam_depth))) / box_offset);

box_height = 308;
shelf_thickness = 25;

tweak = 4;
level_offset = box_height + shelf_thickness + beam_width + tweak;
echo("level offset is", level_offset);
levels = floor(height / level_offset);

trimmed_height = (levels - 0.5) * level_offset;

with_shelves = true;

flat_used = with_shelves ? shelf_thickness : 0;

echo("trimmed height is", trimmed_height, "so trim", height - trimmed_height, "from uprights");

color("red") {
     translate([beam_width, 0, 0])
          cube([beam_depth, beam_width, trimmed_height]);
     translate([width - (beam_width + beam_depth), 0, 0])
          cube([beam_depth, beam_width, trimmed_height]);
     translate([beam_width, depth-beam_width, 0])
          cube([beam_depth, beam_width, trimmed_height]);
     translate([width - (beam_width + beam_depth), depth-beam_width, 0])
          cube([beam_depth, beam_width, trimmed_height]);
}

for (i=[0:levels-1]) {
     translate([0, 0, i * level_offset]) {
          color("blue") {
               cube([beam_width, depth, beam_depth]);
               translate([width-beam_width, 0, 0]) cube([beam_width, depth, beam_depth]);
          }

          color("green") {
               translate([0, beam_width, beam_depth])
                    cube([width, beam_depth, beam_width]);
               translate([0, depth - (beam_width+beam_depth), beam_depth])
                    cube([width, beam_depth, beam_width]);
          }

          if (with_shelves)
               color("yellow")
                    translate([beam_width+beam_depth, 0, beam_width+beam_depth])
                    cube([width - 2 * (beam_width+beam_depth), depth, shelf_thickness]);
     }
     
     translate([beam_width + beam_depth, 0, flat_used + beam_width + beam_depth + i * level_offset])
          for (j=[0:boxes-1])
               translate([j*box_offset, 0, 0])
                    if (i % 2 == 0) {
                         box(i, j);
                    } else {
                         crate(i, j);
                    }
                                     
}

module box(col0, col1) {
     color([col0/6, col1/4, 0.5, 0.25])
          cube([388, 478, box_height]);
}

module crate(col0, col1) {
     color([col0/6, col1/4, 0.5, 0.25])
          cube([346, 478, 238]);
}
