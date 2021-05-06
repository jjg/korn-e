include <ping_sensor_mount.scad>
include <atmega_breakout_clamp.scad>
include <df_player_pro_mount.scad>


WALL_THICKNESS = 5;
HOLE_DIAMETER = 152.4;
LED_STRIP_WIDTH = 45; //30;         // TODO: Make sure there's still enough room for the LED strip now before printing!
LED_STRIP_HEIGHT = 5;
LED_BRACKET_THICKNESS = 5;
LED_COUNT = 29;                     // Determines the number and width of brackets
ELECTRONICS_BOX_LENGTH = 100;
ELECTRONICS_BOX_WIDTH = 120;
ELECTRONICS_BOX_HEIGHT = 45; //30;
MOUNTING_HOLE_COUNT = 6;
MOUNTING_SCREW_HEAD_DIAMETER = 8.4; //8.38;
MOUNTING_SCREW_SHAFT_DIAMETER = 4; //3.83;
MOUNTING_SCREW_TAPER_LENGTH = 3.5;
MOUNTING_SCREW_LENGTH = 50.8;       // 2 inches

difference(){

    // case body
    union(){

        // light ring
        cylinder(
            r=(HOLE_DIAMETER/2)+LED_STRIP_HEIGHT+LED_BRACKET_THICKNESS+WALL_THICKNESS,
            h=LED_STRIP_WIDTH
        );

        // electronics box
        translate([(HOLE_DIAMETER/2)-10,-ELECTRONICS_BOX_WIDTH/2,0]){
            cube([ELECTRONICS_BOX_LENGTH,ELECTRONICS_BOX_WIDTH,ELECTRONICS_BOX_HEIGHT]);
        }
    }

    // corn hole
    cylinder(r=HOLE_DIAMETER/2, h=LED_STRIP_WIDTH);

    // electronics box openings
    translate([
        ((HOLE_DIAMETER+WALL_THICKNESS)/2),
        -(ELECTRONICS_BOX_WIDTH-WALL_THICKNESS)/2,
        WALL_THICKNESS
    ]){
        #cube([
            ELECTRONICS_BOX_LENGTH-WALL_THICKNESS-10,
            ELECTRONICS_BOX_WIDTH-WALL_THICKNESS,
            ELECTRONICS_BOX_HEIGHT-WALL_THICKNESS
        ]);
    }
    
    // Big circle cut-out (?)
    /*
    translate([0,0,LED_STRIP_WIDTH]){
        #cylinder(
            r=(HOLE_DIAMETER/2)+LED_STRIP_HEIGHT+LED_BRACKET_THICKNESS+WALL_THICKNESS,
            h=LED_STRIP_WIDTH*2
        );
    }
    */

    // LED openings
    // Note: lift above the sensor height (20.38)
    translate([0,0,WALL_THICKNESS+20.38]){  
        for (i=[1:LED_COUNT]){
            rotate([0,0,(360/LED_COUNT)*i]){
                translate([(HOLE_DIAMETER/2)-1, -5/2, 0]){
                    cube([LED_BRACKET_THICKNESS*2, 10, LED_STRIP_WIDTH]);
                }
            }
        }
    }

    // LED strip
    // Note: lift above the sensor height (20.38)
    translate([0,0,WALL_THICKNESS+20.38]){
        difference(){
            cylinder(r=(HOLE_DIAMETER/2)+LED_STRIP_HEIGHT+LED_BRACKET_THICKNESS, h=LED_STRIP_WIDTH);
            cylinder(r=(HOLE_DIAMETER/2)+LED_BRACKET_THICKNESS, h=LED_STRIP_WIDTH);
        }
    }
    
    // Sensor opening
    translate([(HOLE_DIAMETER/2)-6,-(45.35/2),WALL_THICKNESS]){
        cube([15,47,ELECTRONICS_BOX_HEIGHT]);
    }
    
    // TODO: Power input hole (8mm)
    // TODO: External LED cable hole
    // TODO: Speaker output hole
}

// Mounting points

