/*
  Desktop caddy designed for Makespace (makespace.org)

  Standard desk objects for hackerspace general-purpose desks:

  - tall things
  -- digital calipers
  -- screwdrivers
  -- scissors
  - medium height
  -- ballpoints
  -- pencils
  -- marker pen
  -- steel ruler
  -- set square
  -- protractor
  -- sticky tape
  -- duct tape
  - low
  -- craft knife
  -- pencil sharpener
  -- eraser

  https://github.com/bmsleight/lasercut/blob/master/README.md looks promising.
  
 */

include <lasercut/lasercut.scad>; 

thickness = 3;

gap = 5;

width = 150;
depth = 150;
height = 150;

half = width / 24;
a = width * 1/6;
b = width * 2/6;
c = width * 3/6;
d = width * 4/6;
e = width * 5/6;

top_depth = depth / 4;
top_height = height;

middle_depth = depth / 2;
middle_height = height * 2/3;

bottom_depth = depth / 4;
bottom_height = height * 1/3;

/* Things that go in the top part */

micrometer_width = 4;
micrometer_depth = 15;

ruler_width = 2;
ruler_depth = 25;

scissors_width = 10;
scissors_depth = 20;

big_screwdriver_diameter = 8;
small_screwdriver_diameter = 4;

module upper_top() {
     lasercutoutSquare(thickness=thickness, x=width, y=top_depth,
		       finger_joints=[
			    [UP, 1, 6],
			    [DOWN, 1, 6]
			    ],
		       cutouts = [
			    [a, (top_depth - micrometer_depth) / 2, micrometer_width, micrometer_depth],
			    [b, (top_depth - ruler_depth) / 2, ruler_width, ruler_depth],
			    [c, (top_depth - scissors_depth) / 2, scissors_width, scissors_depth]
			    ],
		       circles_remove = [
			    [big_screwdriver_diameter / 2, d - half, top_depth * 1 / 3],
			    [big_screwdriver_diameter / 2, d - half, top_depth * 2 / 3],
			    [small_screwdriver_diameter / 2, d + half, top_depth * 1 / 3],
			    [small_screwdriver_diameter / 2, d + half, top_depth * 2 / 3]
			    ]
		       // , flat_adjust = [-200, -200]
	  );
}

/* Things that go in the middle part */

module middle_top() {
     lasercutoutSquare(thickness=thickness, x=width, y=middle_depth,
		       finger_joints=[
			    [UP, 1, 6],
			    [DOWN, 1, 6]
			    ]
		       // ,` flat_adjust = [200, 200]
	  );
}

/* Things that go in the bottom part */

module bottom_top() {
     lasercutoutSquare(thickness=thickness, x=width, y=bottom_depth,
		       finger_joints=[
			    [UP, 1, 6],
			    [DOWN, 1, 6]
			    ]
		       // , flat_adjust = [200, 200]
	  );
}

/* the sides */

points = [[0,0], [0, bottom_height], [bottom_depth, bottom_height],
	  [bottom_depth, middle_height], [bottom_depth+middle_depth, middle_height], [bottom_depth+middle_depth, top_height],
	  [depth, top_height], [depth, 0]];

module side() {
     lasercutout(thickness=thickness, points = points);
}


/* The whole thing */

upper_top();
translate([0, depth * 1/3]) {
     middle_top();
     translate([0, depth * 2/3]) {
	  bottom_top();
	  }
     }
translate([depth + gap*2, 0]) { side(); }
translate([depth*2 + gap, depth+60]) { rotate([0, 0, 180]) { side(); }}
