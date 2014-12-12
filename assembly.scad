
include <parametric_involute_gear_v5.0.scad>
include <rack_herringbone.scad>

pi=3.1415926535897932384626433832795;
innerRadius=4;
borders=6;
diametralPitch=12;
numberOfTeeth=30;
pressureAngle=24*pi/180;
centerAngle=30;//angle at center of teeth
width=(innerRadius+borders)*2;
height=((1/diametralPitch)+(1.25/diametralPitch))*20;
middle_height = width-height;
length=170;

//union() {
//translate([0, 0, (height+middle_height)/2]) { herringbone_rack(width,diametralPitch,numberOfTeeth,pressureAngle,centerAngle); }
//translate([0, 0, -(height+middle_height)/2]) { rotate([0, 180, 0]) { herringbone_rack(width ,diametralPitch,numberOfTeeth,pressureAngle,centerAngle); }
//}
//cube(size = [width, length, middle_height], center = true);
//}
translate([width/2,0,22.5]) {rotate([180, 90, 0]) { herringbone_gear(number_of_teeth=14, pressure_angle=24, circular_pitch=300, involute_facets=5, bore_diameter=6.5, wheel_size=width, hub_thickness=30, center_angle=centerAngle); }}
translate([-width/2,0,-22.5]) {rotate([0, 90, 0]) { herringbone_gear(number_of_teeth=14, pressure_angle=24, circular_pitch=300, involute_facets=5, bore_diameter=6.5, wheel_size=width, hub_thickness=30, center_angle=centerAngle); }}

union() {
translate([-11,-5,45]) cube(size=[22,10,10]);
translate([-11,-30,17.5]) cube(size=[22,10,10]);
translate([-11,20,17.5]) cube(size=[22,10,10]);
translate([-11,20,-27.5]) cube(size=[22,10,10]);
translate([-11,-30,-27.5]) cube(size=[22,10,10]);
translate([-11,-5,-55]) cube(size=[22,10,10]);
difference() {
translate([-20.5,-30,-55]) cube(size = [10, 60, 110]);
translate([-21, 0, -22.5]) rotate([0, 90, 0]) cylinder(r=15/2+0.1, h=12);
translate([-21, 0, 22.5]) rotate([0, 90, 0]) cylinder(r=15/2+0.1, h=12);
}
difference() {
translate([10.5,-30,-7.5]) cube(size = [10, 60, 62.5]);
translate([10, 0, -22.5]) rotate([0, 90, 0]) cylinder(r=15/2+0.1, h=12);
translate([10, 0, 22.5]) rotate([0, 90, 0]) cylinder(r=15/2+0.1, h=12);
translate([10, 23.57, 22.5+23.57]) rotate([0, 90, 0]) cylinder(r=2.5, h=12);
translate([10, -23.57, 22.5+23.57]) rotate([0, 90, 0]) cylinder(r=2.5, h=12);

translate([10, 23.57, 22.5+23.57]) rotate([0, 90, 0]) cylinder(r=4, h=6);
translate([10, -23.57, 22.5+23.57]) rotate([0, 90, 0]) cylinder(r=4, h=6);

translate([10, 23.57, 22.5-23.57]) rotate([0, 90, 0]) cylinder(r=2.5, h=12);
translate([10, -23.57, 22.5-23.57]) rotate([0, 90, 0]) cylinder(r=2.5, h=12);

translate([10, 23.57, 22.5-23.57]) rotate([0, 90, 0]) cylinder(r=4, h=6);
translate([10, -23.57, 22.5-23.57]) rotate([0, 90, 0]) cylinder(r=4, h=6);
}
}
