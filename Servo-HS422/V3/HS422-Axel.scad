//Lego beam library
include <customizable_straight_beam_v4o.scad>


module hs422_axel()
{
	difference()
	{
		//Create the adapter
		lego_beam(["o", "+", " ", " ", "+", "o"]);
		//Manuallly place an hole at the right offset distance
		translate
		([
			cn_lego_pitch_stud+10.5,
			cn_lego_height_beam/2,
			//Fix the asymnmetry of the vertical holes
			-(cn_lego_height_beam-cn_lego_width_beam)/2
		])
		hole();
	}

}

hs422_axel();