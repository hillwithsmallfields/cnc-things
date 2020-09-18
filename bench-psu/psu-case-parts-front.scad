include <psu-dimensions.scad>

module switch_centred(is_outer) {
     sw_h = is_outer ? switch_height : switch_backing_height;
     translate([-switch_width/2, -sw_h/2]) square([switch_width, sw_h]);
}

module meter_centred(is_outer) {
     mt_h = is_outer ? meter_height : meter_backing_height;
     mt_w = is_outer ? meter_width : meter_backing_width;
     translate([-mt_w/2, -mt_h/2]) square([mt_w, mt_h]);
}

module meter_and_switch_cutout(is_outer) {
     meter_and_switch_layout() {
           switch_centred(is_outer);
           meter_centred(is_outer);
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
     upper_front_layout(true) {
              square([adjuster_width_outer, adjuster_height_outer]);
              meter_centred(true);
     };
}

module front_dividers() {
     for (i=[1:sections-1]) {
          translate([i * section_width, margin]) {
               square([3, total_height - margin*2]);
          }
     }
}

module one_inner_front_cutout() {
     translate([half_section_width, meter_and_switch_offset_from_base + meter_and_switch_height/2]) {
          meter_and_switch_cutout(false);
     }
}

module inner_front_cutouts() {
     for (i=[0:sections-1]) {
          translate([i * section_width, 0]) {
               one_inner_front_cutout();
          }
     }
     upper_front_layout(false) {
          square([adjuster_width_inner, adjuster_height_inner]);
          meter_centred(false);
     };
     translate([(total_width - adjuster_width_inner)/2, adjuster_y_centre - adjuster_height_inner/2]) {
     }
     assembly_bracket_slots(total_width);
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
