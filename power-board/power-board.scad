/* Tufnol board for protection diode and current sensors for my Land Rover. */

board_thickness = 9;
board_stock_height = 200;
board_stock_width = 100;
cutting_margin = 5;
board_height = board_stock_height - (2 * cutting_margin);
board_width = board_stock_width - (2 * cutting_margin);

sensor_height = 44;
sensor_width = 32;
sensor_bolt_spacing = 29;
sensor_bolt_x_offset = 7;
sensor_bolt_y_offset = (sensor_height - sensor_bolt_spacing) / 2;

sensor_wires_start = 10;
sensor_wires_end = 20;
sensor_wires_inset = 5;
sensor_wires_length = 20;

sensor_base_depth = 3;

gap_between_sensors = 25;

diagram_spacing = 75;

diode_input_x = 25;
diode_input_y = board_height - 30;

diode_bolt_spacing = 27;
diode_top_bolt_offset = 7.5;

diode_length = 42;
diode_width = 16;

arduino_height = 1.4 * 25.4;
arduino_width = 0.8 * 25.4;

arduino_x_position = board_width - (arduino_width + 10);
arduino_y_position = 35;

ubec_height = 2 * 25.4;
ubec_width = 1 * 25.4;

ubec_x_position = board_width - (ubec_width + 10);
ubec_y_position = 100;

bolt_length = 30;
bolt_diameter = 6;
bolt_head_diameter = 15;

cable_width = 11;

mounting_hole_offset = 12.5;

wiring_channel_width = 20;
wiring_channel_length = 100;

wiring_channel_x_position = arduino_x_position;
wiring_channel_y_position = arduino_y_position;


module one_board()
{
     translate([cutting_margin, cutting_margin]) {
	  difference() {
	       cube(size=[board_width, board_height, board_thickness]);
	       translate([mounting_hole_offset, mounting_hole_offset])
		    cylinder(h=board_thickness, r=bolt_diameter/2);
	       translate([board_width - mounting_hole_offset, mounting_hole_offset])
		    cylinder(h=board_thickness, r=bolt_diameter/2);
	       translate([mounting_hole_offset, board_height - mounting_hole_offset])
		    cylinder(h=board_thickness, r=bolt_diameter/2);
	       translate([board_width - mounting_hole_offset, board_height - mounting_hole_offset])
		    cylinder(h=board_thickness, r=bolt_diameter/2);
	  }
     }
}

module bolt_cutout(size, with_wire)
{
     union() {
	  cylinder(h=board_thickness*2, r=size/2, center=true);
	  if (with_wire) {
	       translate([0, cable_width/2, 0]) {
		    rotate([0,0,180]) {
			 cube(size=[board_width, cable_width, board_thickness]);
		    }
	       }
	  }
     }
}

module diode_cutout()
{
     translate([-diode_width / 2, - (diode_length - diode_top_bolt_offset)]) {
	  cube(size=[diode_width, diode_length, board_thickness]);
     }
}

module sensor_cutout()
{
     translate([-sensor_bolt_x_offset, -sensor_height+sensor_bolt_y_offset])
	  cube(size=[sensor_width, sensor_height, board_thickness]);
}

module arduino_cutout()
{
     cube(size=[arduino_width, arduino_height, board_thickness]);
}

module ubec_cutout()
{
     cube(size=[ubec_width, ubec_height, board_thickness]);
}

module base_board()
{
     one_board();
}

module holes_board(hole_size, with_wires)
{
     difference() {
	  one_board();
	  translate([diode_input_x, diode_input_y]) {
	       bolt_cutout(hole_size, with_wires);
	       translate([0, -diode_bolt_spacing]) {
		    bolt_cutout(hole_size, false);
		    translate([0,-sensor_bolt_spacing]) {
			 bolt_cutout(hole_size, with_wires);
			 translate([0,-gap_between_sensors]) {
			      bolt_cutout(hole_size, with_wires);
			      translate([0, -sensor_bolt_spacing]) {
				   bolt_cutout(hole_size, with_wires);
			      }
			 }
		    }
	       }
	  }
     }
     }

module lower_board()
{
     holes_board(bolt_head_diameter, true);
}

module middle_board()
{
     difference() {
	  holes_board(bolt_diameter, false);
	  translate([wiring_channel_x_position, wiring_channel_y_position])
	       cube(size=[wiring_channel_width, wiring_channel_length, board_thickness]);
	  translate([diode_input_x
		     + sensor_width
		     - sensor_bolt_x_offset,
		     diode_input_y +
		     sensor_bolt_y_offset
		     - diode_bolt_spacing]) {
	       translate([-sensor_wires_inset, -sensor_wires_end]) {
		    cube(size=[sensor_wires_length,
			       sensor_wires_end - sensor_wires_start,
			       board_thickness]);
	       }
	       translate([0, -(sensor_bolt_spacing + gap_between_sensors)]) {
		    translate([-sensor_wires_inset, -sensor_wires_end]) {
			 cube(size=[sensor_wires_length,
				    sensor_wires_end - sensor_wires_start,
				    board_thickness]);
		    }
	       }
	  }
     }
}

module upper_board()
{
     difference() {
	  one_board();
	  translate([diode_input_x, diode_input_y]) {
	       bolt_cutout();
	       diode_cutout();
	       translate([0, -diode_bolt_spacing]) {
		    sensor_cutout();
		    translate([0,-sensor_bolt_spacing]) {
			 translate([0,-gap_between_sensors]) {
			      sensor_cutout();
			 }
		    }
	       }
	  }
	  translate([arduino_x_position, arduino_y_position]) arduino_cutout();
	  translate([ubec_x_position, ubec_y_position]) ubec_cutout();
     }
}

solid = true;

if (solid) {
     base_board();
     translate([0,0,diagram_spacing]) lower_board();
     translate([0,0,2*diagram_spacing]) middle_board();
     translate([0,0,3*diagram_spacing]) upper_board();
} else {
     projection() base_board();
     translate([board_stock_width, 0]) projection() lower_board();
     translate([board_stock_width * 2, 0]) projection() middle_board();
     translate([board_stock_width * 3, 0]) projection() upper_board();
}
