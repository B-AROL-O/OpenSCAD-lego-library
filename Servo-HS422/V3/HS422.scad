//Use polygon and linear extrude
//The origin is placed at the root of the axel in XY


    //Body and Flange of the servomotor
    //HS422 dimensions measured with caliper
    // -> height increases
    // | BASE | FLANGE | TOP | AXEL |

//Total height of case from base to top of gearbox
gh_hs422_total = 35.5;
//Measure from base to top of the bearing
gh_hs422_base_to_top = 37.5;
//Add total height with axel
gh_hs422_base_to_axel = 41.3;
//Thickness of the flanges
gh_hs422_flange = 2.4;

//Measure position of the flanges from bottom and top
//Height from base to top of the flange
gh_hs422_base_to_flange_top = 29.5;
//Height from bottom of the flange to top, bearing plane, root of the axel
gh_hs422_flange_bot_to_top = 9.4;

//Length of the base
gl_hs422_base = 40.2;
//Length of the flange, biggest dimension of the servo
gl_hs422_flange = 54.3;

//How much a flange extends from the body
gl_hs422_flange_overhang = (gl_hs422_flange-gl_hs422_base)/2;

//Width of the HS422, the width is consistent across the case
gw_hs422 = 20.0;

//There is an indent on the bottom side of the gearbox, it's very servo dependent
Lr_indent = 8.0;

//Lz_depth_gearbox = 4.3;

//Height from the base to the bottom of the flange.
//I measured from base to top of the flange, from bot of flange to top, and from base to top. I can geometry this measure that is more meaningful
gh_hs422_base_to_flange_bot = (gh_hs422_base_to_flange_top -gh_hs422_flange)/2 + (gh_hs422_total -gh_hs422_flange_bot_to_top)/2;

    //FLANGE HOLES 
    //I have four holes in a 2X2 configuration
//Diameter of the holes in the flange
gd_hs422_hole = 4.1;
//Distance between holes measured from the inside, need to add diameter (It's easier to measure with caliper)
gli_hs422_hole_inner = 44.3;
//Distance between center of the holes
gli_hs422_hole = gli_hs422_hole_inner +gd_hs422_hole; 
//Distance between center of the holes in width
gwi_hs422_hole = 10.0;
//Margin to the hole drill, improves the stl
gm_hs422_hole = 0.1;

    //AXEL
    //The bearing is on the top that protrudes, and from there thaaxel extends upward, the
//Diameter of the bearing at the base of the axel
gd_hs422_bearing = 12.6;
//Axel offset from top of servo
gw_hs422_axel = 10.5;
//Servo Axel. the spline of the axel depends on the servo model, reference the servo-arm folder 
gd_hs422_axel = 5.9;

    //CABLE STUB
    //A small prism representing the servo wiring, helps with accounting for wire routing
//height of the cable stub
gh_hs422_cable_stub = 3.0;
//Width of the cable stub
gw_hs422_cable_stub = 10.0;
//Length of the cable stub
gl_hs422_cable_stub = 25.0;

