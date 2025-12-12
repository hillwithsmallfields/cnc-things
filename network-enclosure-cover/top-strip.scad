panel_w = 630;
panel_h = 54;

inset_start = 290;
inset_end = 360;

inset_w = inset_end - inset_start;
inset_h = 34;

difference() {
     square([panel_w, panel_h]);
     translate([inset_start, panel_h - inset_h]) square([inset_w, inset_h]);
}
