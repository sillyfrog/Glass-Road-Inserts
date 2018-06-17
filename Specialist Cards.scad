include <consts.scad>;

// Needs to be cut in 2 to print on a 220mm bed, select if printing top or bottom
// Also update difference/intersection function below
PRINT_TOP = true;

PRINT_ERROR = 0.5; // Error in a print, for the join

FLOOR = 1.2;

CARD_STACK = 5;

SPINNER_H = 2;
SPINNER_DIA = 14; // Measured 12.19
EDGE_TO_SPINNER = 63.2;
SPINNER_OUTER_TO_OUTER = 126.75;
SPINNER_TO_SPINNER = 115;
BOX_H = FLOOR + CARD_STACK + SPINNER_H;

CARD_W_SPACING = (PRODUCTION_BOARD_W - CARD_W*2)/3;
CARD_D_SPACING = (PRODUCTION_BOARD_D - CARD_D*2)/3;

LIFT_DIA = 25;

R = 0.01;

TEXT_H = 0.5;

TEXT_BASE_BORDER = 3;

TEXT_SIZE = 5;

difference() { // This should be difference/intersection for top/bottom
    difference () {
        cube([PRODUCTION_BOARD_W, PRODUCTION_BOARD_D, BOX_H]);
        translate([PRODUCTION_BOARD_W/2, EDGE_TO_SPINNER, FLOOR+CARD_STACK]) cylinder(d=SPINNER_DIA,h=SPINNER_H+R);
        translate([PRODUCTION_BOARD_W/2, EDGE_TO_SPINNER+SPINNER_TO_SPINNER, FLOOR+CARD_STACK]) cylinder(d=SPINNER_DIA,h=SPINNER_H+R);
        translate([CARD_W_SPACING, CARD_D_SPACING, FLOOR]) cube([CARD_W, CARD_D, CARD_STACK+SPINNER_H+R]);
        translate([CARD_W_SPACING*2+CARD_W, CARD_D_SPACING, FLOOR]) cube([CARD_W, CARD_D, CARD_STACK+SPINNER_H+R]);
        translate([CARD_W_SPACING, CARD_D_SPACING*2+CARD_D, FLOOR]) cube([CARD_W, CARD_D, CARD_STACK+SPINNER_H+R]);
        translate([CARD_W_SPACING*2+CARD_W, CARD_D_SPACING*2+CARD_D, FLOOR]) cube([CARD_W, CARD_D, CARD_STACK+SPINNER_H+R]);
        // Finger lifts
        translate([0, CARD_D_SPACING + CARD_D/2, 0]) cylinder(d=LIFT_DIA, h=BOX_H+R);
        translate([PRODUCTION_BOARD_W, CARD_D_SPACING + CARD_D/2, 0]) cylinder(d=LIFT_DIA, h=BOX_H+R);
        translate([0, CARD_D_SPACING*2 + CARD_D/2 + CARD_D, 0]) cylinder(d=LIFT_DIA, h=BOX_H+R);
        translate([PRODUCTION_BOARD_W, CARD_D_SPACING*2 + CARD_D/2 + CARD_D, 0]) cylinder(d=LIFT_DIA, h=BOX_H+R);

        translate([CARD_W_SPACING + CARD_W/2, (CARD_D_SPACING+CARD_D)*2, 0]) say("RED");
        translate([CARD_W_SPACING*2 + CARD_W/2 + CARD_W, (CARD_D_SPACING+CARD_D)*2, 0]) say("BLUE");
        translate([CARD_W_SPACING + CARD_W/2, (CARD_D_SPACING+CARD_D)*1, 0]) say("GREEN");
        translate([CARD_W_SPACING*2 + CARD_W/2 + CARD_W, (CARD_D_SPACING+CARD_D)*1, 0]) say("YELLOW");
    }

    union() {
        cube([PRODUCTION_BOARD_W, CARD_D_SPACING+CARD_D+TEXT_BASE_BORDER+TEXT_SIZE+1, BOX_H+R]);

        width = 5 + (PRINT_TOP ? PRINT_ERROR : 0);
        dia = 10 + (PRINT_TOP ? PRINT_ERROR : 0);

        translate([PRODUCTION_BOARD_W/4-width/2, CARD_D_SPACING+CARD_D+TEXT_BASE_BORDER+TEXT_SIZE+1, 0]) cube([width, 5, BOX_H+R]);
        translate([PRODUCTION_BOARD_W/4, CARD_D_SPACING+CARD_D+TEXT_BASE_BORDER+TEXT_SIZE+1+6, 0]) cylinder(d=dia, h=BOX_H+R);

        translate([PRODUCTION_BOARD_W/4*3-width/2, CARD_D_SPACING+CARD_D+TEXT_BASE_BORDER+TEXT_SIZE+1, 0]) cube([width, 5, BOX_H+R]);
        translate([PRODUCTION_BOARD_W/4*3, CARD_D_SPACING+CARD_D+TEXT_BASE_BORDER+TEXT_SIZE+1+6, 0]) cylinder(d=dia, h=BOX_H+R);
    }
}

module say(msg) {
    color("blue") translate([0,TEXT_BASE_BORDER,BOX_H-TEXT_H]) linear_extrude(TEXT_H) text(msg, size=TEXT_SIZE, halign="center", valign="middle");
}