//Model of the HS422 servo
module HS422()
{
	//Create the outline of the base
	aan_points =
	[
		//Top left corner
        [0, 0],
		//Top flange
        [gh_hs422_base_to_flange_bot, 0],
		[gh_hs422_base_to_flange_bot, gl_hs422_flange_overhang],
		[gh_hs422_base_to_flange_bot+gh_hs422_flange, gl_hs422_flange_overhang],
		[gh_hs422_base_to_flange_bot+gh_hs422_flange, 0],
		//Top right corner
		[gh_hs422_total, 0],
		//Bottom right corner and indent
		[gh_hs422_total, -gl_hs422_base+Lr_indent],
		[gh_hs422_total-Lr_indent/2, -gl_hs422_base],
		//Bottom Flange
		[gh_hs422_base_to_flange_bot+gh_hs422_flange, -gl_hs422_base],
		[gh_hs422_base_to_flange_bot+gh_hs422_flange, -gl_hs422_base-gl_hs422_flange_overhang],
		[gh_hs422_base_to_flange_bot, -gl_hs422_base-gl_hs422_flange_overhang],
		[gh_hs422_base_to_flange_bot, -gl_hs422_base],
		//Bottom left corner
		[0, -gl_hs422_base],
    ];
	//Build the geometry, translate it so the axel is in the origin
	translate([-gh_hs422_total,gh_hs422_axel,-gw_hs422/2])
	color("gray")
	difference()
	{
		union()
		{
			//Body of the servo
			linear_extrude(gw_hs422)
			polygon(aan_points);
			//Cable stub
			translate([6,0,gw_hs422/2])
			rotate([90,0,180])
			linear_extrude(gl_hs422_cable_stub)
			square([gh_hs422_cable_stub, gw_hs422_cable_stub],center=true);
            
		}
		union()
		{
			//Top Top hole
			translate
            ([
                gh_hs422_base_to_flange_bot-gm_hs422_hole/2,
                (gli_hs422_hole-gl_hs422_base)/2,
                gw_hs422/2+gwi_hs422_hole/2
            ])
			rotate([0,90,0])
			linear_extrude(gh_hs422_flange+gm_hs422_hole)
			circle(d=gd_hs422_hole,$fa=0.5,$fs=0.5);

			//Top Bottom hole
			translate
            ([
                gh_hs422_base_to_flange_bot-gm_hs422_hole/2,
                (gli_hs422_hole-gl_hs422_base)/2,
                gw_hs422/2-gwi_hs422_hole/2
            ])
			rotate([0,90,0])
			linear_extrude(gh_hs422_flange+gm_hs422_hole)
			circle(d=gd_hs422_hole,$fa=0.5,$fs=0.5);

			//Bottom Top Hole
			translate
            ([
                gh_hs422_base_to_flange_bot-gm_hs422_hole/2,
                -gli_hs422_hole+(gli_hs422_hole-gl_hs422_base)/2,
                gw_hs422/2+gwi_hs422_hole/2
            ])
			rotate([0,90,0])
			linear_extrude(gh_hs422_flange+gm_hs422_hole)
			circle(d=gd_hs422_hole,$fa=0.5,$fs=0.5);

			//Bottom Bottom Hole
			translate
            ([
                gh_hs422_base_to_flange_bot-gm_hs422_hole/2,
                -gli_hs422_hole+(gli_hs422_hole-gl_hs422_base)/2,
                gw_hs422/2-gwi_hs422_hole/2
            ])
			rotate([0,90,0])
			linear_extrude(gh_hs422_flange+gm_hs422_hole)
			circle(d=gd_hs422_hole,$fa=0.5,$fs=0.5);

		}
	}
    //Bearing under the axel
    color("red")
    rotate([0,90,0])
    linear_extrude(gh_hs422_base_to_top-gh_hs422_total)
    circle(d=gd_hs422_bearing,$fa=0.5,$fs=0.5);

    //Add servo axel in the origin
    color("red")
    rotate([0,90,0])
    linear_extrude(gh_hs422_base_to_axel-gh_hs422_total)
    circle(d=gd_hs422_hole,$fa=0.5,$fs=0.5);

}

module hexagon(id_outer = 0, id_inner = 0)
{
    // If outer diameter is provided
    if (id_outer > 0)
    {
        circle(d = id_outer, $fn = 6);
    }
    // If inner diameter is provided
    else if (id_inner > 0)
    {
        // Compute the outer diameter based on inner diameter
        nd_outer = 2 * id_inner / sqrt(3);
        circle(d = nd_outer, $fn = 6);
    }
}

//I create the positive of the rail that accomodates the servo wire all the way down
module hs422_cable_rail( im_seat, ih_rail, il_rail_top_to_cable, ir_smoothing = 2, in_precision = 0.2 )
{
    
    translate
    ([
        -gh_hs422_base_to_axel/2-(0.5-0.5)*gw_hs422_cable_stub-il_rail_top_to_cable,
        0,
        0
    ])
    linear_extrude(ih_rail)
    square
    (
        [
            gh_hs422_base_to_axel-gw_hs422_cable_stub-il_rail_top_to_cable+im_seat,
            gw_hs422_cable_stub
        ],
        center=true
    );
    translate([-gw_hs422_cable_stub/2+im_seat,0,0])
    linear_extrude(ih_rail)
    circle(d=gw_hs422_cable_stub,$fa=in_precision*2,$fs=in_precision);
}


