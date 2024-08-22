// Include the OpenSCAD Threads Library
include <threads.scad>

//Define LEGO beams
include <customizable_straight_beam_v4o.scad>

//6.35mm outer diameter 5.35mm core hole diameter
// Parameters for the 1/4-20 UNC thread
nd_quarter_unc_thread = 6.25; // 1/4 inch in mm
np_quarter_unc_thread = 1.27; // 20 TPI in mm
nl_bolt = 15; // Length of the threaded part in mm

//Hollow out the cylinder so I don't fill other geometries
module thread_inner( id_outer, ip_thread, iz_thread, in_start=1 )
{
	difference()
	{
		metric_thread(diameter=id_outer, pitch=ip_thread, length=iz_thread, internal=false,n_starts=in_start);
        //Extrude an hole inside the thread
		//cylinder(iz_thread, d=id_outer-4, center=false,$fs=0.1,$fa=0.1);
	}
}

module lego_camera_support()
{
    union()
    {
        translate([-2*cn_lego_pitch_stud,+0.5*cn_lego_width_beam,0])
        rotate([90,0,0])
        lego_beam("ooPoo");
        
        translate([0,0,+1*cn_lego_height_beam])
        thread_inner( nd_quarter_unc_thread, np_quarter_unc_thread, nl_bolt );
        
    }
}

lego_camera_support();





