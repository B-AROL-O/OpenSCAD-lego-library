/*      
        Even More Customizable Straight LEGO Technic Beam
        Based on Customizable Straight LEGO Technic Beam
         and Parametric LEGO Technic Beam by "projunk" and "stevemedwin"
        
        www.thingiverse.com/thing:203935
        
        Also uploaded to Prusaprinters.org at https://www.prusaprinters.org/prints/33038-even-more-customizable-straight-beam-for-legotm-te
        
        Modified by Sam Kass
        November 2015

		Modified by Orso Eric (2024-03)	
		https://github.com/OrsoEric/OpenSCAD-lego-library

		2024-08-03
		added user margin, the plates printed horizontally could need more margin than plates printed vertically
		increased base tollerance of round hole
		fine tune indent and hole size
*/



// user parameters

//Hole sequence
//o for round hole
//+ for plus-shaped hole
//capital O for sideways hole
//capital P for sideways plus
//and x for blank spot.
//eg. lego_beam("+xPOo");

cn_lego_pitch_stud = 8.0;
cn_lego_drill_small = 4.7+0.4;
cn_lego_drill_large = 5.9+0.5;
cn_lego_height_beam = 7.8;

cn_lego_width_beam = 7.3; 
cn_lego_drill_axel = 2.0+0.05;

//How deep the shriking of the big hole
cn_lego_drill_depth_indent = 0.5;
//How steep the transition from big hole to small hole
cn_lego_drill_sharpness = 0.5;

module body( in_length_stud, in_height = cn_lego_height_beam, in_precision = 0.5 )
{
    translate([0, cn_lego_width_beam/2, 0]) 
    hull()
	{
        cylinder(r=cn_lego_width_beam/2, h=in_height,$fa = 0.1+in_precision, $fs = 0.1+in_precision/2);    
        translate([(in_length_stud-1)*cn_lego_pitch_stud, 0, 0]) 
            cylinder(r=cn_lego_width_beam/2, h=in_height,$fa = 0.1+in_precision, $fs = 0.1+in_precision/2);
    }
}

module hole( in_height = cn_lego_height_beam, in_precision = 0.5, in_margin = 0.0 )
{
	an_cross_section = [
		//Bottom
		[0,0],
		//Top
		[0,in_height],
		//Top Big hole
		[(cn_lego_drill_large+in_margin)/2,in_height],
		[(cn_lego_drill_large+in_margin)/2,in_height-cn_lego_drill_depth_indent],
		//Top Small Hole
		[(cn_lego_drill_small+in_margin)/2,in_height-cn_lego_drill_depth_indent-cn_lego_drill_sharpness],
		//Bottom Small hole
		[(cn_lego_drill_small+in_margin)/2,cn_lego_drill_depth_indent+cn_lego_drill_sharpness],
		//Bottom Big Hole
		[(cn_lego_drill_large+in_margin)/2,cn_lego_drill_depth_indent],
		[(cn_lego_drill_large+in_margin)/2,0]
	];
	//Rotate the cross section of the hole around its axis, to generate the hole
	rotate_extrude($fa = 0.1+in_precision, $fs = 0.1+in_precision/2)
	polygon(an_cross_section);
}

module plus( in_height = cn_lego_height_beam, in_margin = 0.0 )
{
    union()
	{
        translate([-(cn_lego_drill_axel+in_margin)/2, -(cn_lego_drill_small+in_margin)/2, 0]) 
            cube([cn_lego_drill_axel+in_margin, cn_lego_drill_small+in_margin, in_height]);

        translate([-(cn_lego_drill_small+in_margin)/2, -(cn_lego_drill_axel+in_margin)/2, 0]) 
            cube([cn_lego_drill_small+in_margin, cn_lego_drill_axel+in_margin, in_height]);
    }
}

module lego_beam( is_holes, in_height = cn_lego_height_beam, in_margin = 0.0  )
{
	//number of studs
	in_length = len(is_holes);

	if (in_length > 0)
	{
		//Center the beam
		translate([0,cn_lego_pitch_stud,0])
		rotate([90,0,0])
		difference()
		{
			body( in_length, in_height );
			for (i = [1:in_length])
			{
				if (is_holes[i-1] == "+")
					translate([(i-1)*cn_lego_pitch_stud, cn_lego_width_beam/2, 0])
						plus( in_height, in_margin=in_margin );
				else if (is_holes[i-1] == "o")
					translate([(i-1)*cn_lego_pitch_stud, cn_lego_width_beam/2, 0])
						hole( in_height, in_margin=in_margin );
				else if (is_holes[i-1] == "O")
					rotate([90,0,0])
					translate([(i-1)*cn_lego_pitch_stud, cn_lego_height_beam/2,-cn_lego_pitch_stud+cn_lego_drill_depth_indent/2])
						hole( in_height, in_margin=in_margin );
				else if (is_holes[i-1] == "P")
					rotate([90,0,0])
					translate([(i-1)*cn_lego_pitch_stud, cn_lego_height_beam/2,-cn_lego_pitch_stud+cn_lego_drill_depth_indent/2])
						plus( in_height, in_margin=in_margin );
				else 
				{
					//no drill, leave a blank space
				}
			}
		}
	}
}

//Get an array of string, each will become a beam
//E.g. lego_plate(["o+Po", "oPOo", "oP+o"]);
// o+Po
// oPOo
// oP+o
module lego_plate( ias_pattern )
{
	//number of beams side to side
	in_width_stud = len(ias_pattern);

    for (cnt = [0:in_width_stud-1])
    {
        translate([0,cn_lego_pitch_stud*cnt,-0.5*cn_lego_width_beam])
            lego_beam(ias_pattern[cnt], cn_lego_pitch_stud);
    }
}

//Same as lego_plate, but slices along width, not length
//It's easier to make patterns on plates this way
//E.g. lego_plate(["ooo", "+PP", "PO+","ooo"]);
module lego_plate_alternate( ias_pattern, in_margin = 0.0 )
{
    // number of beams side to side
    in_width_stud = len(ias_pattern[0]); // assuming all strings are of the same length
	in_length_stud = len(ias_pattern);
	echo("Length: ",in_length_stud, "cn_lego_width_beam: ", in_width_stud);
    for (cnt = [0:in_width_stud-1])
    {
        ac_array = [for(i = [0:in_length_stud-1]) ias_pattern[i][cnt]];
		echo( "Beam:", cnt, "Pattern:", ac_array );
        translate([0,cn_lego_pitch_stud*cnt,-0.5*cn_lego_width_beam])
            lego_beam(ac_array, cn_lego_pitch_stud, in_margin=in_margin );
    }
}

//lego_plate_alternate(["ooo", "+++", "POP", "ooo"]);