//Positive of a seat that can house an HS422 servo in a geometry
//Includes positive of the screw drill, optional hex seats for the 
//it is intended to be subtracted from a geometry
//id_screw = diameter of the screw extrusion
//ih_screw = length of the screw
//il_hole_cable = length of the cable hole extrusion
//im_seat = margin in millimeters to add to the HS422 model to make a seat
module hs422_seat( ih_cable_rail = 10, id_screw = 3.3, ih_screw = 50, id_hex_nut = 8, ih_hex_nut = 5, il_hole_cable = 30, iwi_rail_offset = 2, im_seat = 1, in_precision = 0.2 )
{
    //Create the outline of the seat of the HS422
    //I enlarge the length and witdth dimensions by a given amount
    //I enlarge only the BOTTOM dimension. The flange is meant to rest on the flange seat, with some margin at the bottom
    //The cable stub is replaced by an ellipse to safely let the cable trough.
    //The cable hole is the most critical piece of the geometry, really think of how you let it pass
    //The complex top geometry is replaced by a large prism, I need to drill down all the way
	aan_points =
	[
		//Top left corner (widen across length, widen butt)
        [0-im_seat, 0+im_seat],
		//Top flange (widen length, do not widen height, I want flange to rest here, and leave space under the butt )
        [gh_hs422_base_to_flange_bot, 0+im_seat],
		[gh_hs422_base_to_flange_bot, gl_hs422_flange_overhang+im_seat],
		[gh_hs422_total, gl_hs422_flange_overhang+im_seat],
		//Bottom Flange (widen length, do not widen height, I want flange to rest here, and leave space under the butt )
		[gh_hs422_total, -gl_hs422_base-gl_hs422_flange_overhang-im_seat],
		[gh_hs422_base_to_flange_bot, -gl_hs422_base-gl_hs422_flange_overhang-im_seat],
		[gh_hs422_base_to_flange_bot, -gl_hs422_base-im_seat],
		//Bottom left corner (widen across length, widen butt)
		[0-im_seat, -gl_hs422_base-im_seat],
    ];
    //Build the geometry, translate it so the axel is in the origin
	translate([-gh_hs422_total,gw_hs422_axel,-gw_hs422/2])
    color("orange")
    union()
    {
        //Body of the servo
        linear_extrude(gw_hs422)
        polygon(aan_points);

        //Top Top Hole
        translate
        ([
            gh_hs422_base_to_flange_bot-gm_hs422_hole/2,
            (gli_hs422_hole-gl_hs422_base)/2,
            gw_hs422/2+gwi_hs422_hole/2
        ])
        rotate([0,90,180])
        //linear_extrude(gh_hs422_flange+gm_hs422_hole)
        linear_extrude(ih_screw)
        circle(d=id_screw,$fa=in_precision*2,$fs=in_precision);   
        //Hex nut slot on the tip of the hole
        translate
        ([
            gh_hs422_base_to_flange_bot-gm_hs422_hole/2-ih_screw,
            (gli_hs422_hole-gl_hs422_base)/2,
            gw_hs422/2+gwi_hs422_hole/2
        ])
        rotate([0,90,180])
        //linear_extrude(gh_hs422_flange+gm_hs422_hole)
        linear_extrude(ih_hex_nut)
        hexagon(id_outer=id_hex_nut);   

        //Bottom Bottom Hole
        translate
        ([
            gh_hs422_base_to_flange_bot-gm_hs422_hole/2,
            -gli_hs422_hole+(gli_hs422_hole-gl_hs422_base)/2,
            gw_hs422/2-gwi_hs422_hole/2
        ])
        rotate([0,90,180])
        linear_extrude(ih_screw)
        circle(d=id_screw,$fa=in_precision*2,$fs=in_precision);
        //Hex nut slot on the tip of the hole
        translate
        ([
            gh_hs422_base_to_flange_bot-gm_hs422_hole/2-ih_screw,
            -gli_hs422_hole+(gli_hs422_hole-gl_hs422_base)/2,
            gw_hs422/2-gwi_hs422_hole/2
        ])
        rotate([0,90,180])
        //linear_extrude(gh_hs422_flange+gm_hs422_hole)
        linear_extrude(ih_hex_nut)
        hexagon(id_outer=id_hex_nut);  
        
        //Cable extrusion
        translate([0,im_seat,gw_hs422/2-iwi_rail_offset])
        rotate([90,0,180])
        hs422_cable_rail( im_seat, ih_cable_rail, 0);
        //linear_extrude(gl_hs422_cable_stub)
        //circle(d=gh_hs422_cable_stub,$fa=in_precision*2,$fs=in_precision);
        //square([gh_hs422_cable_stub, gw_hs422_cable_stub],center=true);
        
        
    }
    //Add servo axel in the origin
    color("red")
    rotate([0,90,0])
    linear_extrude(1)
    circle(d=gd_hs422_hole,$fa=0.5,$fs=0.5);
}

module HS422_vertical()
{
	translate([0,0,gh_hs422_total])
	rotate([0,-90,0])
	HS422();
}

//Show the model
//HS422();

//HS422_vertical();

hs422_seat();