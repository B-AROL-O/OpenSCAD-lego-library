
//Box with the origin at the center of its base for easy stacking
module base_box( in_lx, in_ly, in_lz )
{
	translate([0, -in_ly/2, 0])
	{
        cube([in_lx, in_ly, in_lz], center=false);
    }
}

//Cylinder with the base on the YZ axis, and height on the X axis
//center at the center of the round base for easy stacking
module base_cylinder( in_r, in_z)
{
	translate([0, -0, 0])
	rotate([0,90,0])
	cylinder( in_z, in_r/2, in_r/2, false, $fn = 100 );
}