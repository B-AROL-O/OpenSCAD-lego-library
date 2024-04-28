include <custom_lib.scad>


//SCS0009 dimensions measured with caliper
//X axis
//Total height of case from base to top of gearbox
Lx_case = 25.1;
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
Ly_butt = 23.2;
Ly_hole_interaxis = 28.0;
Ly_flange = 32.6;
Ly_height_cable = 3.0;

//Z axis
Lz_depth = 12.1;

Lz_width_cable = 8.0;

//Lz_depth_gearbox = 4.3;
//Diameters
//Holes in the flange
D_hole_diameter = 2.1;
//Servo Axel
D_axel = 3.9;


//Lx_gearbox_thickness = Lx_body_flange_gearbox -Lx_flange_thickness -Lx_butt;
//ly_flange_length = (Ly_flange-Ly_butt)/2;

module scs0009()
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
		};
		translate([Lx_flange_base, Ly_hole_interaxis/2, Lz_depth/2])
			base_cylinder( D_hole_diameter, Lx_flange_thickness );
		translate([Lx_flange_base, -Ly_hole_interaxis/2, Lz_depth/2])
			base_cylinder( D_hole_diameter, Lx_flange_thickness );
	}
}

//Show the model
//scs0009();