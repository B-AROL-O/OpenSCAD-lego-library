/*
	Servo Spline Parameters
	First array (head related)
    0. Head external diameter  (INTERNAL OF TEETH)
	1. Head height
    2. Head screw head diameter
    3. Head screw shaft diameter

    Second array (tooth related)
    0. Tooth count
    1. Tooth height
    2. Tooth length
    3. Tooth width
*/

//This allows to print small holes on top of big holes using two features
include <suspended_hole.scad>

//Core parameters of various servo splines

//C24T
//Servo compatible with this spline:
//HS311, HS422
caan_hitec_c24t =
[
	[5.6, 3.5, 8.0, 2.8],
	[24, 0.4, 0.7, 0.051]
];

//H25T
//Compatible Servos:
//Turnigy
caan_hitec_h25t =
[
	[5.92, 3.7, 8.0, 2.8],
	[25, 0.3, 0.7, 0.1]
];


module servo_head_tooth(l_tooth, w_tooth, h_tooth, h_head)
{
	//Increase the inner diameter
	d_inner = 0.05;
	//Create an individual tooth
	linear_extrude(height = h_head)	
	polygon
	([
		[-l_tooth / 2 - d_inner, -d_inner],
		[-w_tooth / 2, h_tooth],
		[w_tooth / 2, h_tooth],
		[l_tooth / 2 + d_inner, -d_inner]
	]);
}

//Create the positive of the tooth, will be subtracted from your piece
module servo_head_parametric(iaan_param, ih_drill, ig_head = 0.2)
{
	//Extract head parameters
	an_head = iaan_param[0];
	d_head = an_head[0];
	//Height of the crown
	h_head = an_head[1];
	d_drill_head = an_head[2];
	d_drill = an_head[3];
	//Extract tooth parameter
	an_tooth = iaan_param[1];
	n_tooth_count = an_tooth[0];
	h_tooth = an_tooth[1];
	l_tooth = an_tooth[2];
	w_tooth = an_tooth[3];

	//Fill center hole
	linear_extrude( h_head )
	circle( d=d_head -2*ig_head, $fa=0.2, $fs=0.1 );
	//Create the teeth
	for (i = [0 : n_tooth_count])
	{
		rotate([0, 0, i * (360 / n_tooth_count)])
		translate([0, d_head / 2 - h_tooth + ig_head, 0])	
		servo_head_tooth(l_tooth, w_tooth, h_tooth, h_head);	
	}

	h_drill_head = 1.5;

	//Create a pillar, that is the positive of the screw drill hole
	if (ih_drill > h_head+h_drill_head)
	{
		/*
		translate([0,0,h_head])
		linear_extrude( ih_drill-h_head-h_drill_head )
		circle( d=d_drill, $fa=0.2, $fs=0.1 );
		//Create an indent where the screw head can rest
		translate([0,0,ih_drill-h_drill_head*2])
		linear_extrude( h_drill_head )
		circle( d=d_drill_head, $fa=0.2, $fs=0.1 );
		*/
		translate([0,0,ih_drill])
		rotate([0,180,0])
		suspended_hole( d_drill_head, h_drill_head, d_drill, ih_drill-h_drill_head-h_head );
	}
	

}

module servo_head(is_spline, ih_drill, ig_head = 0.2)
{
	if (is_spline == "C24T")
    {
        servo_head_parametric(caan_hitec_c24t, ih_drill, ig_head = ig_head);
    }
	else if (is_spline == "H25T")
    {
        servo_head_parametric(caan_hitec_h25t, ih_drill, ig_head = ig_head);
    }
    else
    {
        echo("Spline type not recognized");
    }
}

//servo_head( "C24T", 10 );
//servo_head( "H25T", 10 );