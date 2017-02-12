/* Tufnol board stack for protection diode and current sensors for my Land Rover.

   This takes the power in from the alternator (via a Schottky diode
   to prevent backfeed from the battery, as I once nearly had a faulty
   alternator nearly catch fire because of backfeed), and measures the
   current at two points: from the alternator to the battery, and from
   the battery to the vehicle (apart from the starter motor).

   An isolator switch comes between the input and output sections,
   making it easy to cut off the power to almost all the vehicle
   circuits (apart from those run from the auxiliary / leisure
   battery).

   The sensor boards are the 100A Hall effect sensors readily
   available online, and the Arduino is an Arduino Pro Mini.  The
   program for the Arduino is in power-board.ino in the same directory
   as this OpenSCAD file.  It is set up to measure the current in and
   out of the battery, the system voltage, and to use 'one-wire'
   digital temperature sensors to monitory the temperature of the
   system.  It displays all these on a 2-line LCD display, which is
   connected via a D15 connector.
 */

board_thickness = 9;
board_stock_height = 200;
board_stock_width = 100;

/* For cutting on a CNC router, as the plastic I'm using isn't allowed
 * in my local hackerspace's laser cutter */
cutting_margin = 5;

board_height = board_stock_height - (2 * cutting_margin);
board_width = board_stock_width - (2 * cutting_margin);

/* The Hall effect current sensor boards */
sensor_height = 45;
sensor_width = 33;
/* The bolts for the power connections */
sensor_bolt_spacing = 29;
sensor_bolt_x_offset = 7;
sensor_bolt_y_offset = (sensor_height - sensor_bolt_spacing) / 2;
/* The sensor connections to the Arduino */
sensor_wires_start = 10;
sensor_wires_end = 23;
sensor_wires_inset = 3;
sensor_wires_length = 20;

gap_between_sensors = 25;

/* How far to separate the layers on the exploded diagram of the
 * stack; not part of the actual design */
diagram_spacing = 75;

/* We start the positioning of the power chain components from where
 * the current comes in, and work our way down relative to that */
diode_input_x = 25;
diode_input_y = board_height - 30;

diode_bolt_spacing = 27;
diode_top_bolt_offset = 7.5;

diode_length = 42;
diode_width = 16;

arduino_height = 1.4 * 25.4;
arduino_width = 0.8 * 25.4;

arduino_x_position = board_width - (arduino_width + 10);
arduino_y_position = 25;

D15_height = 10;
D15_width = 27;
D15_bolt_hole_spacing = 33;

D15_x_position = (arduino_x_position - D15_width) / 2;
D15_y_position = arduino_y_position;

D15_wire_access_slot_width = 4;

stripboard_width = 26;
stripboard_length = 33;

stripboard_x_position = arduino_x_position;
stripboard_y_position = arduino_y_position + arduino_height + 15;

/* We use a UBEC (switch-mode voltage dropper) to power the logic */
ubec_height = 2 * 25.4;
ubec_width = 1 * 25.4;

ubec_x_position = board_width - (ubec_width + 10);
ubec_y_position = board_height - (15 + ubec_height);

/* The bolts that make the power connections */
bolt_length = 30;
bolt_diameter = 6.2;
bolt_head_diameter = 16;

/* Make it wide enough for the ring connector too */
power_cable_slot_width = 13;

/* The holes for bolting the stack together, and for bolting it into
 * place in the vehicle */
mounting_hole_offset = 12.5;

/* Two cutouts in the layer below the component layer, for running the
 * internal wiring */
long_wiring_channel_width = 20;
long_wiring_channel_length = 150;

long_wiring_channel_x_position = arduino_x_position;
long_wiring_channel_y_position = arduino_y_position;

side_wiring_channel_width = 10;
side_wiring_channel_length = 50;

side_wiring_channel_x_position = arduino_x_position - side_wiring_channel_length;
side_wiring_channel_y_position = arduino_y_position;

rounded = true;

