/* plug dimensions so they can be threaded and unthreaded through the clips */

clearance = 2;

usb_width = 15.7 + clearance;
usb_height = 7.5 + clearance;


hdmi_width = 21 + clearance;
hdmi_height = 10.6 + clearance;

clip_depth = 10;

module clip(channel_width, channel_height) {
     difference() {
          /* square([channel_width + 2 * clip_depth, */
          /*            channel_height + clip_depth]); */
          intersection() {
               translate([channel_width/2 + clip_depth, 0]) circle(r = channel_width/2 + clip_depth);
               square([channel_width + 2*clip_depth, channel_width/2 + clip_depth]);
          }
          translate([clip_depth, 0]) square([channel_width, channel_height]);
     }
}

module usb_clip() {
     clip(usb_width, usb_height);
}

module hdmi_clip() {
     clip(hdmi_width, hdmi_height);
}

module wires_clip() {
     clip(12, 4);
}

for (i=[0:7]) {
     translate([i*(hdmi_width+clip_depth*2), 0]) {
          usb_clip();
          translate([0, clip_depth + usb_height + clearance]) {
               hdmi_clip();
               translate([0, clip_depth + hdmi_height + clearance]) wires_clip();
          }
     }
}
