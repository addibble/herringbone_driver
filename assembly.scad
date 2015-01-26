include <parametric_involute_gear_v5.0.scad>
include <rack_herringbone.scad>

// 100 for production
// 10 for rough
// 3 for active dev
qual=3;

// gear parameters
pi=3.1415926535897932384626433832795;
diametralPitch=12;
gear_pressure_angle=24;
rack_pressure_angle=gear_pressure_angle*pi/180;
centerAngle=30;//angle at center of teeth
gear_width=20;
gear_circular_pitch=300;
gear_height=((1/diametralPitch)+(1.25/diametralPitch))*20;
middle_height = gear_width-gear_height;
gear_num_teeth=20;
rack_num_teeth=20;
rack_length=168;

// part parameters
screw_head_radius=4.5/2;
screw_head_thickness=3.75;
screw_shaft_radius=3/2;
spacer_radius=screw_shaft_radius*2;
spacer_height=(gear_width/2)+5.1;
plate_length=112;
plate_width=56;
plate_bearing_wall_thickness=0.1;
plate_bearing_wall_radius=10;
bearing_thickness=9;
plate_thickness=(bearing_thickness/2)+plate_bearing_wall_thickness;
axle_to_axle=56;
bearing_outer_radius=15;
bearing_inner_radius=5;
motor_shaft_diameter=6.5;
motor_mount_width=47.14;
motor_mount_hole=4;
nut_thickness=2.4;
nut_width=6.01;
nut_face_width=5.5;
gear_hub_thickness=(plate_thickness*2)+(spacer_height-(gear_width/2));
echo(gear_hub_thickness);

// assembly
plate1();
translate([0,0,plate_thickness]) plate2();
translate([0,0,(plate_thickness*3+2*spacer_height)]) mirror([0,0,1]) plate2();
translate([0,0,(plate_thickness*4+2*spacer_height)]) mirror([0,0,1]) plate4();
translate([plate_width/2,  (plate_length/2-axle_to_axle/2), gear_hub_thickness+gear_width/2]) hubgear();
translate([plate_width/2,  (plate_length/2+axle_to_axle/2), gear_hub_thickness+gear_width/2]) hubgear();

// print
/*
plate1();
translate([plate_width+5, 0, 0]) plate2();
translate([2*(plate_width+5), 0, 0]) plate2();
translate([3*(plate_width+5), 0, 0]) plate4();
*/


module plate1() {
  difference() {
    bearing_plate();
    motor_mount_shaft();
    translate([0, axle_to_axle, 0]) motor_mount_shaft();
    spacershafts();
    spacernutholes();
  }
}

module plate4() {
  difference() {
    bearing_plate();
    motor_mount_shaft();
    translate([0, axle_to_axle, 0]) motor_mount_shaft();
    spacershafts();
    spacerscrewheadholes();
  }
}

module spacershafts() {
          // spacer shafts -- bottom
          translate([plate_width/2,(plate_length/2-axle_to_axle/2-motor_mount_width/2),-plate_thickness-0.1]) cylinder(r=screw_shaft_radius, h=plate_thickness+spacer_height+0.2, $fn=qual*4);
          translate([plate_width/2-(motor_mount_width/2),(plate_length/2-axle_to_axle/2),-plate_thickness-0.1]) cylinder(r=screw_shaft_radius, h=plate_thickness+spacer_height+0.2, $fn=qual*4);
          translate([plate_width/2+(motor_mount_width/2),(plate_length/2-axle_to_axle/2),-plate_thickness-0.1]) cylinder(r=screw_shaft_radius, h=plate_thickness+spacer_height+0.2, $fn=qual*4);
          // spacer shafts -- top
          translate([plate_width/2,(plate_length/2+axle_to_axle/2+motor_mount_width/2),-plate_thickness-0.1]) cylinder(r=screw_shaft_radius, h=plate_thickness+spacer_height+0.2, $fn=qual*4);
          translate([plate_width/2-(motor_mount_width/2),(plate_length/2+axle_to_axle/2),-plate_thickness-0.1]) cylinder(r=screw_shaft_radius, h=plate_thickness+spacer_height+0.2, $fn=qual*4);
          translate([plate_width/2+(motor_mount_width/2),(plate_length/2+axle_to_axle/2),-plate_thickness-0.1]) cylinder(r=screw_shaft_radius, h=plate_thickness+spacer_height+0.2, $fn=qual*4);
}

