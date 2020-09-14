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

module outer_front_cutouts(with_text) {
     for (i=[0:sections]) {
          translate([i * section_width, 0]) {
               one_outer_front_cutout(with_text, voltages[i]);
          }
     }
     translate([(total_width - adjuster_width_outer)/2, adjuster_y_centre - adjuster_height_outer/2]) {
          square([adjuster_width_inner, adjuster_height_inner]);
     }
     translate([assembly_bracket_tab_offset+outer_thickness, inner_thickness*2]) square([assembly_bracket_tab_length, inner_thickness]);
     translate([total_width - (assembly_bracket_tab_offset+outer_thickness+assembly_bracket_tab_length), inner_thickness*2]) square([assembly_bracket_tab_length, inner_thickness]);
}

module front_dividers() {
     for (i=[1:sections-1]) {
          translate([i * section_width, margin]) {
               square([3, total_height - margin*2]);
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
