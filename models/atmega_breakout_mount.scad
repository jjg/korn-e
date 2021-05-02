include <atmega_breakout.scad>


module atmega_breakout_mount(){
    
    LENGTH = 50;
    WIDTH = 26;
    DEPTH = 10;     // guess
    
    difference(){
        
        cube([LENGTH, WIDTH, DEPTH]);
        
        translate([(LENGTH/2) - (46/2),(WIDTH/2)-(24/2),3]){
            atmega_breakout();
        }
        
        translate([((LENGTH/2) - (46/2)) + 1,((WIDTH/2)-(24/2))+1, 8]){
            cube([46-2, 24-2, DEPTH]);
        }
    }
}

atmega_breakout_mount();