/* sizes all in mm */

/* Dimensions */

width = 45;			/* measured */
support_length = 500;		/* measured */

bracer_length = 250;
bracer_length_from_pivot = bracer_length - (width/2);
angle = 45;
bit_width = 3;
hole_diameter = 8 - bit_width;

end_radius = width/2;

indent_depth = width / 8;
indent_offset = bracer_length_from_pivot - sqrt(2 * width * width);;

gap = bit_width * 2;

module end_triangle() {
     polygon(points=[[0,0],[0,width*cos(angle)],[width,0]]);
}

module bracer() {
     intersection () {
	  difference () {
	       union() {
		    translate([0, end_radius]) square([width, bracer_length_from_pivot]);
		    translate([end_radius, end_radius]) circle(r=end_radius, center=true);
		    /*
		    polygon(points=[[0, end_radius],
				    [end_radius + end_radius*sin(angle), end_radius - cos(angle)],
				    [0, (end_radius - cos(angle)) - ]],
			    paths=[[0,1,2]]);
		    */
	       }
	       translate([end_radius, end_radius]) circle(r=hole_diameter/2, center=true);
	  }
	  translate([end_radius, end_radius]) circle(r=bracer_length, center=true);
     }
}

module support_arm() {
     difference () {
	  difference () {
	       union() {
		    translate([0, end_radius]) square([width, (support_length-(end_radius))-width*cos(angle)]);
		    translate([0, support_length-width*cos(angle)]) end_triangle();
		    translate([end_radius, end_radius]) circle(r=end_radius, center=true);
	       }
	       translate([end_radius, end_radius]) circle(r=hole_diameter/2, center=true);
	  }
	  translate([0, indent_offset]) rotate([0,0,-90]) translate([0, indent_depth-bracer_length]) bracer();
     }
}

all = true;

if (all) {
     support_arm();
     translate([width, support_length*2 - end_radius]) rotate([0,0,180]) support_arm();
     translate([0, support_length*2 + bracer_length + gap - end_radius]) bracer();
     translate([width, support_length*2 + bracer_length - end_radius]) rotate([0,0,180]) bracer();
} else {
     translate([0, bracer_length]) bracer();
     translate([width,  bracer_length ]) rotate([0,0,180]) bracer();
}

