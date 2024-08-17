//LEGO CORE PARAMETERS

	//X


	//Y
Ly_lego_width_beam = 7.5;

	//Z
Lz_lego_height_beam = 7.4;

	//DRILL
//Lego hole pitch
D_lego_pitch_stud = 8.0;
//Internal hole
D_lego_drill_small = 5.0/2.0;
//Approach hole
D_lego_drill_large = 6.1/2.0;

//size of the axel + shaped drill
D_lego_drill_axel = 2.0;

//D_lego_margin = 0.05;


module body_plate( in_length_stud, in_width_stud )
{
    hull()
	{
        cylinder(r=Ly_lego_width_beam/2, h=Lz_lego_height_beam*in_width_stud,$fn=100);
        
        translate([(in_length_stud-1)*D_lego_pitch_stud, 0, 0]) 
            cylinder(r=Ly_lego_width_beam/2, h=Lz_lego_height_beam*in_width_stud,$fn=100);
    }
}

module prvt_drill_plus()
{
    union()
	{
        translate([-D_lego_drill_axel/2, -D_lego_drill_small, 0]) 
            cube([D_lego_drill_axel, D_lego_drill_small*2, Lz_lego_height_beam]);
        translate([-D_lego_drill_small, -D_lego_drill_axel/2, 0]) 
            cube([D_lego_drill_small*2, D_lego_drill_axel, Lz_lego_height_beam]);
    }
}


module lego_beam( is_pattern )
{
	n_length = len(is_pattern);
	
	translate([0, 0, 0]) 
	difference()
	{
		body_plate(n_length,1);
		for (cnt = [0:n_length-1])
        {
			if (is_pattern[cnt] == "+")
			{
                translate([Ly_lego_width_beam , cnt *D_lego_pitch_stud, 0])
                    prvt_drill_plus();
			}
			else
			{
				//No hole
			}
		}


	}


}



module lego_plate( is_pattern, in_width )
{
	n_length = len(is_pattern);
	body_plate(n_length,in_width);
}

//translate([0,0,+30])
lego_beam("++++");

//translate([0,0,-30])
//lego_plate("oooo", 4);


