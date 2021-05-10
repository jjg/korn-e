include <gusset.scad>

module df_player_pro_mount(){
    
    $fn=50;
    
    LENGTH = 24.5;
    WIDTH = 23;
    DEPTH = 3;
    MOUNTING_POST_HEIGHT = 5;
    MOUNTING_POST_DIAMETER = 5;
    MOUNTING_HOLE_DIAMETER = 2.5;
    GUSSET_COUNT = 3;
    
    difference(){
        
        union(){
            cube([LENGTH,WIDTH,DEPTH]);
            
            // Posts
            color("green"){
                translate([MOUNTING_POST_DIAMETER/2,(WIDTH-19)/2,DEPTH]){
                    cylinder(r=MOUNTING_POST_DIAMETER/2,h=MOUNTING_POST_HEIGHT);
                    
                    // Add gussets
                    for (i=[1:GUSSET_COUNT]){
                        rotate([0,0,(360/GUSSET_COUNT)*i]){
                            translate([(MOUNTING_POST_DIAMETER/2)-(MOUNTING_HOLE_DIAMETER/2), (MOUNTING_POST_DIAMETER/2)-1, 0]){
                                rotate([0,-90,0]){
                                    gusset(MOUNTING_POST_DIAMETER, MOUNTING_POST_HEIGHT, MOUNTING_HOLE_DIAMETER);
                                }
                            }
                        }
                    }

                }
                
                translate([MOUNTING_POST_DIAMETER/2,WIDTH-((WIDTH-19)/2),DEPTH]){
                    cylinder(r=MOUNTING_POST_DIAMETER/2,h=MOUNTING_POST_HEIGHT);
                    
                    // Add gussets
                    for (i=[1:GUSSET_COUNT]){
                        rotate([0,0,(360/GUSSET_COUNT)*i]){
                            translate([(MOUNTING_POST_DIAMETER/2)-(MOUNTING_HOLE_DIAMETER/2), (MOUNTING_POST_DIAMETER/2)-1, 0]){
                                rotate([0,-90,0]){
                                    gusset(MOUNTING_POST_DIAMETER, MOUNTING_POST_HEIGHT, MOUNTING_HOLE_DIAMETER);
                                }
                            }
                        }
                    }
                }
            }
            /*
            // TODO: Gussets (is that the correct term?)
            translate([0,0,0]){
                rotate([0,-90,0]){
                    gusset(MOUNTING_POST_DIAMETER, 5, MOUNTING_HOLE_DIAMETER);
                }
            }
            */
        }
        
        // mounting holes
        translate([MOUNTING_POST_DIAMETER/2,(WIDTH-19)/2,DEPTH]){
            cylinder(r=MOUNTING_HOLE_DIAMETER/2,h=MOUNTING_POST_HEIGHT);
        }
        
        translate([MOUNTING_POST_DIAMETER/2,WIDTH-((WIDTH-19)/2),DEPTH]){
            cylinder(r=MOUNTING_HOLE_DIAMETER/2,h=MOUNTING_POST_HEIGHT);
        }
    }
}

//df_player_pro_mount();