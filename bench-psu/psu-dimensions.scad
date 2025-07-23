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
switch_backing_height = switch_height + 6;
switch_width = 10.4;
switch_depth = 25;               /* TODO: measure this */

meter_width = 48;
meter_backing_width = meter_width + 6;
meter_height = 29;
meter_backing_height = meter_height + 6;
meter_depth = 25;               /* TODO: measure this */

mains_meter_width = 62;
mains_meter_backing_width = mains_meter_width + 6;
mains_meter_height = 37;
mains_meter_backing_height = mains_meter_height;

rocker_width = switch_width - 3;
rocker_depth = 6;
rocker_height = switch_height - 3;

meter_switch_gap = 12;

meter_and_switch_height = max(meter_height, switch_height);
meter_and_switch_width = meter_width + meter_switch_gap + switch_width;
meter_and_switch_offset_from_base = 45;
meter_and_switch_offset_from_side = 6;

module meter_and_switch_layout() {
     translate([-meter_and_switch_width/2+meter_and_switch_offset_from_side, 0]) {
          translate([switch_width/2, 0]) children(0);
          translate([meter_and_switch_width - meter_backing_width/2, 0]) children(1);
     }
}

module upper_front_layout(is_outer) {
     adj_w = is_outer ? adjuster_width_outer : adjuster_width_inner;
     adj_h = is_outer ? adjuster_height_outer : adjuster_height_inner;
     translate([(total_width - adj_w)/2, adjuster_y_centre - adj_h/2]) {
          children(0);
     }
     translate([half_section_width, adjuster_y_centre]) {
          children(1);
     }
     translate([total_width - half_section_width, adjuster_y_centre]) {
          children(2);
     }
}

mains_inlet_width = 31;
mains_inlet_height = 27;

din_power_socket_hole_diameter = 18;
lighter_socket_hole_diameter = 28;

usb_length = 15;
usb_width = 7.5;

usb_inner_panel_width = usb_length * 3;
usb_inner_panel_depth = usb_width * 3;
usb_outer_panel_width = usb_inner_panel_width + 12;
usb_outer_panel_depth = usb_inner_panel_depth + 12;
usb_panel_from_side = usb_outer_panel_width*3/4;
usb_panel_from_front = total_depth / 2;
MC4_length = 22;
MC4_width = 16.5;

switch_offset = 30;
meter_offset = 100;

adjuster_width_outer = 71;
adjuster_width_inner = 79;
adjuster_height_outer = 38;
adjuster_height_inner = 42;
adjuster_depth = 42;
adjuster_y_centre = meter_and_switch_offset_from_base + meter_and_switch_height + adjuster_height_inner/2 + 8;

clamp_connector_length = 20;
clamp_connector_width = 18;
wire_clamp_depth = clamp_connector_length + 15;

binding_post_hole_inner_diameter = 16;
binding_post_hole_outer_diameter = 5.25;
binding_post_rows = 8;
binding_post_spacing = 25.4 * 3 / 4;
binding_post_row_spacing = 25;
binding_post_offset = binding_post_row_spacing;

corner_length = total_width / 4;
corner_depth = corner_length / 3;

corner_fixing_hole_offset = corner_depth / 2;
corner_fixing_bolt_hole_diameter = 5;
corner_fixing_insert_hole_diameter = 8;

assembly_bracket_size = corner_fixing_hole_offset * 2;
assembly_bracket_hole_diameter = 8;
assembly_bracket_tab_offset = 10;
assembly_bracket_tab_length = 10;

rear_ventilation_panel_start = mains_inlet_width + margin * 2 + inner_thickness;
rear_ventilation_panel_end = total_width - assembly_bracket_tab_offset;
ventilation_hole_diameter = 10;
ventilation_hole_spacing = ventilation_hole_diameter * 1.5;
rear_ventilation_holes_per_row = (total_width - (rear_ventilation_panel_start + margin * 2)) / ventilation_hole_spacing;
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
psu36v_hole_offset_shorter_side = 5;
psu36v_hole_offset_longer_side = 4;

/* layout */

gap_around_components = 10;
