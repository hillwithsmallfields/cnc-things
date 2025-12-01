/* end triangles for the reading stand */

width = 250;
height = 200;
peak_offset = 200;

speaker_diameter = 50;

speaker_centre_x = 75;
speaker_centre_y = 50;

module speaker_holes(diameter, hole_offset) {
     circle(d=diameter);
}

module endplate() {
     difference() {
          polygon(points=[[0, 0],
                          [peak_offset, height],
                          [width, 0]]);
          speaker_holes(speaker_diameter, 30);
}