module spacerscrewheadholes() {
          // spacer shafts -- bottom
          translate([plate_width/2,(plate_length/2-axle_to_axle/2-motor_mount_width/2),-0.1]) cylinder(r=screw_head_radius, h=screw_head_thickness, $fn=qual*4);
          translate([plate_width/2-(motor_mount_width/2),(plate_length/2-axle_to_axle/2),-0.1]) cylinder(r=screw_head_radius, h=screw_head_thickness, $fn=qual*4);
          translate([plate_width/2+(motor_mount_width/2),(plate_length/2-axle_to_axle/2),-0.1]) cylinder(r=screw_head_radius, h=screw_head_thickness, $fn=qual*4);
          // spacer shafts -- top
          translate([plate_width/2,(plate_length/2+axle_to_axle/2+motor_mount_width/2),-0.1]) cylinder(r=screw_head_radius, h=screw_head_thickness, $fn=qual*4);
          translate([plate_width/2-(motor_mount_width/2),(plate_length/2+axle_to_axle/2),-0.1]) cylinder(r=screw_head_radius, h=screw_head_thickness, $fn=qual*4);
          translate([plate_width/2+(motor_mount_width/2),(plate_length/2+axle_to_axle/2),-0.1]) cylinder(r=screw_head_radius, h=screw_head_thickness, $fn=qual*4);
}
module spacernutholes() {
          // spacer shafts -- bottom
          translate([plate_width/2,(plate_length/2-axle_to_axle/2-motor_mount_width/2),nut_thickness/2-0.1]) hexagon(nut_width, nut_thickness);
          translate([plate_width/2-(motor_mount_width/2),(plate_length/2-axle_to_axle/2),nut_thickness/2-0.1]) hexagon(nut_width, nut_thickness);
          translate([plate_width/2+(motor_mount_width/2),(plate_length/2-axle_to_axle/2),nut_thickness/2-0.1]) hexagon(nut_width, nut_thickness);
          // spacer shafts -- top
          translate([plate_width/2,(plate_length/2+axle_to_axle/2+motor_mount_width/2),nut_thickness/2-0.1]) hexagon(nut_width, nut_thickness);
          translate([plate_width/2-(motor_mount_width/2),(plate_length/2+axle_to_axle/2),nut_thickness/2-0.1]) hexagon(nut_width, nut_thickness);
          translate([plate_width/2+(motor_mount_width/2),(plate_length/2+axle_to_axle/2),nut_thickness/2-0.1]) hexagon(nut_width, nut_thickness);
}

module spacers() {
            // spacers - bottom
            translate([plate_width/2,(plate_length/2-axle_to_axle/2-motor_mount_width/2), 0]) cylinder(r=spacer_radius, h=spacer_height, $fn=qual*4);
            translate([plate_width/2-(motor_mount_width/2),(plate_length/2-axle_to_axle/2), 0]) cylinder(r=spacer_radius, h=spacer_height, $fn=qual*4);
            translate([plate_width/2+(motor_mount_width/2),(plate_length/2-axle_to_axle/2), 0]) cylinder(r=spacer_radius, h=spacer_height, $fn=qual*4);
            // spacers - top
            translate([plate_width/2,(plate_length/2+axle_to_axle/2+motor_mount_width/2), 0]) cylinder(r=spacer_radius, h=spacer_height, $fn=qual*4);
            translate([plate_width/2-(motor_mount_width/2),(plate_length/2+axle_to_axle/2), 0]) cylinder(r=spacer_radius, h=spacer_height, $fn=qual*4);
            translate([plate_width/2+(motor_mount_width/2),(plate_length/2+axle_to_axle/2), 0]) cylinder(r=spacer_radius, h=spacer_height, $fn=qual*4);
}

module plate2() {
    translate([0,0,plate_thickness]) {
        difference() {
          union() {
            mirror([0,0,1]) {
              bearing_plate_inner();
            }
            spacers();
          }
          mirror([0,0,1]) motor_mount_shaft();
          mirror([0,0,1]) translate([0, axle_to_axle, 0]) motor_mount_shaft();
          mirror([0,0,1]) motor_mount_screwheads();
          mirror([0,0,1]) translate([0, axle_to_axle, 0]) motor_mount_screwheads();
          spacershafts();
        }
    }
}

