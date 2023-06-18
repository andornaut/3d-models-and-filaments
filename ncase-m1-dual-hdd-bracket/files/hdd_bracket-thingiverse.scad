$fn=48;

hdd_width = 101.65;
hdd_height = 146.6;
hdd_thickness = 25;

screw_height = 6.35;
screw_distance = 101.6;
screw_offset = 28.5;

other_screw_offset = hdd_height - screw_offset - screw_distance;
other_screw_height = hdd_thickness - screw_height;

hdd = [
  hdd_width,
  hdd_height,
  hdd_thickness,
];

module screw() {
  cylinder(d=3, h=hdd_width + 20);
}

module hdd() {
  cube(hdd);
  translate([-10,0,0]) {
    translate([0,hdd_height - screw_offset,screw_height]) {
      rotate([0,90,0]) screw();
      translate([0,-screw_distance, 0]) rotate([0,90,0])  screw();
    }
  }
}


// hdd

hdd_screw_diameter = 4.5; // this was 3 but now I just want it to be a passthrough for the hard drive screws made for the spacers
hdd_screwhead_diameter = 11.7;
hdd_screw_depth = 4.5;

hdd_hole_distance = 101.6;
hdd_separation = 35;
hdd_hole_offset = 8;

hdd_hole_positions = [
  [0,0,0],
  [0,hdd_hole_distance,0],
  [hdd_separation,0,0],
  [hdd_separation,hdd_hole_distance,0],
];

hdd_offset = [
  22.5,
  other_screw_offset,
  0
];



// Ncase

ncase_screw_diameter = 3;
ncase_screw_depth = 4;

// ssd mounting hole separation
ncase_hole_distance = 76.6;
ncase_hole_offset = 15;

ncase_hole_positions = [
 [0,0,0],
 [0,76.6,0],
 [61.71,0,0],
 [61.71, 76.6,0],
];

ncase_offset = [
  10,
  25,
  0.0
];


// Bracket

bracket_width = 77.5;
bracket_height = other_screw_height + screw_distance + other_screw_offset;
bracket_thickness = 6.75; // any more and you can't use the passthrough screws

bracket = [
  bracket_width,
  bracket_height,
  bracket_thickness,
];

module hdd_screwhole(h = 12) {
  cylinder(d=hdd_screw_diameter, h=h);
  translate([0,0,hdd_screw_depth]) {
    cylinder(d=hdd_screwhead_diameter, h=h);
  }
}

module ncase_screwhole(h=ncase_screw_depth) {
  cylinder(d=ncase_screw_diameter, h=h);
}

module hdd_mounting_positions() {
  for (hole_position = hdd_hole_positions) {
    translate(hole_position) children();
  }
}

module hdd_mounting_holes() {
  hdd_mounting_positions() hdd_screwhole();
}

module ncase_mounting_positions() {
    for (hole_position = ncase_hole_positions) {
      translate(hole_position) children();
    }
}

module ncase_mounting_holes() {
  ncase_mounting_positions() ncase_screwhole();
}

module bracket_body() {
  hull() {
    translate(ncase_offset) ncase_mounting_positions() cylinder(h=bracket_thickness, d=15);
    translate(hdd_offset) hdd_mounting_positions() cylinder(h=bracket_thickness, d=15);
  }
}


module bracket() {
  difference() {
    bracket_body();
    /* %cube(bracket); */
    translate(ncase_offset) {
      translate([0, 0, bracket_thickness - ncase_screw_depth]) {
        ncase_mounting_holes();
      }
    }

    translate(hdd_offset){
      hdd_mounting_holes();
    }
  }
}

bracket();
%translate([(screw_height + hdd_offset.x),0,-hdd_width]) rotate([0,-90,0]) hdd();
%translate([(screw_height + hdd_offset.x) + hdd_separation,0,-hdd_width]) rotate([0,-90,0]) hdd();
