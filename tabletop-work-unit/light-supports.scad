/* sizes all in mm */

/* Dimensions */

width = 50;			/* estimate */
length = 300;			/* estimate */
angle = 45;

module end_triangle() {
     polygon(points=[[0,0],[0,width*cos(angle)],[width,0]]);
}

module support_arm() {
     union() {
	  translate([0, width/2]) square([width, (length-(width/2))-width*cos(angle)]);
	  translate([0, length-width*cos(angle)]) end_triangle();
	  translate([width/2, width/2]) circle(r=width/2, center=true);
     }
}

support_arm();

