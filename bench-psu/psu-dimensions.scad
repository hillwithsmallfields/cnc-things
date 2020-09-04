
total_width = 300;
total_depth = 300;
total_height = 150;

outer_thickness = 3;
inner_thickness = 6;

inner_depth = total_depth - outer_thickness;

switch_height = 25;             /* todo: measure */
switch_width = 12.5;            /* todo: measure */

meter_width = 75;               /* todo: measure */
meter_height = 35;              /* todo: measure */

mains_inlet_width = 30;         /* todo: measure */
mains_inlet_height = 20;        /* todo: measure */

margin = 15;
cutting_space = 5;

sections = 3;

section_width = (total_width - 2 * outer_thickness) / 3;

half_section_width = section_width / 2;

switch_offset = 30;
meter_offset = 100;

binding_post_hole_inner_diameter = 8;
binding_post_hole_outer_diameter = 4;
binding_post_rows = 4;
binding_post_spacing = 25;
binding_post_row_spacing = 25;
binding_post_offset = binding_post_row_spacing;

module binding_post_hole_pair(diameter, spacing) {
     translate([-spacing/2, 0]) circle(d=diameter);
     translate([spacing/2, 0]) circle(d=diameter);
}
