bar_outer_width = 41; // Includes spacing
bar_inner_width = 33;

bar_inside_depth = 8;
bar_middle_section_depth = 4.8;
bar_middle_section_width = 22;

arms_thickness = 12.5; // bar thickness is 14.5

bar_cutout_extra = 3;

mounting_tape_width = 27;

arms_width = 40;

module bar_cutout() {
    
    cube([bar_outer_width, mounting_tape_width, bar_cutout_extra]);

    difference() {
        translate([(bar_outer_width - bar_inner_width)/2, 0, bar_cutout_extra]){
            cube([bar_inner_width, mounting_tape_width, bar_inside_depth]);
        }

        translate([(bar_outer_width - bar_middle_section_width)/2, 0, bar_cutout_extra+bar_inside_depth-bar_middle_section_depth]){
            cube([bar_middle_section_width, mounting_tape_width, bar_middle_section_depth]);
        }
    }
}

module left_arm() {
    difference(){
        cube([arms_width, mounting_tape_width, arms_thickness+bar_cutout_extra]);

        translate([0, 0, 3])
        rotate([0, -15, 0])
            cube([arms_width*2, mounting_tape_width, arms_thickness+bar_cutout_extra]);
    }
}

module right_arm() {
    translate([arms_width, mounting_tape_width, 0])
        rotate([0, 0, 180])
            left_arm();
}

bar_cutout();

translate([-arms_width, 0, 0]){
    left_arm();
}

translate([bar_outer_width, 0, 0])
    right_arm();


//translate([bar_outer_width, 0, 0])
//    cube([arms_width, mounting_tape_width, arms_thickness+bar_cutout_extra]);