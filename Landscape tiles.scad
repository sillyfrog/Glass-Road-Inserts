include <consts.scad>;


WALL = 3;
RIDGE_WALL = 1;
FLOOR = 2;

TEXT_H = 0.5;

BOX_W = BUILDING_W + WALL*2;
BOX_D =  (BUILDING_H*18+WALL)*3 + WALL;

difference() {
    cube([BOX_W, BOX_D, FLOOR + BUILDING_D * BUILDING_GRIP_PCG]);
    translate([WALL, WALL, FLOOR]) cube([BUILDING_W, BUILDING_H*18, BUILDING_D]); // Pits
    translate([WALL, WALL+(BUILDING_H*18+WALL), FLOOR]) cube([BUILDING_W, BUILDING_H*18, BUILDING_D]); // Groves
    translate([WALL, WALL+(BUILDING_H*18+WALL)*2, FLOOR]) cube([BUILDING_W, BUILDING_H*18, BUILDING_D]); // Ponds

    translate([BOX_W/2, WALL+BUILDING_H*9+(BUILDING_H*18+WALL)*0, 0]) say("PITS");
    translate([BOX_W/2, WALL+BUILDING_H*9+(BUILDING_H*18+WALL)*1, 0]) say("GROVES");
    translate([BOX_W/2, WALL+BUILDING_H*9+(BUILDING_H*18+WALL)*2, 0]) say("PONDS");
}

module say(msg) {
    color("blue") translate([0,0,FLOOR-TEXT_H]) linear_extrude(TEXT_H) text(msg, size=5, halign="center", valign="middle");
}
