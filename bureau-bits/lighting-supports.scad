length = 75;
height = 25;
angle = 36;

/* polygon([[0,0], */
/* 	 [0,length], */
/* 	 [height,length], */
/* 	 [height,cos(angle) * height]], */
/* 	[[0,1,2,3]]); */

module support() {
     polygon([[0,cos(angle) * height],
	      [0,length],
	      [height,length],
	      [height, 0]],
	     [[0,1,2,3]]);
}

module all_supports() {
     for (i = [0 : 13]) {
	  translate([height * i, 0]) support();
     }
}

// all_supports();
support();
