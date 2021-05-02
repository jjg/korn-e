module df_player_pro_mount(){
    
    $fn=50;
    
    LENGTH = 24.5;
    WIDTH = 23;
    DEPTH = 3;
    MOUNTING_POST_DIAMETER = 5;
    MOUNTING_HOLE_DIAMETER = 3;
    
    difference(){
        
        union(){
            cube([LENGTH,WIDTH,DEPTH]);
            
            color("green"){
                translate([MOUNTING_POST_DIAMETER/2,(WIDTH-19)/2,0]){
                    cylinder(r=MOUNTING_POST_DIAMETER/2,h=DEPTH+5);
                }
                
                translate([MOUNTING_POST_DIAMETER/2,WIDTH-((WIDTH-19)/2),0]){
                    cylinder(r=MOUNTING_POST_DIAMETER/2,h=DEPTH+5);
                }
            }
        }
        
        // mounting holes
        translate([MOUNTING_POST_DIAMETER/2,(WIDTH-19)/2,DEPTH]){
            cylinder(r=MOUNTING_HOLE_DIAMETER/2,h=DEPTH+2);
        }
        
        translate([MOUNTING_POST_DIAMETER/2,WIDTH-((WIDTH-19)/2),DEPTH]){
            cylinder(r=MOUNTING_HOLE_DIAMETER/2,h=DEPTH+2);
        }
    }
}

df_player_pro_mount();