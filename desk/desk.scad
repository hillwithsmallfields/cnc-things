/* dimensions in inches */

top_width = 60;
top_depth = 30;
top_thickness = .75;

leg_length = 29;
leg_thickness = 1.25;

overhang = 1.25;

plinth_bottom = 9;
plinth_height = leg_length - plinth_bottom;
plinth_depth = 27;
plinth_width = 16;
plinth_wall = .75;

payload_width = 23;
payload_height = 17;
payload_depth = 5;

extension_depth = 6;
extension_payload_holder_width = payload_width + 1;
extension_payload_holder_height = payload_height + 1;
extension_support_length = leg_length - 1;
extension_support_thickness = 1;

module leg() {
     cube(size=[leg_thickness, leg_thickness, leg_length]);
}

module top() {
     cube(size=[top_depth, top_width, top_thickness]);
}

module plinth() {
     union() {
	  leg();
	  translate([plinth_depth-leg_thickness, 0, 0]) leg();
	  translate([0, plinth_width-leg_thickness, 0]) leg();
	  translate([plinth_depth-leg_thickness, plinth_width-leg_thickness, 0]) leg();
	  translate([0,0,plinth_bottom]) {
	       difference() {
		    cube(size=[plinth_depth, plinth_width, plinth_height]);
		    translate([plinth_wall, plinth_wall, 0]) {
			 cube(size=[plinth_depth-2*plinth_wall,
				    plinth_width-2*plinth_wall,
				    plinth_height]);

		    }
	       }
	  }
     }
}

module desk() {
     union() {
	  translate([overhang, overhang, 0]) plinth();
	  translate([overhang, top_width - (plinth_width + overhang), 0]) plinth();
	  translate([0,0,leg_length]) top();
     }
}

module payload() {
     translate([0,(top_width-payload_width)/2, leg_length-payload_height]) cube(size=[payload_depth, payload_width, payload_height]);
     }

module extension() {
     union() {
	  translate([0,0,leg_length]) cube(size=[extension_depth, top_width, top_thickness]);
	  translate([0,top_width/2 - ((extension_payload_holder_width / 2) + extension_support_thickness), leg_length - extension_support_length])
	       cube(size=[extension_depth, extension_support_thickness, extension_support_length]);
	  translate([0,top_width/2 + (extension_payload_holder_width / 2), leg_length - extension_support_length])
	       cube(size=[extension_depth, extension_support_thickness, extension_support_length]);
	  translate([0,top_width/2 - (extension_payload_holder_width / 2),leg_length-extension_payload_holder_height]) cube(size=[extension_depth, extension_payload_holder_width, top_thickness]);
     }

}

module extension_base() {
     union() {
	  translate([0,top_width/2 - ((extension_payload_holder_width / 2) + extension_support_thickness*2), 0])
	       cube(size=[extension_depth, extension_support_thickness, extension_support_length]);
	  translate([0,top_width/2 + ((extension_payload_holder_width / 2) + extension_support_thickness), 0])
	       cube(size=[extension_depth, extension_support_thickness, extension_support_length]);
	  translate([0,(top_width-extension_payload_holder_width-extension_support_thickness)/2, 0])
	       cube(size=[extension_depth, extension_payload_holder_width+extension_support_thickness*2, extension_support_thickness]);
     }
}

desk();
translate([top_depth, 0, 0]) extension_base();
raise = $t < 0.25 ? $t*4 : $t > 0.75 ? (1.0 - $t) * 4 : 1;
push_forward = ($t < 0.25 || $t > 0.75) ? 0 : ($t < 0.5 ? $t - 0.25 : 0.75 - $t);
translate([top_depth, 0, 0]) {
     translate([0,0,raise * extension_payload_holder_height]) {
	  extension();
	  translate([push_forward*-48,0,0])
	       payload();
     }
}
