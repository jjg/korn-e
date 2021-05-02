module atmega_breakout_clamp(){
    
    $fn=30;
    
    SCREW_SHAFT_DIAMETER = 3;
    SCREW_HEAD_DIAMETER = 4;
    CHIP_WIDTH = 5;     // guess
    CHIP_LENGTH = 40;   // guess
    CHIP_HEIGHT = 10;   // guess
    CLIP_THICKNESS = 5;
    
    difference(){
        
        cube([CHIP_LENGTH+CLIP_THICKNESS, CHIP_WIDTH, CHIP_HEIGHT+CLIP_THICKNESS]);
        
        // cut-out for chip
        translate([CLIP_THICKNESS,0,0]){
            cube([CHIP_LENGTH, CHIP_WIDTH, CHIP_HEIGHT]);
        }
        
        // cut-out for screw
        translate([CLIP_THICKNESS/2,CHIP_WIDTH/2,0]){
            cylinder(r=SCREW_SHAFT_DIAMETER/2,h=CHIP_HEIGHT+CLIP_THICKNESS);
        }
    }
}

//atmega_breakout_clamp();