// Sensor
translate([(HOLE_DIAMETER/2)+2.5,-(45.35/2),20.38+WALL_THICKNESS+1]){
    rotate([-90,0,0]){
        ping_sensor_mount();
    }
}

// Sound board mount
translate([(HOLE_DIAMETER/2+65),20,2]){
    df_player_pro_mount();
}

// Atmega board mount
// NOTE: Only for example, print separately!
/*
translate([(HOLE_DIAMETER/2)+40,-30,2]){
    atmega_breakout_clamp();
}
*/

// Mounting holes (for mounting to board)
translate([0,0,0]){
    for (i=[1:MOUNTING_HOLE_COUNT]){
        rotate([0,0,(360/MOUNTING_HOLE_COUNT)*i]){
            //translate([(HOLE_DIAMETER/2)+LED_STRIP_HEIGHT+LED_BRACKET_THICKNESS+WALL_THICKNESS+2, -5/2, 0]){
            translate([(HOLE_DIAMETER/2)+LED_STRIP_HEIGHT+LED_BRACKET_THICKNESS+(MOUNTING_SCREW_HEAD_DIAMETER/2)+WALL_THICKNESS, -5/2, 0]){
                // Skip the one that lands inside the electronics box.
                if(i!=MOUNTING_HOLE_COUNT){
                    difference(){
                        
                        // Mounting post
                        cylinder(r=(MOUNTING_SCREW_HEAD_DIAMETER/2+(WALL_THICKNESS/2)),h=ELECTRONICS_BOX_HEIGHT);
                        
                        // Mounting screw hole
                        cylinder(r=(MOUNTING_SCREW_SHAFT_DIAMETER)/2,h=MOUNTING_SCREW_LENGTH);
                        
                        // Countersink
                        cylinder(r1=MOUNTING_SCREW_HEAD_DIAMETER/2,r2=MOUNTING_SCREW_SHAFT_DIAMETER/2,h=MOUNTING_SCREW_TAPER_LENGTH);
                    }
                }
            }
        }
    }
}

translate([(HOLE_DIAMETER/2)+ELECTRONICS_BOX_LENGTH-MOUNTING_SCREW_SHAFT_DIAMETER-WALL_THICKNESS,(ELECTRONICS_BOX_WIDTH/2)+(MOUNTING_SCREW_HEAD_DIAMETER/2),0]){
    difference(){
        // Mounting post
        cylinder(r=(MOUNTING_SCREW_HEAD_DIAMETER/2+(WALL_THICKNESS/2)),h=ELECTRONICS_BOX_HEIGHT);
        
        // Mounting screw hole
        cylinder(r=(MOUNTING_SCREW_SHAFT_DIAMETER)/2,h=MOUNTING_SCREW_LENGTH);
        
        // Countersink
        cylinder(r1=MOUNTING_SCREW_HEAD_DIAMETER/2,r2=MOUNTING_SCREW_SHAFT_DIAMETER/2,h=MOUNTING_SCREW_TAPER_LENGTH);
    }
}

translate([(HOLE_DIAMETER/2)+ELECTRONICS_BOX_LENGTH-MOUNTING_SCREW_SHAFT_DIAMETER-WALL_THICKNESS,-(ELECTRONICS_BOX_WIDTH/2)-(MOUNTING_SCREW_HEAD_DIAMETER/2),0]){
    difference(){
        // Mounting post
        cylinder(r=(MOUNTING_SCREW_HEAD_DIAMETER/2+(WALL_THICKNESS/2)),h=ELECTRONICS_BOX_HEIGHT);
        
        // Mounting screw hole
        cylinder(r=(MOUNTING_SCREW_SHAFT_DIAMETER)/2,h=MOUNTING_SCREW_LENGTH);
        
        // Countersink
        cylinder(r1=MOUNTING_SCREW_HEAD_DIAMETER/2,r2=MOUNTING_SCREW_SHAFT_DIAMETER/2,h=MOUNTING_SCREW_TAPER_LENGTH);
    }
}

