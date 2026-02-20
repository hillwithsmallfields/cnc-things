/* Lids for the one-litre glass fridge jugs */
/* The original lids weren't very strong, and have started to fall apart. */

flange_thickness = 2;
flange_diameter = 76;
upper_diameter = 67;
upper_height = 20;
base_diameter = 60;
base_height = 17;

top_height = base_height + upper_height + flange_thickness;

sidewall_thickness = 5;
bottom_thickness = 5;

handle_diameter = 8;

scooped_radius = (upper_diameter - sidewall_thickness) / 2;

module outline() {
     polygon(points = [
                  [0, 0],
                  [base_diameter / 2, 0],
                  [base_diameter / 2, base_height],
                  [upper_diameter / 2, base_height + upper_height],
                  [flange_diameter / 2, base_height + upper_height],
                  [flange_diameter / 2, top_height],
                  [0, top_height],
                  [0, 0]
                  ]);}

module half_section() {
     difference() {
          outline();
          translate([0, bottom_thickness + scooped_radius]) circle(scooped_radius);
     }
}

module three_d() {
     intersection() {
          union() {
               rotate_extrude($fa = 1) {
                    half_section();
               }
               translate([-upper_diameter/2, 0, top_height]) {
                    rotate([0, 90, 0]) {
                         linear_extrude(height=upper_diameter) {
                              circle(d=handle_diameter);
                         }
                    } 
               }
          }
          rotate_extrude($fa = 1) {
               outline();
          }
     }
}

/* half_section(); */
three_d(); 
