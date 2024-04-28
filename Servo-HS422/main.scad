//Show the model of the servo motor, to test fit the servo holder
include <SCS0009.scad>

//
include <customizable_straight_beam_v4o.scad>

x_show_servo = false;

Lx_margin_servo_butt = 2.0;

//Size of a 5 stud lego beam
Ly_size = 4*cn_lego_pitch_stud +cn_lego_width_beam;
//Size of a two stack
Lz_size = 2*cn_lego_pitch_stud;

Ly_width_cover = 3*cn_lego_pitch_stud +(cn_lego_pitch_stud-cn_lego_width_beam)*2;

//the servo rests on Z=0 this margin extends below
Lz_margin = (2*cn_lego_pitch_stud -Lz_depth) /2;

Lz_thickness_cover = 1.2;

//Game Margin added to the flange extrusion on Z axis
Lyz_game_flange = 1.0;


Lx_drill_depth = 5.0;
//Parameters for the cable hole
Lyz_game_cable = 2.0;

//Enlarge the hole
Ld_drill_margin = 0.2;

//translate([-0,-20,0])
//rotate([0,0,90])
//lego_beam("oO+P+Oo");
//0*Ly_hole_interaxis/2+0*cn_lego_height_beam/2+0*4

module scs0009_lego()
{
	difference()
	{
		union()
		{
			//Make the bottom cover
			translate([-Lx_margin_servo_butt,0,-Lz_margin])
				base_box(21.0,Ly_width_cover,Lz_thickness_cover );

			//Make the top bottom cover
			translate([-Lx_margin_servo_butt,0, 2*cn_lego_pitch_stud -Lz_margin -Lz_thickness_cover])
				base_box(21.0,Ly_width_cover,Lz_thickness_cover );

			//Butt LEGO plate
			translate([-Lx_margin_servo_butt-0.5*cn_lego_width_beam, 2*cn_lego_pitch_stud,-Lz_margin])
			rotate([90,0,-90])
			lego_plate_alternate
			([
				"++",
				"  ",
				"OO",
				"PP",
				"++",
			]);

			//Left LEGO plate
			translate([-1.0*Lx_margin_servo_butt-0.5*cn_lego_width_beam, 2.0*cn_lego_pitch_stud,-Lz_margin])
			rotate([90,0,0])
			lego_plate_alternate
			([
				"++",
				"PP",
				"++",
				"  "
			]);

			//RIGHT LEGO plate
			translate([-1.0*Lx_margin_servo_butt-0.5*cn_lego_width_beam, -2.0*cn_lego_pitch_stud,-Lz_margin])
			rotate([90,0,0])
			lego_plate_alternate
			([
				"++",
				"PP",
				"++",
				"  ",
			]);

			
		} //End union

		//Drill the servo connector hole
		translate([Lx_flange_base-Lyz_game_flange/2,0,-Lyz_game_flange/2])
			base_box(10.0,Ly_flange+Lyz_game_flange,Lz_depth+Lyz_game_flange );

		//Drill the flange hole
		translate([-1.1*Lx_margin_servo_butt-1.0*cn_lego_width_beam,Ly_butt/2 -(Ly_height_cable+Lyz_game_cable/2)/2,1])
			base_box(10.0,Ly_height_cable+Lyz_game_cable,Lz_width_cable +Lyz_game_cable );

		//Drill the M2 hole
		translate([Lx_flange_base-Lx_drill_depth,Ly_hole_interaxis/2,Lz_depth/2])
			base_cylinder( D_hole_diameter +Ld_drill_margin, 50 );

		translate([Lx_flange_base-Lx_drill_depth,-Ly_hole_interaxis/2,Lz_depth/2])
			base_cylinder( D_hole_diameter +Ld_drill_margin, 50 );


	} //end difference

}

if (x_show_servo == true)
{
	scs0009();
}

scs0009_lego();