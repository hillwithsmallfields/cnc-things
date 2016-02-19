/* Supports for a moulding strip holding an LED strip for my bureau */

moulding_a = 20;
moulding_b = 4;

side = moulding_a - (moulding_b * 2);

module moulding() {
     difference() {
	  union() {
	       translate([moulding_b, 0]) square([side, moulding_b]);
	       translate([0, moulding_b]) square([moulding_b, side]);
	       translate([moulding_b, moulding_b]) circle(moulding_b);
	       translate([side + moulding_b, moulding_b]) circle(moulding_b);
	       translate([moulding_b, side + moulding_b]) circle(moulding_b);
	  }
	  translate([moulding_b, moulding_b]) square([side + moulding_b, side + moulding_b]);
     }
     /* uncomment to check the size */
     /* square([1,moulding_a]); */
     /* square([moulding_a,1]); */
}

length = 3 * 25;
height = 0.75 * 25;
double_height = height * 2;
angle = 36;

module support () {
     difference() {
	  square([height,length]);
	  rotate([0,0,90 - angle]) translate([0,-double_height]) square([double_height,double_height]);
     }
}

module moulding_in_place () {
     translate([-3, 0])
	  rotate([0,0,-90 + (90 - angle)]) moulding();
}

difference() {
     support();
     
     moulding_in_place();
}

// color([1,0,0]) moulding_in_place();

