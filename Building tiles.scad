include <consts.scad>;

BUILDING_GRIP_PCG = 0.5;

WALL = 3;
RIDGE_WALL = 1;
FLOOR = 2;

TEXT_H = 0.5;

BOX_W = BUILDING_W*3 + WALL*4;
BOX_D =  BUILDING_H*32+WALL*2;

difference() {
    cube([BOX_W, BOX_D, FLOOR + BUILDING_D * BUILDING_GRIP_PCG]);
    translate([WALL, WALL+BUILDING_H, FLOOR]) cube([BUILDING_W, BUILDING_H*31, BUILDING_D]); // Processing
    translate([WALL+(BUILDING_W+WALL), WALL, FLOOR]) cube([BUILDING_W, BUILDING_H*32, BUILDING_D]); // Immediate
    translate([WALL+(BUILDING_W+WALL)*2, WALL, FLOOR]) cube([BUILDING_W, BUILDING_H*32, BUILDING_D]); // Bonus

    translate([WALL+BUILDING_W/2, BOX_D/2, 0]) say("PROCESSING");
    translate([WALL+BUILDING_W/2+(BUILDING_W+WALL), BOX_D/2, 0]) say("IMMEDIATE");
    translate([WALL+BUILDING_W/2+(BUILDING_W+WALL)*2, BOX_D/2, 0]) say("BONUS");

    // Cut out a ridge for the building board to fit under
    translate([0, 0, 0]) cube([BUILDING_W*3 + WALL*4, WALL-RIDGE_WALL, BUILDING_H]);
    translate([0, BUILDING_H*32+WALL*2-WALL+RIDGE_WALL, 0]) cube([BUILDING_W*3 + WALL*4, WALL-RIDGE_WALL, BUILDING_H]);
}

module say(msg) {
    color("blue") translate([0,0,FLOOR-TEXT_H]) rotate(90) linear_extrude(TEXT_H) text(msg, size=5, halign="center", valign="middle");
}
