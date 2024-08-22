//Show the model of the servo motor, to test fit the servo holder
include <HS422.scad>

//Lego beam library
include <customizable_straight_beam_v4o.scad>

x_show_servo = false;
//Realign the servo shaft to the LEGO latice
gx_shift_center_shaft = 10;

//Number of stud fixtures
Nx_stud = 7;
Ny_stud = 4;
Nz_stud = 3;

Lx_margin_servo_butt = 0.5;

module square_center( l, w, h )
{
	linear_extrude(h)
	translate([-l/2,-w/2,0])
	square([l, w]);
}


module HS422_lego_holder()
{
	difference()
	{
		union()
		{
			//Butt LEGO plate
			translate
			([
				-1.5*cn_lego_pitch_stud,
				2*cn_lego_pitch_stud,
				-Lx_margin_servo_butt-0.5*cn_lego_width_beam,
			])
			rotate([0,0,-90])
			lego_plate_alternate
			(
				[
					"  o",
					"oOo",
					"OOO",
					"oOo",
					"OOO",
					"oOo",
					"O  ",
					"o o",
				],
				in_margin = 0.0
			);
			//Hole LEGO plate
			translate
			([
				-1.5*cn_lego_pitch_stud,
				2*cn_lego_pitch_stud,
				-Lx_margin_servo_butt-0.5*cn_lego_width_beam,
			])
			rotate([-90,-90,0])
			lego_plate_alternate
			([
				"o o",
				"   ",
				"   ",
				"   ",
				"   ",
			]);

			//Opposite LEGO plate
			translate
			([
				-1.5*cn_lego_pitch_stud,
				-5*cn_lego_pitch_stud,
				-Lx_margin_servo_butt-0.5*cn_lego_width_beam,
			])
			rotate([-90,-90,0])
			lego_plate_alternate
			([
				"o o",
				"OOO",
				"oOo",
				"OOO",
				"o o",
			]);

			//Fill space
			translate
			([
				0,
				-cn_lego_pitch_stud*1.5,
				-Lx_margin_servo_butt
			])
			square_center
			(
				cn_lego_pitch_stud*3,
				cn_lego_pitch_stud*6+0.7,
				30
			);
		}
		union()
		{
			//Extrude space for the servo flange
			hs422_seat_vertical(ih_screw=31);

		}
	}


}

if (x_show_servo == true)
{
	HS422_vertical();
}

HS422_lego_holder();
