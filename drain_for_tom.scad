include <modules/threads.scad>
include <shapes/elongated_cylinder.scad>



$fn=30;


body_width = 10;
body_height = 3;
body_depth = 4;


elongated_cylinder(body_width, body_height, body_depth);

//english_thread(1, 10, 1);

