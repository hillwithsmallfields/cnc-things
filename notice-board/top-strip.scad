max_total_width = 642;
board_frame_depth = 19;

width = 300;
height = 50;

bracket_height = sqrt(height*height*2)/2;

spacing = 75;

module lamp_hole() {
     circle(d=35, centre=true);
}

module PIR_hole() {
     circle(d=25, centre=true);
}

module frontage() {
     difference () {
	  union() {
	       intersection() {
		    square([height, height]);
		    translate([height, 0]) circle(r=height);
	       }
	       translate([height, 0]) square([width-(2*height), height]);
	       translate([width-height, 0]) {
		    intersection() {
			 square([height, height]);
			 circle(r=height);
		    }
	       }
	  }
	  translate([width/2, height/2]) {
	       translate([-spacing, 0]) lamp_hole();
	       PIR_hole();
	       translate([spacing, 0]) lamp_hole();
	  }
     }
}

module bracket() {
     union() {
	  intersection() {
	       translate([bracket_height, 0]) rotate([0,0,45]) square([height,height]);
	       square([bracket_height, bracket_height]);
	  }
	  translate([bracket_height*2 + board_frame_depth, 0]) {
	       intersection() {
		    rotate([0,0,45]) translate([-height, 0]) square([height,height]);
		    translate([-bracket_height, 0]) square([bracket_height, bracket_height]);
	       }
	  }
	  translate([bracket_height, 0]) square([board_frame_depth, bracket_height]);
	  translate([bracket_height+board_frame_depth, - board_frame_depth]) square([bracket_height, board_frame_depth]);
	  translate([bracket_height+board_frame_depth, - (board_frame_depth + height)])
	       square([bracket_height, height]);
     }
}

frontage();
translate([265, 22]) rotate([180,0,90]) bracket();
translate([35, 22]) rotate([0,0,90]) bracket();
