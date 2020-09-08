include <psu-dimensions.scad>

module lower_base() {
     cube([total_width,
           total_depth,
           outer_thickness],
          center=false);
}

module upper_base() {
     translate([outer_thickness, outer_thickness]) {
          cube([total_width-2*inner_thickness,
                total_depth-2*inner_thickness,
                inner_thickness],
               center=false);
     }
}

module base() {
     color("green", 2/3) translate([0, 0, outer_thickness]) upper_base();
     color("red", 1/3) lower_base();
}

module binding_post_hole_pair(diameter, spacing, join) {
     translate([-spacing/2, 0]) circle(d=diameter);
     translate([spacing/2, 0]) circle(d=diameter);
     if (join) {
         translate([-spacing/2, -diameter/2]) square([spacing, diameter]);
     }
}

module meter_and_switch_cutout() {
    translate([-meter_and_switch_width/2, -meter_and_switch_height/2]) {
        square([switch_width, switch_height]);
        translate([switch_width + meter_switch_gap, (switch_height - meter_height)/2]) {
            square([meter_width, meter_height]);
        }
    }
}

module one_outer_front_cutout(volt_label) {
     translate([half_section_width, total_height-(meter_and_switch_height + margin)]) meter_and_switch_cutout();
     translate([12, 12]) text(volt_label);
}

module one_outer_top_cutout(volt_label) {
     translate([0, binding_post_offset]) {
          for (i=[1:binding_post_rows]) {
               translate([half_section_width, (i + 1) * binding_post_row_spacing]) {
                    if (i != binding_post_rows-2) {
                         binding_post_hole_pair(binding_post_hole_outer_diameter, binding_post_spacing, false);
                    }
               }
          }
          translate([12,binding_post_row_spacing]) text(volt_label);
          translate([12,binding_post_row_spacing * (binding_post_rows + 1.5)]) text(volt_label);
     }
}

module outer_top_cutouts() {
     translate([0, outer_thickness]) {
          for (i=[0:sections]) {
               translate([i * section_width, 0]) {
                    one_outer_top_cutout(voltages[i]);
               }
          }
     }
}

module top_dividers() {
     for (i=[1:sections-1]) {
          translate([i * section_width, margin]) {
               cube([3,total_depth - margin*2, outer_thickness]);
          }
     }
}

module outer_front_cutouts() {
     for (i=[0:sections]) {
          translate([i * section_width, 0]) {
               one_outer_front_cutout(voltages[i]);
          }
     }
}

module front_dividers() {
     for (i=[1:sections-1]) {
          translate([i * section_width, margin]) {
               cube([3, total_height - margin*2, outer_thickness]);
          }
     }
}

module outer_top() {
     difference() {
          cube([total_width, total_depth, outer_thickness]);
          outer_top_cutouts();
          top_dividers();
     }
}

module outer_front() {
     difference() {
          cube([total_width, total_height, outer_thickness]);
          outer_front_cutouts();
          front_dividers();
     }
}