/* The common part of all the boards in the stack */
module one_board()
{
     translate([cutting_margin, cutting_margin]) {
	  difference() {
	       if (rounded) {
		    union() {
			 translate([mounting_hole_offset, 0]) cube(size=[board_width - 2 * mounting_hole_offset, board_height, board_thickness]);
			 translate([0, mounting_hole_offset]) cube(size=[board_width, board_height - 2 * mounting_hole_offset, board_thickness]);
			 translate([mounting_hole_offset, mounting_hole_offset, 0]) cylinder(h = board_thickness, r = mounting_hole_offset);
			 translate([board_width - mounting_hole_offset, mounting_hole_offset]) cylinder(h = board_thickness, r = mounting_hole_offset);
			 translate([board_width - mounting_hole_offset, board_height - mounting_hole_offset, 0]) cylinder(h = board_thickness, r = mounting_hole_offset);
			 translate([mounting_hole_offset, board_height - mounting_hole_offset]) cylinder(h = board_thickness, r = mounting_hole_offset);
		    }
	       } else {
		    cube(size=[board_width, board_height, board_thickness]);
	       }
	       
	       /* corner holes to hold it together */
	       translate([mounting_hole_offset, mounting_hole_offset])
		    cylinder(h=board_thickness, r=bolt_diameter/2);
	       translate([board_width - mounting_hole_offset, mounting_hole_offset])
		    cylinder(h=board_thickness, r=bolt_diameter/2);
	       translate([mounting_hole_offset, board_height - mounting_hole_offset])
		    cylinder(h=board_thickness, r=bolt_diameter/2);
	       translate([board_width - mounting_hole_offset, board_height - mounting_hole_offset])
		    cylinder(h=board_thickness, r=bolt_diameter/2);

	       /* central holes to mount it */
	       translate([board_width / 2, mounting_hole_offset])
		    cylinder(h=board_thickness, r=bolt_diameter/2);
	       translate([board_width / 2, board_height - mounting_hole_offset])
		    cylinder(h=board_thickness, r=bolt_diameter/2);
	  }
     }
}

/* The cutout for one power bolt and its cable; the cable is optional,
 * as the bolt joining the input diode and the incoming current sensor
 * doesn't have a cable of its own, as it's fed from the diode */
module bolt_cutout(size, with_wire)
{
     union() {
	  cylinder(h=board_thickness*2, r=size/2, center=true);
	  if (with_wire) {
	       translate([0, power_cable_slot_width/2, 0]) {
		    rotate([0,0,180]) {
			 cube(size=[board_width, power_cable_slot_width, board_thickness]);
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

module D15_cutout()
{
     /* This could be a proper D-connector shape, but I don't need
      * that level of detail (and don't want to constrain which was
      * round the connector can fit) */
     cube(size=[D15_width, D15_height, board_thickness]);
     translate([(D15_bolt_hole_spacing - D15_width) / -2, D15_height / 2]) {
	  cylinder(h=board_thickness, r = 2);
	  translate([D15_bolt_hole_spacing, 0])
	       cylinder(h=board_thickness, r = 2);
     }
     translate([(D15_width - D15_wire_access_slot_width) / 2, D15_height])
	  cube(size=[D15_wire_access_slot_width, sensor_height/2, board_thickness]);
}

/* A small board linking the arduino to the rest of the system, and
 * containing the voltage divider for measuring the vehicle system
 * voltage */
module stripboard_cutout()
{
     cube(size=[stripboard_width, stripboard_length, board_thickness]);
}

module ubec_cutout()
{
     cube(size=[ubec_width, ubec_height, board_thickness]);
}

/* The bottom board of the stack, that keeps the conducting parts away
 * from the vehicle body */
module base_board()
{
     one_board();
}

/* This is the common part for the two layers that the conducting
 * bolts contact */
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

/* The board for the level the power cables connect at; the cutouts
 * are large enough to take the bolt heads (and the socket spanner for
 * fastening the bolts) and also for the ring terminals on the power
 * cables */
module lower_board()
{
     holes_board(bolt_head_diameter, true);
}

/* The conducting bolt bodies pass through holes in this board, which
 * also houses the channels for the internal wiring */
module middle_board()
{
     difference() {
	  holes_board(bolt_diameter, false);
	  translate([long_wiring_channel_x_position, long_wiring_channel_y_position])
	       cube(size=[long_wiring_channel_width, long_wiring_channel_length, board_thickness]);
	  translate([side_wiring_channel_x_position, side_wiring_channel_y_position])
	       cube(size=[side_wiring_channel_length, side_wiring_channel_width, board_thickness]);
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

/* The top board fits around the active components. */
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
	  translate([stripboard_x_position, stripboard_y_position]) stripboard_cutout();
	  translate([D15_x_position, D15_y_position]) D15_cutout();
	  translate([ubec_x_position, ubec_y_position]) ubec_cutout();
     }
}

/* Set this to 'true' to see the boards stacked up to see how the
 * features line up, or to 'false' to get them side-by-side ready for
 * cutting. */
solid = false;

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
