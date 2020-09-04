/* Sprockets for my blind chains, which have 3mm diameter balls at 4.4mm spacing */

module balls(segments, how_far_out, ball_diameter) {
     step = 360 / segments;
     echo(segments, "balls of diameter ", ball_diameter, ", ", how_far_out, " from centre");
     for (i = [0 : segments - 1]) {
	  rotate([0, 0, i * step])
	       translate([0, how_far_out])
	       circle(d=ball_diameter, $fn=90);
     }
}

module gear(teeth, tooth_spacing) {
     pi = 3.14159;
     circumference = tooth_spacing * teeth;
     radius = circumference / (2*pi);
     step = 360 / teeth;
     fudge = 1;
     sq2 = sqrt(2);
     echo("gear: teeth=", teeth, "; tooth_spacing=", tooth_spacing, "; circumference=", circumference, "; radius=", radius, "; step angle=", step);
     for (i = [0 : teeth - 1]) {
	  rotate([0, 0, i * step])
	       {
		    translate([0, -radius/2])
			 rotate([0,0,45])
			 square([radius*fudge, radius*fudge]);
	       }
     }
}

module sprocket(segments, segment_length, ball_diameter, spindle_diameter) {
     pi = 3.14159;
     gap = 1;
     circumference = segments * segment_length;
     echo("circumference=", circumference);
     diameter = circumference / pi;
     echo("diameter=", diameter);
     cheek_plate_diameter = diameter + ball_diameter;
     echo("sprocket of ", segments, " segments each ", segment_length, " long; circumference is ", circumference, " and diameter is ", diameter);
     difference() {
	  circle(d=diameter, $fn = 90);
	  balls(segments, diameter/2 , ball_diameter);
	  circle(spindle_diameter);
     }
     offset = diameter + gap + ball_diameter;
     translate([0, offset]) difference() { circle(d=cheek_plate_diameter); circle(spindle_diameter); }
     translate([0, -offset]) difference() { circle(d=cheek_plate_diameter); circle(spindle_diameter); }
}

sprocket(48, 4.4, 3, 4);
translate([50,0]) gear(60,2);
