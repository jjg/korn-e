include <atmega_breakout.scad>


module atmega_breakout_mount(){
    
    LENGTH = 25;    // guess
    WIDTH = 15;     // guess
    DEPTH = 10;     // default
    
    difference(){
        
        cube([LENGTH, WIDTH, DEPTH]);
        
        translate([(LENGTH/2) - (20/2),(WIDTH/2)-(10/2),5]){
            #atmega_breakout();
        }
    }
}

atmega_breakout_mount();