//! @author Orso Eric https://github.com/OrsoEric

//2024-08-16
//I can do better, I can extrude rectangles from the circle
//This way I don't have to approximate the corners

module base_cylinder(id, ih, in_precision = 0.1)
{
    linear_extrude(ih)
    circle(d = id, $fs = in_precision, $fa = 2*in_precision);
}

module base_square( ix, iy, ih )
{
	translate([-ix/2,-iy/2])
	linear_extrude(ih)
	square([ix,iy]);
}

module suspended_hole( id_big, ih_big, id_small, ih_small, in_layer_height=0.2, in_precision = 0.1,  )
{
	h_wide_feature = in_layer_height;
	h_narrow_feature = in_layer_height;

	difference()
	{
		union()
		{
			//Build the positive of the big hole, thicker by two layers
			base_cylinder( id_big, ih_big+h_wide_feature+h_narrow_feature, in_precision );
			//Build the positive of the small hole, thinner by two layers, on top of the big hole
			translate([0,0,ih_big+h_wide_feature+h_narrow_feature])
			base_cylinder( id_small, ih_small-h_wide_feature-h_narrow_feature, in_precision );
		}
		union()
		{
			//WIDE FEATURE
			//The slicer will want to make a bridge resting on the side of the big hole

			//Now extrude two layers worth at both sides of the small cylinder
			translate([0,+id_small,ih_big])
			base_square(id_big,id_small, h_wide_feature +h_narrow_feature);
			translate([0,-id_small,ih_big])
			base_square(id_big,id_small, h_wide_feature +h_narrow_feature);

			//NARROW FEATURE
			//The slicer will want to make a bridge perpendicular to the wide bridge

			//Now extrude one layer worth on top of that to create a square
			translate([+id_small,0,ih_big+h_wide_feature])
			base_square(id_small,id_small, h_narrow_feature);
			translate([-id_small,0,ih_big+h_wide_feature])
			base_square(id_small,id_small, h_narrow_feature);

			//With both features, the small hole is supported on four points
		}
	}
}

//Round nut with support features
//suspended_hole( 30, 5, 10, 20 ); 
