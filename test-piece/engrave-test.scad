size = 18;
scale([-1, 1]) color("black") {
     translate([size/3, size/3]) circle(r=size/3, $fn=18);
     translate([size/3, size+2]) difference() { circle(r=size/3, $fn=18); circle(r=size/6, $fn=18); }
     translate([size*2/3, size/3]) text("Light", font="Lato", size=size);
}
