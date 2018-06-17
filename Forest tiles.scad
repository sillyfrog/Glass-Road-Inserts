include <consts.scad>;

WALL = 2;
FLOOR = 2;

TEXT_H = 0.5;

BOX_W = FOREST_W + WALL * 2;
BOX_D = 90 - 33.5 - 2; // Size such it will fit next to the Goods tokens

difference() {
    cube([BOX_W, BOX_D, FLOOR + FOREST_D * BUILDING_GRIP_PCG]);
    translate([WALL, (BOX_D - FOREST_H * 25)/2, FLOOR]) cube([FOREST_W, FOREST_H * 25, FOREST_D]); // Processing

    translate([BOX_W/2, BOX_D/2,0]) say("FOREST");
}

module say(msg) {
    color("blue") translate([0,0,FLOOR-TEXT_H]) linear_extrude(TEXT_H) text(msg, size=5, halign="center", valign="middle");
}
