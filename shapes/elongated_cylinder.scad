module elongated_cylinder(w, d, h, center=true) {
    // Like a cylinder with two flat sides
    // Assumes the cylinder is elongated along the x-axis     
    
    module _elongated_cylinder(w, d, h) {
        circle_radius = d/2;
        
        translate([circle_radius, d/2, 0]){
            cylinder(r=circle_radius,h=h);
        }
        
        translate([w-circle_radius, d/2, 0]){
            cylinder(r=circle_radius,h=h);
        }
        
        translate([circle_radius, 0, 0]){
            cube([w-circle_radius*2, d, h]);
        }
    }
    
    if(center) {
        translate([-w/2, -d/2, -h/2]){
            _elongated_cylinder(w, d, h);
        }
    } else {
        _elongated_cylinder(w, d, h);
    }
}