module bearing_plate_inner() {
difference() {
cube(size = [plate_width, plate_length, plate_thickness]);
translate([plate_width/2, (plate_length/2-axle_to_axle/2), -0.1]) cylinder(r=bearing_outer_radius, h=bearing_thickness/2+1, $fn=qual*8);
translate([plate_width/2, (plate_length/2+axle_to_axle/2), -0.1]) cylinder(r=bearing_outer_radius, h=bearing_thickness/2+1, $fn=qual*8);
}
}

module bearing_plate() {
difference() {
cube(size = [plate_width, plate_length, plate_thickness]);
translate([plate_width/2, (plate_length/2-axle_to_axle/2), plate_bearing_wall_thickness]) cylinder(r=bearing_outer_radius, h=bearing_thickness/2+1, $fn=qual*8);
translate([plate_width/2, (plate_length/2-axle_to_axle/2), -0.1]) cylinder(r=plate_bearing_wall_radius, h=bearing_thickness/2+1, $fn=qual*8);
translate([plate_width/2, (plate_length/2+axle_to_axle/2), plate_bearing_wall_thickness]) cylinder(r=bearing_outer_radius, h=bearing_thickness/2+1, $fn=qual*8);
translate([plate_width/2, (plate_length/2+axle_to_axle/2), -0.1]) cylinder(r=plate_bearing_wall_radius, h=bearing_thickness/2+1, $fn=qual*8);
}
}

module motor_mount_shaft() {
translate([plate_width/2+motor_mount_width/2, (plate_length/2-axle_to_axle/2+motor_mount_width/2), -0.1]) cylinder(r=screw_shaft_radius, h=bearing_thickness/2+1, $fn=qual*4);
translate([plate_width/2-(motor_mount_width/2), (plate_length/2-axle_to_axle/2+motor_mount_width/2), -0.1]) cylinder(r=screw_shaft_radius, h=bearing_thickness/2+1, $fn=qual*4);
translate([plate_width/2+motor_mount_width/2, (plate_length/2-axle_to_axle/2-motor_mount_width/2), -0.1]) cylinder(r=screw_shaft_radius, h=bearing_thickness/2+1, $fn=qual*4);
translate([plate_width/2-(motor_mount_width/2), (plate_length/2-axle_to_axle/2-motor_mount_width/2), -0.1]) cylinder(r=screw_shaft_radius, h=bearing_thickness/2+1, $fn=qual*4);
}

module motor_mount_screwheads() {
translate([plate_width/2+motor_mount_width/2, (plate_length/2-axle_to_axle/2+motor_mount_width/2), -0.1]) cylinder(r=screw_head_radius, h=screw_head_thickness, $fn=qual*4);
translate([plate_width/2-(motor_mount_width/2), (plate_length/2-axle_to_axle/2+motor_mount_width/2), -0.1]) cylinder(r=screw_head_radius, h=screw_head_thickness, $fn=qual*4);
translate([plate_width/2+motor_mount_width/2, (plate_length/2-axle_to_axle/2-motor_mount_width/2), -0.1]) cylinder(r=screw_head_radius, h=screw_head_thickness, $fn=qual*4);
translate([plate_width/2-(motor_mount_width/2), (plate_length/2-axle_to_axle/2-motor_mount_width/2), -0.1]) cylinder(r=screw_head_radius, h=screw_head_thickness, $fn=qual*4);
}


module doublerack() {
  union() {
    translate([0, 0, (gear_height+middle_height)/2]) {
      herringbone_rack(width,diametralPitch,rack_num_teeth,rack_pressure_angle,centerAngle);
    }
    translate([0, 0, -(gear_height+middle_height)/2]) {
      mirror([0, 0, 1]) {
        herringbone_rack(width,diametralPitch,rack_num_teeth,rack_pressure_angle,centerAngle);
      }
    }
    cube(size = [gear_width, rack_length, middle_height], center = true);
  }
}

module hubgear() {
  herringbone_gear(number_of_teeth=gear_num_teeth, pressure_angle=gear_pressure_angle, circular_pitch=gear_circular_pitch, involute_facets=qual, bore_diameter=motor_shaft_diameter, wheel_size=gear_width, hub_diameter=bearing_inner_radius*2, hub_thickness=gear_hub_thickness, center_angle=centerAngle, slices=qual, quality=qual);
}

module hexagon(size, height) {
  boxWidth = size/1.75;
  for (r = [-60, 0, 60]) rotate([0,0,r]) cube([boxWidth, size, height], true);
}
