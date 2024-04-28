//Show the model of the servo motor, to test fit the servo holder
include <HS422.scad>

//Lego beam library
include <customizable_straight_beam_v4o.scad>

x_show_servo = true;

Lx_margin_servo_butt = 0.5;

//Number of stud fixtures
Nx_stud = 4;
Ny_stud = 7;
Nz_stud = 3;

//Size of a 5 stud lego beam
Ly_size = (Ny_stud-1)*cn_lego_pitch_stud +cn_lego_width_beam;
//Size of a two stack
Lz_size = Nz_stud*cn_lego_pitch_stud;

Ly_width_cover = 3*cn_lego_pitch_stud +(cn_lego_pitch_stud-cn_lego_width_beam)*2;

//the servo rests on Z=0 this margin extends below
Lz_margin = 0;

Lz_thickness_cover = 1.3;

Lz_adapter_depth = (Nz_stud) *cn_lego_pitch_stud;

//Game Margin added to the flange extrusion on Z axis
Lyz_game_flange = 0;


Lx_drill_depth = 0.0;
//Parameters for the cable hole
Lyz_game_cable = 0.0;

//Enlarge the hole
Ld_drill_margin = 0.2;

//Drill into the lateral beams
Lx_flange_drill = 10.0;

module HS422_lego()
{
	translate([-Lx_case,cn_lego_pitch_stud-Ly_top_to_axel*1+1,-Lz_adapter_depth/2])
	difference()
	{
		union()
		{
			//Bottom Cover
			translate([-Lx_margin_servo_butt, -3.6*cn_lego_pitch_stud,0])
			linear_extrude(Lz_thickness_cover)
			square( [Lx_base_to_flange, Ly_butt+cn_lego_pitch_stud/4] );

			//Top Cover
			//It's just a back ledge to keep the butt down?

			//Butt LEGO plate
			translate([-Lx_margin_servo_butt-0.5*cn_lego_width_beam, 2*cn_lego_pitch_stud,0])
			rotate([90,0,-90])
			lego_plate_alternate
			([
				"+++",
				"POP",
				"+++",
				"OPO",
				"+++",
				"POP",
				"+++",
			]);

			//Left LEGO plate
			translate([-1.0*Lx_margin_servo_butt-0.5*cn_lego_width_beam, 2.0*cn_lego_pitch_stud,-Lz_margin])
			rotate([90,0,0])
			lego_plate_alternate
			([
				"+++",
				"POP",
				"OPO",
				"+++",
				"   ",
			]);

			//RIGHT LEGO plate
			translate([-1.0*Lx_margin_servo_butt-0.5*cn_lego_width_beam, -(Ny_stud-3)*cn_lego_pitch_stud,-Lz_margin])
			rotate([90,0,0])
			lego_plate_alternate
			([
				"+++",
				"POP",
				"+++",
				"OPO",
				"   ",
			]);

			
		} //End addition

		union()
		{
			translate([Lx_margin_servo_butt+Lx_case,-Ly_flange+18,0.5*Nz_stud*cn_lego_height_beam-0.5*Lz_depth])
			rotate([0,-90,0])
			linear_extrude(Lx_flange_drill)
			square( [Lz_depth, Ly_flange+2] );

		} //End sutraction

		//Drill the servo connector hole
		//translate([Lx_flange_base-Lyz_game_flange/2,0,-Lyz_game_flange/2])
			//base_box(10.0,Ly_flange+Lyz_game_flange,Lz_depth+Lyz_game_flange );

		//Drill the flange hole
		//translate([-1.1*Lx_margin_servo_butt-1.0*cn_lego_width_beam,Ly_butt/2 -(Ly_height_cable+Lyz_game_cable/2)/2,1])
			//base_box(10.0,Ly_height_cable+Lyz_game_cable,Lz_width_cable +Lyz_game_cable );

		//Drill the M2 hole
		//translate([Lx_flange_base-Lx_drill_depth,Ly_hole_interaxis/2,Lz_depth/2])
			//base_cylinder( D_hole_diameter +Ld_drill_margin, 50 );

		//translate([Lx_flange_base-Lx_drill_depth,-Ly_hole_interaxis/2,Lz_depth/2])
			//base_cylinder( D_hole_diameter +Ld_drill_margin, 50 );


	} //end difference

}

if (x_show_servo == true)
{
	HS422();
}
 
HS422_lego();