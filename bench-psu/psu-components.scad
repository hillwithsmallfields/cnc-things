include <psu-dimensions.scad>

module psu12v_boltholes() {
     translate([32, 32]) circle(r=2);
     translate([psu12v_length-32, 32]) circle(r=2);
     translate([32, psu12v_width-32]) circle(r=2);
     translate([psu12v_length-32, psu12v_width-32]) circle(r=2);
}

module psu12v_flat() {
     difference() {
	  square([psu12v_length, psu12v_width]);
          psu12v_boltholes();
     }
}

module psu12v() {
     color("cyan", 0.5) linear_extrude(height=psu12v_height) psu12v_flat();
     translate([psu12v_length/2, psu12v_width/2, psu12v_height])
          text("12v switching PSU", halign="center", valign="center");
}

module psu5v_boltholes() {
     translate([2, 7.5]) circle(r=2);
     translate([psu5v_length-4, psu5v_width-7]) circle(r=2);
}
     
module psu5v_flat() {
     difference() {
	  square([psu5v_length, psu5v_width]);
          psu5v_boltholes();
     }
}

module psu5v() {
     color("magenta", 0.5) linear_extrude(height=psu5v_height) psu5v_flat();
     translate([psu5v_length/2, psu5v_width/2, psu5v_height])
          text("5v switching PSU", halign="center", valign="center");
}

module psu36v_boltholes() {
     translate([psu36v_hole_offset_shorter_side,
                psu36v_hole_offset_longer_side]) circle(r=2);
     translate([psu36v_length-psu36v_hole_offset_shorter_side,
                psu36v_hole_offset_longer_side]) circle(r=2);
     translate([psu36v_hole_offset_shorter_side,
                psu36v_width-psu36v_hole_offset_longer_side]) circle(r=2);
     translate([psu36v_length-psu36v_hole_offset_shorter_side,
                psu36v_width-psu36v_hole_offset_longer_side]) circle(r=2);
}

module psu36v_flat() {
     difference() {
	  square([psu36v_length, psu36v_width]);
          psu36v_boltholes();
     }
}

module psu36v() {
     color("yellow", 0.5) linear_extrude(height=psu36v_height) psu36v_flat();
     translate([psu36v_length/2, psu36v_width/2, psu36v_height]) text("36v PSU", halign="center", valign="center");
}

module adjuster() {
     translate([-adjuster_width_inner/2, 0, -adjuster_height_inner/2]) {
          color("green") cube([adjuster_width_inner, adjuster_depth, adjuster_height_inner]);
     }
}

module mains_switch() {
     translate([-switch_width/2, -switch_height/2]) {
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
}

module panel_meter() {
     translate([-meter_width/2, -meter_height/2]) {
          color("grey") union() {
               cube([meter_width, meter_depth, meter_height]);
               translate([-panel_lip_width, -panel_lip_depth, -panel_lip_width]) {
                    cube([meter_width + panel_lip_width * 2, panel_lip_depth, meter_height + panel_lip_width * 2]);
               }
          }
     }
}

module meter_and_switch() {
     meter_and_switch_layout() {
          mains_switch();
          panel_meter();
     }
}

module one_front_components() {
     translate([half_section_width, 0, meter_and_switch_offset_from_base])
          meter_and_switch();
}

module front_components() {
     for (i=[0:sections-1]) {
          translate([i * section_width, 0]) {
               one_front_components();
          }
     }
     translate([total_width/2, 0, adjuster_y_centre]) adjuster();
}

module base_mounting_component_positioning() {
     psu5v_offset_from_12v = - (psu5v_width + gap_around_components);
     psu36v_offset_from_12v = - (psu36v_width + gap_around_components);
     translate([((total_width - psu12v_length - inner_thickness) / 2),
                total_depth - inner_thickness - gap_around_components - psu12v_width]) {
          children(0);
          translate([-inner_thickness, psu5v_offset_from_12v]) {
               children(1);
          }
          translate([psu5v_length + gap_around_components - inner_thickness, psu36v_offset_from_12v]) {
               children(2);
          }
     }
}

module internal_components() {
     translate([0, 0, top_of_base]) {
          translate([outer_thickness, outer_thickness]) {
               base_mounting_component_positioning() {
                    psu12v();
                    psu5v();
                    psu36v();
               }
          }
     }
     translate([0, 0, top_of_lower_base]) {
          front_components();
     }
}

