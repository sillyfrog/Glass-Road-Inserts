
TOKEN_DIA = 15.5;
TOKEN_H = 5.3;
TOKEN_GRIP_PCG = 0.4;
TOKEN_WALL = 3;

FLOOR = 2;

BLDNG_BOARD_H = 2;
BLDNG_BOARD_EXTRA = 25; // Distance Building board protrudes from under the production wheels

BOX_D = 107+6; // Match the forest tiles tray
BOX_W = 33.5;
BOX_H = FLOOR + TOKEN_H*8 + BLDNG_BOARD_H;

R=1;

TEXT_H = 0.5;

difference() {
    translate([-BOX_W/2, -BOX_D/2, 0])cube([BOX_W, BOX_D, BOX_H]);
    for(y=[-2,-1,1,2]) {
        for(x=[-1,1]) {
            yoffset = sign(y) * ((abs(y)-1)*BOX_D/4 + BOX_D/8);
            h = (y == -2) ? 8 : 4;
            translate([x*(BOX_W/2-TOKEN_DIA/2), yoffset, BOX_H-TOKEN_H*h]) cylinder(d=TOKEN_DIA, h=TOKEN_H*h+R);
            translate([x*(BOX_W/2-TOKEN_DIA/2+TOKEN_DIA*TOKEN_GRIP_PCG), yoffset, 0]) cylinder(d=TOKEN_DIA, h=BOX_H+R);
        }
    }
    // Cutout for Building board
    translate([-BOX_W/2, -BOX_D/2, 0]) cube([BLDNG_BOARD_EXTRA, BOX_D, BLDNG_BOARD_H]);
}
for(y=[-2,-1,1,2]) {
    for(x=[-1,1]) {
        yoffset = sign(y) * ((abs(y)-1)*BOX_D/4 + BOX_D/8) + TOKEN_DIA/2;
        translate([x*(BOX_W/2), yoffset+1, 0]) {
            if (y == -2 && x == -1) say("FOOD", x);
            if (y == -2 && x ==  1) say("CHRCL", x);
            if (y == -1 &&  x== -1) say("GLASS", x);
            if (y == -1 &&  x==  1) say("WOOD", x);
            if (y == 1 &&  x== -1) say("WATER", x);
            if (y == 1 &&  x==  1) say("QUARTZ", x);
            if (y == 2 &&  x== -1) say("BRICK", x);
            if (y == 2 &&  x==  1) say("CLAY", x);
        }
    }
}

module say(msg, align=1) {
    halign = align > 0 ? "right" : "left";
    color("blue") translate([0,0,BOX_H]) linear_extrude(TEXT_H) text(msg, size=3, halign=halign);
}
