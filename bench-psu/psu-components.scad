include <psu-dimensions.scad>

module psu12v() {
     color("cyan") cube([psu12v_length, psu12v_width, psu12v_height]);
}

module psu5v() {
     color("magenta") cube([psu5v_length, psu5v_width, psu5v_height]);
}

module psu36v() {
     color("yellow") cube([psu36v_length, psu36v_width, psu36v_height]);
}

module adjuster() {
     color("green") cube([adjuster_width, adjuster_depth, adjuster_height]);
}

module mains_switch() {
     color("grey") union() {
          cube([switch_width, switch_depth, switch_height]);
          translate([-panel_lip_width, -panel_lip_depth, -panel_lip_width]) {
               cube([switch_width + panel_lip_width * 2, panel_lip_depth, switch_height + panel_lip_width * 2]);
          }
     }
     translate([(switch_width - rocker_width) / 2, -rocker_depth, (switch_height - rocker_height) / 2]) {
          color("red") {
               cube([rocker_width, rocker_depth, rocker_height]);
          }
     }
}

module panel_meter() {
     color("grey") union() {
          cube([meter_width, meter_depth, meter_height]);
          translate([-panel_lip_width, -panel_lip_depth, -panel_lip_width]) {
               cube([meter_width + panel_lip_width * 2, panel_lip_depth, meter_height + panel_lip_width * 2]);
          }
     }
}

module meter_and_switch() {
    translate([-meter_and_switch_width/2, 0, -meter_and_switch_height/2]) {
        mains_switch();
        translate([switch_width + meter_switch_gap, (switch_height - meter_height)/2]) {
            panel_meter();
        }
    }
}

module one_front_components() {
     translate([half_section_width, 0, meter_and_switch_offset_from_base + meter_and_switch_height/2]) meter_and_switch();
}

module front_components() {
     for (i=[0:sections-1]) {
          translate([i * section_width, 0]) {
               one_front_components();
          }
     }
     translate([(total_width - adjuster_width)/2, 0, adjuster_y_offset]) adjuster();
}

module internal_components() {
     psu12v_offset_from_front = total_depth - gap_around_components - psu12v_width;
     psu5v_offset_from_12v = - (psu5v_width + gap_around_components);
     psu36v_offset_from_12v = - (psu36v_width + gap_around_components);
     translate([0, 0, top_of_base]) {
          translate([gap_around_components, psu12v_offset_from_front]) {
               psu12v();
               translate([0, psu5v_offset_from_12v]) {
                    psu5v();
               }
               translate([psu5v_length + gap_around_components, psu36v_offset_from_12v]) {
                    psu36v();
               }
          }
     }
     translate([0, 0, top_of_lower_base]) {
          front_components();
     }
}

