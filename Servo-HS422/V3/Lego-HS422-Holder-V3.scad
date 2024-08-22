//	2024-08-03
//Reduce holes from M4 to M3x16
//Add tollerance to LEGO holes of bottom plate
//LEGO round hole is slightly bigger by default, was too tight
//	2024-08-04
//Increase height of M3 nut
//IDEA: back hex slot for the M3 nut to support

//	V3
//	I want to separate the bottom plate so I can close the lid around the wire, without need for a channel, I can do through holes all the way down and use M3x40 screws to close the assembly
//	I want to center the axel with the LEGO lattice, this means elongating by one stud, and reworking the servo housing




//Show the model of the servo motor, to test fit the servo holder
include <HS422.scad>

//Lego beam library
include <customizable_straight_beam_v4o.scad>

x_show_servo = true;

//Realign the servo shaft to the LEGO latice
gx_shift_center_shaft = 1.5;


Lx_margin_servo_butt = 0.5;

//Number of stud fixtures
Nx_stud = 4;
Ny_stud = 8;
Nz_stud = 3;

//Size of a 5 stud lego beam
Ly_size = (Ny_stud-1)*cn_lego_pitch_stud +cn_lego_width_beam;
//Size of a two stack
Lz_size = Nz_stud*cn_lego_pitch_stud;

Ly_width_cover = 3*cn_lego_pitch_stud +(cn_lego_pitch_stud-cn_lego_width_beam)*2;

//the servo rests on Z=0 this margin extends below
Lz_margin = 0;

Lz_thickness_cover = 1.6;

Lz_adapter_depth = (Nz_stud) *cn_lego_pitch_stud;

//Game Margin added to the flange extrusion on Z axis
Lyz_game_flange = 0;

//Servo resting place
//Drill into the lateral beams
Lx_flange_drill = 10.0;

	//BOLTS
//Depth of the bolt used to attach the servo
//It can be deeper than the nut so you can use M3x10 to M3x16
Lx_drill_depth = 15.0;
//bolts used to attach the servo
Ld_drill = 3.0+0.5;
//M4 NUT SLOT
Lx_m4_height = 2.0+0.7;
Lz_m4_width = 5.3+0.5;
//How far is the nut from the flange
Lx_m4_depth = 7;
//Thickness of the wall facing the servo, supports the bridge
Ly_nut_wall_thickness = 0.4;



module HS422_lego( in_precision = 0.5 )
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
			translate([-Lx_margin_servo_butt, -3.6*cn_lego_pitch_stud,3*cn_lego_height_beam-Lz_thickness_cover/2-0.2])
			linear_extrude(Lz_thickness_cover)
			square( [Lx_base_to_flange, Ly_butt+cn_lego_pitch_stud/4] );


			//Butt LEGO plate
			translate([-Lx_margin_servo_butt-0.5*cn_lego_width_beam, 2*cn_lego_pitch_stud,0])
			rotate([90,0,-90])
			lego_plate_alternate
			(
				[
					"+++",
					"POP",
					"+P+",
					"OPO",
					"OPO",
					"+O+",
					"POP",
					"+++",
				],
				in_margin = 0.0
			);

			//Left LEGO plate
			translate([-1.0*Lx_margin_servo_butt-0.5*cn_lego_width_beam, 2.0*cn_lego_pitch_stud,-Lz_margin])
			rotate([90,0,0])
			lego_plate_alternate
			([
				"+++",
				"P P",
				"+ +",
				"   ",
				"   ",
			]);

			//RIGHT LEGO plate
			translate([-1.0*Lx_margin_servo_butt-0.5*cn_lego_width_beam, -(Ny_stud-3)*cn_lego_pitch_stud,-Lz_margin])
			rotate([90,0,0])
			lego_plate_alternate
			([
				"+++",
				"POP",
				"+O+",
				"   ",
				"   ",
			]);

			
		} //End addition

		union()
		{
			/*
			//Extrude flange socket
			translate([Lx_margin_servo_butt+Lx_case,-Ly_flange+18,0.5*Nz_stud*cn_lego_height_beam-0.51*Lz_depth])
			rotate([0,-90,0])
			linear_extrude(Lx_flange_drill)
			square( [Lz_depth+1, Ly_flange+2] );
			*/
			/*
			//Wire passage
			translate([Lx_flange_base,16,7+5])
			rotate([0,90,180])
			linear_extrude(20)
			square( [5,cn_lego_width_beam], center=true );
			*/
			//Drill wire hole
			translate([6,12.3,3*0.5*cn_lego_height_beam])
			rotate([90,0,180])
			linear_extrude(50)
			circle( d=Lz_width_cable*1.1,$fa = 0.1+in_precision, $fs = 0.1+in_precision/2 );
			
			//Drill the M4 holes to attach the servo
			translate
			([
				Lx_flange_base+gx_shift_center_shaft,
				16-gx_shift_center_shaft,
				7
			])
			rotate([0,90,180])
			linear_extrude(Lx_drill_depth)
			circle( d=Ld_drill,$fa = 0.1+in_precision, $fs = 0.1+in_precision/2 );
			//Drill M4 hole
			translate
			([
				Lx_flange_base,
				16-gx_shift_center_shaft,
				7+Lz_hole_interaxis
			])
			rotate([0,90,180])
			linear_extrude(Lx_drill_depth)
			circle( d=Ld_drill,$fa = 0.1+in_precision, $fs = 0.1+in_precision/2 );
			//Drill M4 hole
			translate
			([
				Lx_flange_base,
				16-Ly_hole_interaxis-gx_shift_center_shaft,
				7
			])
			rotate([0,90,180])
			linear_extrude(Lx_drill_depth)
			circle( d=Ld_drill,$fa = 0.1+in_precision, $fs = 0.1+in_precision/2 );
			//Drill M4 hole
			translate
			([
				Lx_flange_base,
				16-Ly_hole_interaxis-gx_shift_center_shaft,
				7+Lz_hole_interaxis
			])
			rotate([0,90,180])
			linear_extrude(Lx_drill_depth)
			circle( d=Ld_drill,$fa = 0.1+in_precision, $fs = 0.1+in_precision/2 );

		} //End sutraction

	} //end difference

}

if (x_show_servo == true)
{
	rotate([0,-90,0])
	HS422();
}
translate([0,gx_shift_center_shaft,0])
rotate([0,-90,0])
HS422_lego();