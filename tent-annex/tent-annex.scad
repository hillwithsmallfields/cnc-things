xd_front_leg_base_to_cover_front = 71;
y_cover_front_height             = 98;
xd_cover_front_to_cover_back     = 132; /* horizontally along the roofrack */
y_cover_back_height              = 160;
xd_cover_back_to_tent_front      = 82;
xd_tent_front_to_tent_chine      = 41;
y_tent_chine                     = 92;
xd_tent_front_to_tent_gable      = 92;
y_tent_gable                     = 100; /* guess; TODO measure this */
y_gable_base                     = 16;  /* guess; TODO measure this */
y_tent_top                       = 130;
xd_tent_board_length             = 122;

z_annex_width = 5 * 30;         /* approximation (5 ft); TODO find real measurement */
xs_roof_length = sqrt(pow(xd_cover_front_to_cover_back, 2) + pow(y_cover_back_height - y_cover_front_height, 2));

x_cover_front = xd_front_leg_base_to_cover_front;
x_cover_back  = x_cover_front + xd_cover_front_to_cover_back;
x_tent_front  = x_cover_back  + xd_cover_back_to_tent_front;
x_tent_chine  = x_tent_front  + xd_tent_front_to_tent_chine;
x_tent_gable  = x_tent_front  + xd_tent_front_to_tent_gable;
x_tent_hinge  = x_tent_front  + xd_tent_board_length;

xd_tent_window = 2 * (x_tent_hinge - x_tent_gable);
yd_tent_window = y_tent_gable - y_gable_base;

overlap_proportion = 2.0 / 3.0;

x_overlap_end = x_tent_hinge + (xd_tent_board_length - xd_tent_front_to_tent_chine) * overlap_proportion;
y_overlap_end = y_tent_chine + (y_tent_top - y_tent_chine) * (1.0 - overlap_proportion);

roofrack_tray_depth = 15;

module roofrack() {
     rotate([90,0,0]) square([x_tent_hinge, z_annex_width]);
     square([x_tent_hinge, roofrack_tray_depth]);
     translate([0,0,z_annex_width]) square([x_tent_hinge, roofrack_tray_depth]);
}

module annex_side() {
     polygon([[x_cover_front, 0],
              [x_cover_front, y_cover_front_height],
              [x_cover_back, y_cover_back_height],
              [x_tent_hinge, y_tent_top],
              [x_overlap_end, y_overlap_end],
              [x_tent_gable, y_tent_gable],
              [x_tent_chine, 0]]);
}

module annex_front() {
     square([z_annex_width, y_cover_front_height]);
}

module annex_roof() {
     square([z_annex_width, x_tent_hinge - x_cover_back]);
}

module annex_overlap() {
     square([z_annex_width,
             sqrt(pow(x_tent_hinge - x_tent_chine, 2) + pow(y_tent_top - y_tent_chine, 2)) * overlap_proportion]);
}

module annex() {
     roof_angle = - atan2(y_cover_back_height - y_tent_top, x_tent_hinge - x_cover_back);
     tent_angle = atan2(y_tent_top - y_tent_chine, (x_tent_hinge - x_tent_chine));
     color("red", 0.5) {
          annex_side();
          translate([0,0,z_annex_width]) annex_side();
          translate([xd_front_leg_base_to_cover_front, 0]) rotate([0,-90,0]) annex_front();
          translate([x_tent_hinge, y_tent_top]) rotate([roof_angle+90,-90,0]) annex_roof();
          translate([x_tent_hinge, y_tent_top]) rotate([-tent_angle-90,-90,0]) annex_overlap();
     }
}

module tent_window() {
     translate([x_tent_hinge + xd_tent_board_length - xd_tent_front_to_tent_gable,
                y_gable_base]) square([xd_tent_window, yd_tent_window]);
}

module tent_side() {
     difference() {
          polygon([[0,0],
                   [xd_tent_front_to_tent_chine, y_tent_chine],
                   [xd_tent_board_length, y_tent_top],
                   [xd_tent_board_length + xd_tent_board_length - xd_tent_front_to_tent_chine, y_tent_chine],
                   [xd_tent_board_length * 2, 0],
                   [0,0]]);
          tent_window();
     }
}

module tent_roof_section() {
     square([z_annex_width,
             sqrt(pow(x_tent_hinge - x_tent_chine, 2) + pow(y_tent_top - y_tent_chine, 2))]);
}

module tent() {
     angle = atan2(y_tent_top - y_tent_chine, (x_tent_hinge - x_tent_chine));
     color("green") {
          tent_side();
          translate([0,0,z_annex_width]) tent_side();
          translate([xd_tent_board_length, y_tent_top]) {
               rotate([angle+90,-90,0]) tent_roof_section();
               rotate([-angle-90,-90,0]) tent_roof_section();
          }
     }
}

module cover_roof() {
     angle = atan2(y_cover_back_height - y_cover_front_height, xd_cover_front_to_cover_back);
     color("grey") translate([xd_front_leg_base_to_cover_front, y_cover_front_height]) rotate([angle-90,-90,0]) square([z_annex_width, xs_roof_length]);
}

color("black", 0.25) roofrack();
cover_roof();
translate([x_tent_front, 0]) tent();
annex();
