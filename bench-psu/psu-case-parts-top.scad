include <psu-dimensions.scad>

module usb_inner_panel() {
     translate([-usb_inner_panel_width/2, -usb_inner_panel_depth/2]) {
          square([usb_inner_panel_width, usb_inner_panel_depth]);
     }
}

module usb_outer_panel() {
     translate([-usb_outer_panel_width/2, -usb_outer_panel_depth/2]) {
          square([usb_outer_panel_width, usb_outer_panel_depth]);
     }
}

module binding_post_hole_pair(diameter, spacing, join) {
     translate([-spacing/2, 0]) circle(d=diameter);
     translate([spacing/2, 0]) circle(d=diameter);
     if (join) {
         translate([-spacing/2, -diameter/2]) square([spacing, diameter]);
     }
}

module one_outer_top_cutout(with_text, volt_label) {
     translate([0, binding_post_offset]) {
          for (i=[1:binding_post_rows]) {
               if (i != binding_post_rows-2 && i != binding_post_rows-3  && i != binding_post_rows-4) {
                    translate([half_section_width, i * binding_post_row_spacing]) {
                         binding_post_hole_pair(binding_post_hole_outer_diameter, binding_post_spacing, false);
                    }
               }
          }
          if (with_text) {
               translate([half_section_width,-binding_post_row_spacing/2]) text(volt_label, halign="center", size=18);
               translate([half_section_width,binding_post_row_spacing * (binding_post_rows+.5)]) text(volt_label, halign="center", size=18);
          }
     }
}

module one_inner_top_cutout() {
     translate([0, binding_post_offset]) {
          for (i=[1:binding_post_rows]) {
               if (i != binding_post_rows-2 && i != binding_post_rows-3 && i != binding_post_rows-4) {          
                    translate([half_section_width, i * binding_post_row_spacing]) {
			 binding_post_hole_pair(binding_post_hole_inner_diameter, binding_post_spacing, true);
		    }
               }
          }
     }
}

automotive_sockets_x_offset = -6;

module automotive_sockets_cutout() {
     translate([half_section_width - din_power_socket_hole_diameter, 0]) circle(d=din_power_socket_hole_diameter);
     translate([half_section_width + lighter_socket_hole_diameter, 0]) circle(d=lighter_socket_hole_diameter);
}

module outer_top_cutouts(with_text) {
     translate([0, outer_thickness]) {
          for (i=[0:sections]) {
               translate([i * section_width, 0]) {
                    one_outer_top_cutout(with_text, voltages[i]);
               }
          }
     }
     if (with_text) {
          translate([total_width/2, binding_post_row_spacing*4.75]) text("METERED", halign="center", size=18);
          translate([total_width/2, binding_post_row_spacing*6.75]) text("UNMETERED", halign="center", size=18);
     }

     translate([section_width * 2 + automotive_sockets_x_offset, binding_post_row_spacing*6]) automotive_sockets_cutout();

     translate([usb_panel_from_side, binding_post_row_spacing*6]) usb_outer_panel();
}

module inner_top_cutouts() {
     for (i=[0:sections-1]) {
          translate([i * section_width, 0]) {
               one_inner_top_cutout();
          }
     }
     translate([section_width * 2 + automotive_sockets_x_offset, binding_post_row_spacing*6-outer_thickness]) automotive_sockets_cutout();

     translate([usb_panel_from_side, binding_post_row_spacing*6]) usb_inner_panel();
}

module top_dividers() {
     for (i=[1:sections-1]) {
          translate([i * section_width, margin]) {
               translate([0, binding_post_row_spacing*0]) square([3,binding_post_row_spacing*4]);
               translate([0, binding_post_row_spacing*7]) square([3,binding_post_row_spacing*3]);
          }
     }
}

module usb_x_1() {
     translate([-usb_length/2, -usb_width/2]) square([usb_length, usb_width]);
}

module usb_x_4() {
     half_usb_h_spacing = usb_length*2/3;
     half_usb_v_spacing = usb_width;
     translate([-half_usb_h_spacing, -half_usb_v_spacing]) usb_x_1();
     translate([-half_usb_h_spacing, half_usb_v_spacing]) usb_x_1();
     translate([half_usb_h_spacing, -half_usb_v_spacing]) usb_x_1();
     translate([half_usb_h_spacing, half_usb_v_spacing]) usb_x_1();
}

module outer_top_flat() {
     union() {
          difference() {
               square([total_width, total_depth + outer_thickness]);
               outer_top_cutouts(false);
          }
          color("red") translate([usb_panel_from_side, binding_post_row_spacing*6]) usb_x_4();
     }
}

module outer_top() {
//     color("cyan", outer_alpha) {
          linear_extrude(height=outer_thickness) {
               outer_top_flat();
          }
//     }
}
