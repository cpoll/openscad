module half_torus(outerRadius, innerRadius, z_rotation=90)
{
    r=(outerRadius-innerRadius)/2;
    
    rotate([0,0,z_rotation]){
        rotate_extrude(angle=180){
            translate([innerRadius+r,0,0]){
                circle(r);
            }
        }
    }
}

module elongated_torus(w, d, inner_radius=0.5, center=true) {
    // Like a torus with two straight cylindrical sides
    // Assumes the torus is elongated along the x-axis     
    
    h=1;
    outer_radius = d/2;
    cylinder_radius = (outer_radius-inner_radius)/2;
    

    
    module _elongated_torus(w, d, h) {
        circle_radius = d/2;
        
        // Ends
        scale([1, 1, h]){
            translate([circle_radius, d/2, 0.5]){
                half_torus(outer_radius, inner_radius, z_rotation=90);
            }
        
            translate([w-circle_radius, d/2, 0.5]){
                half_torus(outer_radius, inner_radius, z_rotation=-90);
            }
        }
            
        //Cylinders
        cylinder_length = w-circle_radius*2;
        translate([circle_radius, cylinder_radius, h/2]){
            rotate([0,90,0]){
                cylinder(h=cylinder_length, r=cylinder_radius);
            }
        }
        
        translate([circle_radius, d-cylinder_radius, h/2]){
            rotate([0,90,0]){
                cylinder(h=cylinder_length, r=cylinder_radius);
            }
        }
    }
    
    if(center) {
        translate([-w/2, -d/2, -h/2]){
            _elongated_torus(w, d, h);
        }
    } else {
        _elongated_torus(w, d, h);
    }
}

// elongated_torus(26, 9, 2, center=false);
