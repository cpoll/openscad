include <modules/threads.scad>
include <shapes/elongated_cylinder.scad>
include <shapes/elongated_torus.scad>



$fn=60;

// used to make larger cutouts to stop z-fighting
// set to 0 before generating final build
zf=0.1;

total_height = 57;

body_width = 10;
body_height = 5;
body_depth = 3;

drain_height = 4;
drain_outer_diameter = 2;
drain_inner_diameter = 1;


oval_base_x = 175;
oval_base_y = 57;
oval_base_z = 5.5;

screw_hole_r = 6.3/2;
screw_hole_clearance_r = screw_hole_r+5;

center_cutout_x = oval_base_x - 23*2;
center_cutout_y = 12;

pipe_z = total_height-oval_base_z; //real pipe_z is 21, but we decide to bring it all the way to the base instead
pipe_r = 46.5/2;
pipe_inner_r = pipe_r-8;

drain_funnel_x = oval_base_x - 23;
drain_funnel_y = oval_base_y - 33; // picked to give clearance to screw holes
drain_funnel_z = 36-oval_base_z;

module oval_base() {
    
    difference() {
        // base
        elongated_cylinder(oval_base_x, oval_base_y, oval_base_z);
        
        // screw holes
        translate([oval_base_x/2-52,oval_base_y/2-8,-5]) cylinder(h=10, r=screw_hole_r);
        
        translate([-oval_base_x/2+52,oval_base_y/2-8,-5]) cylinder(h=10, r=screw_hole_r);
        
        translate([oval_base_x/2-55,-oval_base_y/2+8,-5]) cylinder(h=10, r=screw_hole_r);
        
        translate([-oval_base_x/2+55,-oval_base_y/2+8,-5]) {
            cylinder(h=10, r=screw_hole_r);
            
            // Debug cutout, used to make sure we give the screw holes enough room.
            // Comment out before exporting
            //cylinder(h=10, r=screw_hole_clearance_r);
        }
        
        // center cutout
        elongated_cylinder(center_cutout_x, center_cutout_y, 10);
    }
}
translate([0,0,oval_base_z/2]) oval_base();

module pipe() {
    difference() {
        translate([0,0,total_height-pipe_z]) {
            cylinder(h=pipe_z, r=pipe_r);
        }
        drain_funnel_channel();  
    }
}

module pipe_cutout() {
    // decided to use a cube instead of a cylinder
    //cylinder(h=pipe_z+3, r=pipe_inner_r);
    elongated_cylinder(pipe_inner_r*2+4, drain_funnel_y/2, 200);            
}

difference() {
    pipe();
    pipe_cutout();
}

module drain_funnel_channel() {
    // these numbers were winged instead of being measured
    drain_funnel_channel_x = drain_funnel_x-10;

    translate([0,center_cutout_y/2,-40]){
        scale([1,1,0.9]){
            rotate([90, 0, 0]){
                cylinder(h=center_cutout_y, r=drain_funnel_channel_x/2+10);
            }
        }
    }
}

module drain_funnel() {
    // drain funnel body
    elongated_cylinder(drain_funnel_x, drain_funnel_y, drain_funnel_z);  
}

difference() {
    // drain funnel
    intersection() {
        translate([0,0,drain_funnel_z/2 + oval_base_z]){
            drain_funnel();
        }
        scale([1.2,2,1.1]) drain_funnel_channel();
    }
    
    //channel
    drain_funnel_channel();
    
    //channel-pipe interface
    pipe_cutout();
}
//drain_funnel_channel();
//color("red") translate([0,10,0]) scale([1.2,2,1.1]) drain_funnel_channel();

 

