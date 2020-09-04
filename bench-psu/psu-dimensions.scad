
total_width = 270;
total_depth = 270;
total_height = 135;

outer_thickness = 3;
inner_thickness = 6;

inner_depth = total_depth - outer_thickness;

switch_height = 27.2;
switch_width = 10.4;

meter_width = 48;
meter_height = 29;

meter_switch_gap = 12;

meter_and_switch_height = max(meter_height, switch_height);
meter_and_switch_width = meter_width + meter_switch_gap + switch_width;

mains_inlet_width = 31;
mains_inlet_height = 27;

margin = 15;
cutting_space = 5;

sections = 3;

section_width = (total_width - 2 * outer_thickness) / 3;

half_section_width = section_width / 2;

switch_offset = 30;
meter_offset = 100;

adjuster_width = 79;
adjuster_height = 42;
adjuster_depth = 42;

binding_post_hole_inner_diameter = 15;
binding_post_hole_outer_diameter = 3;
binding_post_rows = 4;
binding_post_spacing = 20;
binding_post_row_spacing = 25;
binding_post_offset = binding_post_row_spacing;

module binding_post_hole_pair(diameter, spacing, join) {
     translate([-spacing/2, 0]) circle(d=diameter);
     translate([spacing/2, 0]) circle(d=diameter);
     if join {
         translate([-spacing/2, -diameter/2) square([spacing, diameter]);
     }
}

module meter_and_switch() {
    translate([-meter_and_switch_width/2, -meter_and_switch_height/2]) {
        square([switch_width, switch_height]);
        translate([switch_width + meter_switch_gap, (switch_height - meter_height)/2]) {
            square([meter_width, meter_height]);
        }
    }
}

