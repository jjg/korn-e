sensor_width = 45.35;
sensor_height = 20.38;
sensor_depth = 15.43;
barrel_edge = 1.8;
barrel_between = 10.21;
barrel_diameter = 15.94;
barrel_height = 12.23;
xtal_height = 3.55;
xtal_width = 10.80;
conn_width = 10.52;
conn_pin_length = 5.41;
flange_length = 15;
flange_depth = 2;

// sensor bounding box (minus connector)
//cube([sensor_width, sensor_height, sensor_depth]);

union(){
	// mounting plate
	rotate([0,-90,0]){
		difference(){
			// mounting plate
			cube([sensor_width + 2, sensor_height + 2, 2]);

			// barrel holes
			translate([barrel_edge+(barrel_diameter/2)+1,barrel_edge+(barrel_diameter/2)+1,-1]){
				#cylinder(r=barrel_diameter/2+.1,h=barrel_height,$fn=50);
			}
			translate([barrel_edge + barrel_between + barrel_diameter + (barrel_diameter/2)+1,barrel_edge+(barrel_diameter/2)+1,-1]){
				#cylinder(r=barrel_diameter/2+.1,h=barrel_height,$fn=50);
			}
		}
	}

	// screw flange
	translate([-2,sensor_height + 2,0]){
		rotate([0,0,-90]){
			difference(){
				cube([flange_depth,flange_length,sensor_width + 2]);
				
				rotate([0,90,0]){
					translate([-(sensor_width/2)+(sensor_width/4),flange_length/2,-flange_depth/2]){
						#cylinder(r=1.5,h=flange_depth+2, $fn=20);
					}

					translate([-(sensor_width/2)-(sensor_width/4),flange_length/2,-flange_depth/2]){
						#cylinder(r=1.5,h=flange_depth+2, $fn=20);
					}
				}
			}
		}
	}
}