include <psu-dimensions.scad>

module meter_and_switch_cutout(is_outer) {
    translate([-meter_and_switch_width/2, -meter_and_switch_height/2]) {
        square([switch_width, is_outer ? switch_height : switch_backing_height]);
        translate([switch_width + meter_switch_gap, (switch_height - meter_height)/2]) {
            square([meter_width, meter_height]);
        }
    }
}

module one_outer_front_cutout(with_text, volt_label) {
     translate([half_section_width, meter_and_switch_offset_from_base + meter_and_switch_height/2]) {
          meter_and_switch_cutout(true);
     }
     if (with_text) {
          translate([half_section_width, 12]) text(volt_label, halign="center", size=18);
     }
}

module one_outer_top_cutout(with_text, volt_label) {
     translate([0, binding_post_offset]) {
          for (i=[1:binding_post_rows]) {
               if (i != binding_post_rows-2) {
                    translate([half_section_width, i * binding_post_row_spacing]) {
                         binding_post_hole_pair(binding_post_hole_outer_diameter, binding_post_spacing, false);
                    }
               }
          }
          if (with_text) {
               translate([half_section_width,-binding_post_row_spacing]) text(volt_label, halign="center", size=18);
               translate([half_section_width,binding_post_row_spacing * (binding_post_rows + 1)]) text(volt_label, halign="center", size=18);
          }
     }
}

module outer_top_cutouts(with_text) {
     translate([0, outer_thickness]) {
          for (i=[0:sections]) {
               translate([i * section_width, 0]) {
                    one_outer_top_cutout(with_text, voltages[i]);
               }
          }
     }
}

module top_dividers() {
     for (i=[1:sections-1]) {
          translate([i * section_width, margin]) {
               square([3,total_depth - margin*2]);
          }
     }
}

module outer_front_cutouts(with_text) {
     for (i=[0:sections]) {
          translate([i * section_width, 0]) {
               one_outer_front_cutout(with_text, voltages[i]);
          }
     }
     translate([(total_width - adjuster_width_outer)/2, adjuster_y_centre - adjuster_height_outer/2]) {
          square([adjuster_width_inner, adjuster_height_inner]);
     }
}

module front_dividers() {
     for (i=[1:sections-1]) {
          translate([i * section_width, margin]) {
               square([3, total_height - margin*2]);
          }
     }
}

module outer_top_flat() {
     difference() {
          square([total_width, total_depth + outer_thickness]);
          outer_top_cutouts(false);
     }
}

module outer_top() {
     color("cyan", outer_alpha) {
          linear_extrude(height=outer_thickness) {
               outer_top_flat();
          }
     }
}

module outer_front_flat() {
     difference() {
          square([total_width, total_height]);
          outer_front_cutouts(false);
     }
}

module outer_front() {
     color("cyan", outer_alpha) {
          linear_extrude(height=outer_thickness) {
               outer_front_flat();
          }
     }
}
