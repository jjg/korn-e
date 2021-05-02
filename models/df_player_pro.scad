module df_player_pro(){
    
    LENGTH = 24.5;
    WIDTH = 23;
    DEPTH = 3;
    MOUNTING_PAD_DIAMETER = 4;
    MOUNTING_HOLE_DIAMETER = 3;
    
    difference(){
        
        union(){
            cube([LENGTH,WIDTH,DEPTH]);
            
            color("green"){
                translate([MOUNTING_PAD_DIAMETER/2,(WIDTH-19)/2,0]){
                    cylinder(r=MOUNTING_PAD_DIAMETER/2,h=DEPTH);
                }
                
                translate([MOUNTING_PAD_DIAMETER/2,WIDTH-((WIDTH-19)/2),0]){
                    cylinder(r=MOUNTING_PAD_DIAMETER/2,h=DEPTH);
                }
            }
        }
        
        // mounting holes
        translate([MOUNTING_PAD_DIAMETER/2,(WIDTH-19)/2,-1]){
            cylinder(r=MOUNTING_HOLE_DIAMETER/2,h=DEPTH+2);
        }
        
        translate([MOUNTING_PAD_DIAMETER/2,WIDTH-((WIDTH-19)/2),-1]){
            cylinder(r=MOUNTING_HOLE_DIAMETER/2,h=DEPTH+2);
        }
    }
}

df_player_pro();