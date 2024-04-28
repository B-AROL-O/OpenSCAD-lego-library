include <custom_lib.scad>

//Use polygon and linear extrude
//The origin is placed at the root of the axel in XY


//HS422 dimensions measured with caliper
//X axis
//Total height of case from base to top of gearbox
Lx_case = 35.5;
//Add total height with axel
Lx_case_and_axel = 27.3;
//Height of the flanges
Lx_flange_thickness = 1.6;
//Position of the flanges
//8.8 from case
//18.8 from base
Lx_flange_base = (18.8 -Lx_flange_thickness)/2 + (Lx_case -8.8)/2;
//Length of the cable stub tot attach to the model
Lx_length_cable = 10.0;

//Lx_butt = (16.4+0.0);
//Lx_body_flange_gearbox = 23.0;


//Y axis
Ly_butt = 40.2;
Ly_hole_interaxis = 28.0;
Ly_flange = 54.3;
Ly_height_cable = 3.0;
//How much a flange extends from the body
Ly_flange_extends = (Ly_flange-Ly_butt)/2;

//Z axis
Lz_depth = 20.0;

Lz_width_cable = 8.0;

//There is an indent on the bottom side of the gearbox, it's very servo dependent
Lr_indent = 8.0;

//Lz_depth_gearbox = 4.3;
//Diameters
//Holes in the flange
D_hole_diameter = 2.1;
//Servo Axel
D_axel = 3.9;


//Lx_gearbox_thickness = Lx_body_flange_gearbox -Lx_flange_thickness -Lx_butt;
//ly_flange_length = (Ly_flange-Ly_butt)/2;

module HS422_OLD()
{
	color("black")
	difference()
	{
		union()
		{
			//case. the top has a more complex shape, I use just a box
			base_box(Lx_case, Ly_butt, Lz_depth);
			//add the flange
			translate([Lx_flange_base,0,0])
				base_box(Lx_flange_thickness, Ly_flange, Lz_depth);
			//add the axel
			translate([Lx_case,Lz_depth/2,Lz_depth/2])
				base_cylinder( D_axel, Lx_case_and_axel-Lx_case );
			//Add the cable leaving from the back
			translate([-Lx_length_cable,Ly_butt/2-Ly_height_cable/2,Lz_depth/2-Lz_width_cable/2])
				base_box(Lx_length_cable, Ly_height_cable, Lz_width_cable);
		}
		union()
		{
			translate([Lx_flange_base, Ly_hole_interaxis/2, Lz_depth/2])
				base_cylinder( D_hole_diameter, Lx_flange_thickness );
			translate([Lx_flange_base, -Ly_hole_interaxis/2, Lz_depth/2])
				base_cylinder( D_hole_diameter, Lx_flange_thickness );
		}
	}
}


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
	//Build the geometry
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
			translate([Lx_flange_base, Ly_hole_interaxis/2, Lz_depth/2])
				base_cylinder( D_hole_diameter, Lx_flange_thickness );
			translate([Lx_flange_base, -Ly_hole_interaxis/2, Lz_depth/2])
				base_cylinder( D_hole_diameter, Lx_flange_thickness );
		}
	}
}


//Show the model
HS422();