//Lego beam library
include <customizable_straight_beam_v4o.scad>

//Servo spline library, creates the tooth crown to subtract to the servo arm
include <servo-arm-library.scad>

module servo_trapezoid_lego( id_arm_shaft, in_holes)
{
	h_arm = cn_lego_height_beam;

	l_arm = cn_lego_pitch_stud *in_holes;

	d_arm_end = cn_lego_pitch_stud +2.0;

	if (in_holes > 0)
	difference()
	{
		union()
		{
			//Trapezoid building the arm
			linear_extrude(h_arm)
			polygon
			([
				[0,+id_arm_shaft/2],
				[l_arm,+d_arm_end/2],
				[l_arm,-d_arm_end/2],
				[0,-id_arm_shaft/2],
			]);
			//Circle around the end point
			translate([l_arm,0,0])
			linear_extrude(h_arm)
			circle(d=d_arm_end, $fa=0.2, $fs=0.1);
		}
		union()
		{
			
		}
	}	
}

module servo_lego_arm_parametric( is_spline="C24T", in_holes_right = 1, in_holes_left = 1, ig_shaft_beam , ih_layer =0.2 )
{

	id_arm_shaft = 12;
	ih_arm = cn_lego_height_beam;

	difference()
	{
		union()
		{
			//Circle around the shaft
			linear_extrude(ih_arm+ig_shaft_beam)
			circle(d=id_arm_shaft, $fa=0.2, $fs=0.1);

			translate([0,0,ig_shaft_beam])
			servo_trapezoid_lego( id_arm_shaft, in_holes_right );

			translate([0,0,ig_shaft_beam])
			rotate([0,0,180])
			servo_trapezoid_lego( id_arm_shaft, in_holes_left );

		
		}
		union()
		{
			//Extrude the servo spline, including the servo drill of a desired height
			servo_head("C24T", ih_arm+ig_shaft_beam, ih_layer );
			//Extrude LEGO holes
			if (in_holes_right > 0)
			{ 
				for (i = [1 : in_holes_right])
				{
					//LEGO hole
					translate([(i)*cn_lego_pitch_stud,0,ig_shaft_beam])
					hole();
				}
			}
			//Extrude LEGO holes
			if (in_holes_left > 0)
			{ 
				for (i = [1 : in_holes_left])
				{
					//LEGO hole
					translate([(-i)*cn_lego_pitch_stud,0,ig_shaft_beam])
					hole();
				}
			}
		}
	}
}

rotate([-180, 0,180])
servo_lego_arm_parametric("C24T", 1, 2, 2.5, 0.08 );