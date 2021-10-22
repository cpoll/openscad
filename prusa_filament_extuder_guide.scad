difference() {
    color("red") cylinder(h=18, r1=10/2, r2=10.5/2);
    color("blue") cylinder(h=18, r1=8.5/2, r2=7.5/2);
    translate([0, 0, 10]) color("green") cylinder(h=8, r1=7.5/2, r2=4.75/2);
}
