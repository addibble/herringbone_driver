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
length=168;
// 100 for production
// 10 for rough
qual=3;

/* the herringbone rack
union() {
translate([0, 0, (height+middle_height)/2]) { herringbone_rack(width,diametralPitch,numberOfTeeth,pressureAngle,centerAngle); }
translate([0, 0, -(height+middle_height)/2]) { mirror([0, 0, 1]) { herringbone_rack(width ,diametralPitch,numberOfTeeth,pressureAngle,centerAngle); } }
cube(size = [width, length, middle_height], center = true);
}
*/

/* the herringbone gears
// 6200Z bearings have a 10mm inner diameter, 30mm outer diameter, and 9mm thickness
translate([width/2,0,22.5]) {rotate([180, 90, 0]) { herringbone_gear(number_of_teeth=14, pressure_angle=24, circular_pitch=300, involute_facets=5, bore_diameter=6.5, wheel_size=width, hub_diameter=10, hub_thickness=30, center_angle=centerAngle, quality=qual); }}
translate([-width/2,0,-22.5]) {rotate([0, 90, 0]) { herringbone_gear(number_of_teeth=14, pressure_angle=24, circular_pitch=300, involute_facets=5, bore_diameter=6.5, wheel_size=width, hub_diameter=10, hub_thickness=30, center_angle=centerAngle, quality=quality); }}

*/

// a M3 hex nut is 2.4mm thick, 5.5mm wide (side to side) and 6.01mm wide (point to point)
// a M3 cap screw is 1.25D (3.75mm) thick, 1.5D (4.5mm) wide
// 6200Z bearings have a 10mm inner diameter, 30mm outer diameter, and 9mm thickness
// the screw holes for the nema motor are 4mm diameter circular at 23.57 mm from the center of the shaft
// the shaft of the nema motor is 6.5mm in diameter


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
translate([10.5,-30,-55]) cube(size = [10, 60, 110]);
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
