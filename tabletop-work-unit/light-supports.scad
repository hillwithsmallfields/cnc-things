/* sizes all in mm */

/* Dimensions */

width = 45;			/* measured */
length = 300;			/* estimate */
bracer_length = 150;
angle = 45;
hole_diameter = 8;

module end_triangle() {
     polygon(points=[[0,0],[0,width*cos(angle)],[width,0]]);
}

module support_arm() {
     difference () {
	  union() {
	       translate([0, width/2]) square([width, (length-(width/2))-width*cos(angle)]);
	       translate([0, length-width*cos(angle)]) end_triangle();
	       translate([width/2, width/2]) circle(r=width/2, center=true);
	  }
	  translate([width/2, width/2]) circle(r=hole_diameter/2, center=true);
     }
}

module bracer() {
     union() {
	  translate([0, width/2]) square([width, bracer_length-(width/2)]);
	  translate([width/2, width/2]) circle(r=width/2, center=true);
     }
}

support_arm();
translate([width, length*2 - width/2]) { rotate([0,0,180]) { support_arm(); } }
/* translate(width*3, 0) bracer(); */

