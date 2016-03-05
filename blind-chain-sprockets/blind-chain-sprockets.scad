/* Sprockets for my blind chains, which have 3mm diameter balls at 4.4mm spacing */

module balls(how_far_out, ball_diameter, segments) {
     step = 360 / segments;
     for (i = [0 : segments - 1]) {
	  rotate([0, 0, i * step])
	       translate([how_far_out, how_far_out])
	       circle(ball_diameter);
     }
}

module sprocket(outer_diameter, ball_diameter, segment_length) {
     pi = 3.14159;
     circumference = outer_diameter * pi;
     echo("circumference=", circumference);
     segments = floor(circumference / segment_length);
     echo("segments=", segments);
     adjusted_circumference = segment_length * segments;
     echo("adjusted circumference=", adjusted_circumference);
     adjusted_diameter = adjusted_circumference / pi;
     echo("adjusted diameter=", adjusted_diameter);
     difference() {
	  circle(d=adjusted_diameter * 1.414);
	  balls(adjusted_diameter/2 , ball_diameter, segments);
     }
}

sprocket_size = 50;

translate([sprocket_size/2, sprocket_size/2]) sprocket(sprocket_size, 3, 4.4);



