/* Tufnol board for protection diode and current sensors for my Land Rover. */

board_thickness = 9;
board_height = 200;
board_width = 100;

sensor_height = 40;		/* todo: measure */
sensor_width = 30;		/* todo: measure */
sensor_bolt_spacing = 20;	/* todo: measure */
sensor_bolt_x_offset = 7;	/* todo: measure */
sensor_bolt_y_offset = (sensor_height - sensor_bolt_spacing) / 2;

sensor_base_depth = 3;

gap_between_sensors = 25;

diagram_spacing = 75;

diode_input_x = 25;
diode_input_y = board_height - 45;

diode_length = 20;		/* todo: measure */

arduino_height = 1.3 * 25.4;
arduino_width = 0.7 * 25.4;

arduino_x_position = board_width - (arduino_width + 25);
arduino_y_position = 25;

bolt_length = 20;
bolt_diameter = 6;		/* todo: measure */
bolt_head_thickness = 5;	/* todo: measure */
bolt_head_diameter = 10;	/* todo: measure */

mounting_hole_offset = 15;

module one_board()
{
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

module bolt_cutout()
{
     union() {
	  cylinder(h=bolt_head_thickness, r=bolt_head_diameter/2, center=true);
	  translate([0,0,bolt_head_thickness]) cylinder(h=bolt_length, r=bolt_diameter/2, center=true);
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

module base_board()
{
     one_board();
}

module lower_board()
{
     difference() {
	  one_board();
	  translate([diode_input_x, diode_input_y]) {
	       bolt_cutout();
	       translate([0, -diode_length]) {
		    bolt_cutout();
		    translate([0,0,board_thickness-sensor_base_depth]) sensor_cutout();
		    translate([0,-sensor_bolt_spacing]) {
			 bolt_cutout();
			 translate([0,-gap_between_sensors]) {
			      bolt_cutout();
			      translate([0,0,board_thickness-sensor_base_depth]) sensor_cutout();
			      translate([0, -sensor_bolt_spacing]) {
				   bolt_cutout();
			      }
			 }
		    }
	       }
	  }
     }
}

module middle_board()
{
     difference() {
	  one_board();
	  translate([diode_input_x, diode_input_y]) {
	       bolt_cutout();
	       translate([0, -diode_length]) {
		    sensor_cutout();
		    translate([0,-sensor_bolt_spacing]) {
			 translate([0,-gap_between_sensors]) {
			      sensor_cutout();
			 }
		    }
	       }
	  }
	  translate([arduino_x_position, arduino_y_position]) arduino_cutout();
     }
}

module upper_board()
{
     one_board();
}

base_board();
translate([0,0,diagram_spacing]) lower_board();
translate([0,0,2*diagram_spacing]) middle_board();
translate([0,0,3*diagram_spacing]) upper_board();
