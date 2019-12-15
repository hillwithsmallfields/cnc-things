/* sizes all in mm */

nholes = 6;
spacing = 10;

difference() {
     square([spacing*2, spacing*(nholes + 1)]);
     for (i = [0 : 1 : nholes-1]) {
          translate([spacing, (i+1) * spacing]) {
               circle(d=6+i/2, center=true);
          }
     }
}
