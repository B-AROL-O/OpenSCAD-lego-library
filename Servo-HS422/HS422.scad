//Use polygon and linear extrude
//The origin is placed at the root of the axel in XY


//HS422 dimensions measured with caliper
//X axis
//Total height of case from base to top of gearbox
Lx_case = 35.5;
//Measure from base to top of bearing of axel
Lx_case_to_bearing = 37.5;
//Add total height with axel
Lx_case_and_axel = 41.3;
//Height of the flanges
Lx_flange_thickness = 2.4;

//Measure position of the flanges from bottom and top
Lx_base_to_flange = 29.5;
Lx_flange_to_top = 9.4;


//Length of the cable stub tot attach to the model
Lx_length_cable = 10.0;

//Lx_butt = (16.4+0.0);
//Lx_body_flange_gearbox = 23.0;


//Y axis
Ly_butt = 40.2;
//Distance between holes measured from the inside, need to add diameter
Ly_hole_interaxis_inner = 44.3;
Ly_flange = 54.3;
Ly_height_cable = 3.0;
//How much a flange extends from the body
Ly_flange_extends = (Ly_flange-Ly_butt)/2;
//Axel offset from top of servo
Ly_top_to_axel = 10.5;

//Z axis
Lz_depth = 20.0;
//I have four holes in a 2X2 configuration, this is vertical stacking
Lz_hole_interaxis = 10.0;

Lz_width_cable = 8.0;

//There is an indent on the bottom side of the gearbox, it's very servo dependent
Lr_indent = 8.0;

//Lz_depth_gearbox = 4.3;
//Diameters
//Holes in the flange
D_hole_diameter = 4.1;
//Servo Axel
D_axel = 5.9;
//Diameter of the bearing at the base of the axel
D_bearing = 12.6;

//Position of the flange from the base
Lx_flange_base = (Lx_base_to_flange -Lx_flange_thickness)/2 + (Lx_case -Lx_flange_to_top)/2;


Ly_hole_interaxis = Ly_hole_interaxis_inner +D_hole_diameter; 

module HS422()
{
	//Create the outline of the base
	aan_points =
	[
		//Top left corner
        [0, 0],
		//Top flange
        [Lx_flange_base, 0],
		[Lx_flange_base, Ly_flange_extends],
		[Lx_flange_base+Lx_flange_thickness, Ly_flange_extends],
		[Lx_flange_base+Lx_flange_thickness, 0],
		//Top right corner
		[Lx_case, 0],
		//Bottom right corner and indent
		[Lx_case, -Ly_butt+Lr_indent],
		[Lx_case-Lr_indent/2, -Ly_butt],
		//Bottom Flange
		[Lx_flange_base+Lx_flange_thickness, -Ly_butt],
		[Lx_flange_base+Lx_flange_thickness, -Ly_butt-Ly_flange_extends],
		[Lx_flange_base, -Ly_butt-Ly_flange_extends],
		[Lx_flange_base, -Ly_butt],
		//Bottom left corner
		[0, -Ly_butt],
    ];
	//Build the geometry, translate it so the axel is in the origin
	translate([-Lx_case,Ly_top_to_axel,-Lz_depth/2])
	color("gray")
	difference()
	{
		union()
		{
			linear_extrude(Lz_depth)
				polygon(aan_points);
		}
		union()
		{
			//Top Top hole
			translate([Lx_flange_base,(Ly_hole_interaxis-Ly_butt)/2,Lz_depth/2+Lz_hole_interaxis/2])
			rotate([0,90,0])
			linear_extrude(Lx_flange_thickness)
			circle(d=D_hole_diameter,$fa=0.5,$fs=0.5);
			//Top Bottom hole
			translate([Lx_flange_base,(Ly_hole_interaxis-Ly_butt)/2,Lz_depth/2-Lz_hole_interaxis/2])
			rotate([0,90,0])
			linear_extrude(Lx_flange_thickness)
			circle(d=D_hole_diameter,$fa=0.5,$fs=0.5);

			//Bottom Top Hole
			translate([Lx_flange_base,-Ly_hole_interaxis+(Ly_hole_interaxis-Ly_butt)/2,Lz_depth/2+Lz_hole_interaxis/2])
			rotate([0,90,0])
			linear_extrude(Lx_flange_thickness)
			circle(d=D_hole_diameter,$fa=0.5,$fs=0.5);
			//Bottom Bottom Hole
			translate([Lx_flange_base,-Ly_hole_interaxis+(Ly_hole_interaxis-Ly_butt)/2,Lz_depth/2-Lz_hole_interaxis/2])
			rotate([0,90,0])
			linear_extrude(Lx_flange_thickness)
			circle(d=D_hole_diameter,$fa=0.5,$fs=0.5);

		}
	}
	//add servo bearing at base of axel

	//Add servo axel in the origin
	color("red")
	rotate([0,90,0])
	linear_extrude(Lx_case_to_bearing-Lx_case)
	circle(d=D_bearing,$fa=0.5,$fs=0.5);


	//Add servo axel in the origin
	color("red")
	rotate([0,90,0])
	linear_extrude(Lx_case_and_axel-Lx_case)
	circle(d=D_hole_diameter,$fa=0.5,$fs=0.5);
}


//Show the model
//HS422();