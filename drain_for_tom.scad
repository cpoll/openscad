include <modules/threads.scad>
include <shapes/elongated_cylinder.scad>
include <shapes/elongated_torus.scad>



$fn=30;

// used to make larger cutouts to stop z-fighting
// set to 0 before generating final build
zf=0.1;

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

center_cutout_x = oval_base_x - 23*2;
center_cutout_y = 12;

module oval_base() {
    
    difference() {
        // base
        elongated_cylinder(oval_base_x, oval_base_y, oval_base_z);
        
        // screw holes
        translate([oval_base_x/2-52,oval_base_y/2-8,-5]) cylinder(h=10, r=screw_hole_r);
        
        translate([-oval_base_x/2+52,oval_base_y/2-8,-5]) cylinder(h=10, r=screw_hole_r);
        
        translate([oval_base_x/2-55,-oval_base_y/2+8,-5]) cylinder(h=10, r=screw_hole_r);
        
        translate([-oval_base_x/2+55,-oval_base_y/2+8,-5]) cylinder(h=10, r=screw_hole_r);
        
        // center cutout
        elongated_cylinder(center_cutout_x, center_cutout_y, 10);
    }
}
oval_base();

module cutout() {
    translate([0,0,-15]) {
            cylinder(h=30, r=drain_inner_diameter);
    }
}

module drain() {
   
    difference() {
        // Pipe
        translate([0,0,-drain_height-body_depth/2]) {
            cylinder(h=drain_height, r=drain_outer_diameter);
        };
        
        cutout();
    };
    
}

module silicon_cutout(w, d1, d2) {
    elongated_torus(w=w, d=d1, inner_radius=1);
}

//module oval_torus(inner_radius, thickness=[0, 0])
//{
//rotate_extrude() translate([inner_radius+thickness[0]/2,0,0]) //ellipse(width=thickness[0], height=thickness[1]);
//}

// oval_torus(80,thickness=[1, 1]);

///////
*difference(){
    elongated_cylinder(body_width, body_height, body_depth);
    
    //translate([0, 0, 0.5]){
    //    elongated_cylinder(body_width-1, body_height-1, body_depth+zf);
    //}
    
    // pipe cutout
    cutout();
    
    // silicon fill cutout
    //translate([0, 0, 1.7]){
    //    elongated_torus(w=body_width-0.5, d=body_height-0.7, inner_radius=1);
    //}
    
    // drain cutout
    cylinder_cutout_height=1;
    translate([0, -cylinder_cutout_height/2, body_height]){
        scale([1, 1, 2]){
            rotate([0, 90, 90]){
                cylinder(cylinder_cutout_height, 3, 3);
            }
        }
    }
}

//drain();

//english_thread(1, 10, 1);

