// Dimensions from bartneck's answer at
// https://bricks.stackexchange.com/questions/288/what-are-the-dimensions-of-a-lego-brick

$fn = 30;

brick_x = 31.8;
brick_y = 15.8;
brick_z = 9.6;

brick_wall = 1.2;
brick_wall_z = 1;

stud_height = 1.8;
stud_radius = 4.9/2; // Originally 4.8/2

stud_distance = 8;
stud_offset = 3.9;

under_peg_outer_radius = 6.51/2;
under_peg_inner_radius = 4.8/2;
under_peg_distance_to_wall = 7.9;
under_peg_distance_to_peg = 8;

center_wall_height = 6.3+1;
center_wall_thickness = 0.8;

edge_support_x = 0.5;  // Original 0.6
edge_support_y = 0.5;  // Original 0.2
edge_support_distance = stud_distance;
edge_support_offset = stud_offset;

module brick() {
    difference() {
        cube([brick_x, brick_y, brick_z]);
        translate([brick_wall, brick_wall, 0]){
            cube([
                brick_x - brick_wall*2, 
                brick_y - brick_wall*2, 
                brick_z - brick_wall_z]);
        }
    }
}

module studs() {
    for (x = [0:3]) {
        for (y = [0:1]) {
            translate([
                stud_distance * x + stud_offset, 
                stud_distance * y + stud_offset, 
                brick_z]){
                    cylinder(h=stud_height, r=stud_radius);
            }
        }
    }
}

module under_peg() {
    difference() {
        cylinder(
            h=brick_z-brick_wall_z, 
            r=under_peg_outer_radius);
        cylinder(
            h=brick_z-brick_wall_z, 
            r=under_peg_inner_radius);
    }
}

module under_pegs() {
    for (i = [0:2]) {
        translate([
            i*under_peg_distance_to_peg + under_peg_distance_to_wall,
            under_peg_distance_to_wall,
            0]){
                
                under_peg();
        }
    }
}

module center_wall() {
    translate([
        brick_x/2 - center_wall_thickness/2,
        0,
        brick_z - center_wall_height]){
            
            difference() {
                cube([
                    center_wall_thickness,
                    brick_y,
                    center_wall_height]);
                translate([0, brick_y/2, 0]){
                    cylinder(
                        h=brick_z, 
                        r=under_peg_outer_radius);
                }
            }
    }
}

module edge_supports() {
    
    // Top supports
    for (x=[0:3]) {
        translate([
            x*edge_support_distance+edge_support_offset,
            brick_wall,
            0
        ]){
            cube([
                edge_support_x,
                edge_support_y,
                brick_z]);
        }

    }
    
    // Bottom supports
    for (x=[0:3]) {
        translate([
            x*edge_support_distance+edge_support_offset,
            brick_y-brick_wall-edge_support_y,
            0
        ]){
            cube([
                edge_support_x,
                edge_support_y,
                brick_z]);
        }

    }
}

brick();
studs();
under_pegs();
center_wall();
edge_supports();

