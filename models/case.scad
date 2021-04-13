// LED strip 5x13

// TODO: Cut-out and mount for range sensor

WALL_THICKNESS = 5;
HOLE_DIAMETER = 152.4;          // 6"
LED_STRIP_WIDTH = 13;
LED_STRIP_HEIGHT = 5;
LED_STRIP_LENGTH = 0;           // no idea yet
BOARD_THICKNESS = 6.35;         // .25"
LED_BRACKET_THICKNESS = 5;
LED_COUNT = 50;                 // Determines the number and width of brackets
ELECTRONICS_BOX_LENGTH = 100;   // guess
ELECTRONICS_BOX_WIDTH = 100;    // guess
ELECTRONICS_BOX_HEIGHT = 30;    // guess

difference(){

    // case body
    union(){

        // light ring
        cylinder(
            r=(HOLE_DIAMETER/2)+LED_STRIP_HEIGHT+LED_BRACKET_THICKNESS+WALL_THICKNESS,
            h=LED_STRIP_WIDTH
        );

        // electronics box
        translate([HOLE_DIAMETER/2,-ELECTRONICS_BOX_WIDTH/2,0]){
            cube([ELECTRONICS_BOX_LENGTH,ELECTRONICS_BOX_WIDTH,ELECTRONICS_BOX_HEIGHT]);
        }
    }

    // corn hole
    cylinder(r=HOLE_DIAMETER/2, h=LED_STRIP_WIDTH);

    // electronics box openings
    translate([
        (HOLE_DIAMETER+WALL_THICKNESS)/2,
        -(ELECTRONICS_BOX_WIDTH-WALL_THICKNESS)/2,
        WALL_THICKNESS
    ]){
        cube([
            ELECTRONICS_BOX_LENGTH-WALL_THICKNESS,
            ELECTRONICS_BOX_WIDTH-WALL_THICKNESS,
            ELECTRONICS_BOX_HEIGHT-WALL_THICKNESS
        ]);
    }
    translate([0,0,LED_STRIP_WIDTH]){
        #cylinder(
            r=(HOLE_DIAMETER/2)+LED_STRIP_HEIGHT+LED_BRACKET_THICKNESS+WALL_THICKNESS,
            h=LED_STRIP_WIDTH*2
        );
    }

    // LED openings
    translate([0,0,WALL_THICKNESS]){
        for (i=[1:LED_COUNT]){
            rotate([0,0,(360/LED_COUNT)*i]){
                translate([(HOLE_DIAMETER/2)-1, -5/2, 0]){
                    #cube([LED_BRACKET_THICKNESS*2, 5, LED_STRIP_WIDTH]);
                }
            }
        }
    }

    // LED strip
    translate([0,0,WALL_THICKNESS]){
        difference(){
            cylinder(r=(HOLE_DIAMETER/2)+LED_STRIP_HEIGHT+LED_BRACKET_THICKNESS, h=LED_STRIP_WIDTH);
            cylinder(r=(HOLE_DIAMETER/2)+LED_BRACKET_THICKNESS, h=LED_STRIP_WIDTH);
        }
    }
}
