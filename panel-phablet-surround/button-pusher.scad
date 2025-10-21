/* plastic piece to push power button */

panel_depth = 25;
protrusion = 5;

length = panel_depth + protrusion;

hole_width = 11;
recess_width = 15;
recess_depth = 10;

module pusher() {
     union() {
          square([hole_width, length]);
          square([recess_width, recess_depth]);
     }
}

pusher();
translate([recess_width+12, length*2]) rotate(180)  translate([0, length]) pusher();
