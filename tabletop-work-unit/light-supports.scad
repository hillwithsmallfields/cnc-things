/* sizes all in mm */

/* Dimensions */

width = 45;			/* measured */
support_length = 500;		/* measured */

bracer_length = 150;
angle = 45;
bit_width = 3;
hole_diameter = 8 - bit_width;

gap = bit_width * 2;

module end_triangle() {
     polygon(points=[[0,0],[0,width*cos(angle)],[width,0]]);
}

module support_arm() {
     difference () {
	  union() {
	       translate([0, width/2]) square([width, (support_length-(width/2))-width*cos(angle)]);
	       translate([0, support_length-width*cos(angle)]) end_triangle();
	       translate([width/2, width/2]) circle(r=width/2, center=true);
	  }
	  translate([width/2, width/2]) circle(r=hole_diameter/2, center=true);
     }
}

module bracer() {
     difference () {
	  union() {
	       translate([0, width/2]) square([width, bracer_length-(width/2)]);
	       translate([width/2, width/2]) circle(r=width/2, center=true);
	  }
	  translate([width/2, width/2]) circle(r=hole_diameter/2, center=true);
     }
}

support_arm();
translate([width, support_length*2 - width/2]) rotate([0,0,180]) support_arm();
translate([0, support_length*2 + bracer_length + gap - width/2]) bracer();
translate([width, support_length*2 + bracer_length - width/2]) rotate([0,0,180]) bracer();

