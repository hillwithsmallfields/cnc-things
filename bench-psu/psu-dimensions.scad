total_width = 270;
total_depth = 270;
total_height = 135;

outer_thickness = 3;
inner_thickness = 6;
veneer_thickness = 1;

top_of_lower_base = outer_thickness;
top_of_base = top_of_lower_base + inner_thickness;

margin = 15;
cutting_space = 5;

voltages = ["5V", "3--36V", "12V"];

sections = len(voltages);

section_width = (total_width - 2 * outer_thickness) / 3;

half_section_width = section_width / 2;

inner_depth = total_depth - outer_thickness;

panel_lip_width = 3;
panel_lip_depth = 3;

switch_height = 27.2;
switch_width = 10.4;
switch_depth = 25;               /* TODO: measure this */

meter_width = 48;
meter_height = 29;
meter_depth = 25;               /* TODO: measure this */

rocker_width = switch_width - 3;
rocker_depth = 6;
rocker_height = switch_height - 3;

meter_switch_gap = 12;

meter_and_switch_height = max(meter_height, switch_height);
meter_and_switch_width = meter_width + meter_switch_gap + switch_width;
meter_and_switch_offset_from_base = 45;

mains_inlet_width = 31;
mains_inlet_height = 27;

switch_offset = 30;
meter_offset = 100;

adjuster_width = 79;
adjuster_height = 42;
adjuster_depth = 42;
adjuster_y_offset = meter_and_switch_offset_from_base + meter_and_switch_height + 8;

clamp_connector_length = 20;
clamp_connector_width = 18;
wire_clamp_depth = clamp_connector_length + 15;

binding_post_hole_inner_diameter = 15;
binding_post_hole_outer_diameter = 3;
binding_post_rows = 6;
binding_post_spacing = 20;
binding_post_row_spacing = 25;
binding_post_offset = binding_post_row_spacing + wire_clamp_depth;

ventilation_panel_start = mains_inlet_width + margin * 3;
ventilation_hole_diameter = 10;
ventilation_hole_spacing = ventilation_hole_diameter * 1.5;
rear_ventilation_holes_per_row = (total_width - (ventilation_panel_start + margin * 2)) / ventilation_hole_spacing;
rear_ventilation_hole_rows = (total_height  - (margin * 2)) / ventilation_hole_spacing;
side_ventilation_area_length = total_depth/3;
side_ventilation_holes_per_row = side_ventilation_area_length / ventilation_hole_spacing;
side_ventilation_hole_rows = (total_height  - (margin * 2)) / ventilation_hole_spacing;

/* some internal parts so I can experiment with layout */

psu12v_length = 215;
psu12v_width = 113;
psu12v_height = 49;

psu5v_length = 160;
psu5v_width = 100;
psu5v_height = 42;

psu36v_length = 65;
psu36v_width = 115;
psu36v_height = 40;

/* layout */

gap_around_components = 10;
