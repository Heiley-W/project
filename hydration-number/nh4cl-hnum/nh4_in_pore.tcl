
proc mycoordnum {frame} {
    global out out2  all pro popc  squareR cutoff_O cutoff_H
    
    ## center system such that bilayer center is at z=0
    set popc_cen [measure center $popc]
    set popc_z [lindex $popc_cen 2]
    $all moveby [list 0 0 -$popc_z]
    puts -nonewline "frame $frame: popc centered at [lindex [measure center $popc] 2] "

    set pro_cen [measure center $pro]
    set pro_cen_x [lindex $pro_cen 0]
    set pro_cen_y [lindex $pro_cen 1]

    set ion_index [[atomselect top "name NZ and (x-$pro_cen_x)*(x-$pro_cen_x)+(y-$pro_cen_y)*(y-$pro_cen_y) < $squareR and z > -40 and z < 48"] get index]; # all ions in channel
    puts -nonewline "\t [llength $ion_index] ions in channel. "


    foreach ionID $ion_index {
	      set ion [atomselect top "index $ionID"]
         set ion_cen [measure center $ion]

         set wto [atomselect top "water and name OH2 and within $cutoff_O of index $ionID"];
         set wth [atomselect top "water and name H1 H2 and within $cutoff_H of index $ionID"] ; # comment out if treating sodium

         set proh_1inN [atomselect top "protein and resid 1 and name HT1 HT2 HT3 and within $cutoff_H of index $ionID"] ;

         set proh_m17 [atomselect top "protein and resid 17 and name HG21 HG22 HG23 and within $cutoff_H of index $ionID"] ;
         set proh_h17 [atomselect top "protein and resid 17 and name HG1 and within $cutoff_H of index $ionID"] ;
         set proh_m21 [atomselect top "protein and resid 21 and name HG11 HG12 HG13 HG21 HG22 HG23 and within $cutoff_H of index $ionID"] ;
         set proh_h25 [atomselect top "protein and resid 25 and name HG1 and within $cutoff_H of index $ionID"] ;

         set proh_k33 [atomselect top "protein and resid 33 and name HZ1 HZ2 HZ3 and within $cutoff_H of index $ionID"] ;
         set proh_k40 [atomselect top "protein and resid 40 and name HZ1 HZ2 HZ3 and within $cutoff_H of index $ionID"] ;

         set proh_k44 [atomselect top "protein and resid 44 and name HZ1 HZ2 HZ3 and within $cutoff_H of index $ionID"] ;

         set proall [atomselect top "protein and hydrogen and within $cutoff_H of index $ionID" ]
         ### can chenck proall - proh_m17 - ... = proh_other

         set proh_other [atomselect top "protein and hydrogen and not (protein and resid 17 and name HG21 HG22 HG23) and not (protein and resid 17 and name HG1) and not (protein and resid 21 and name HG11 HG12 HG13 HG21 HG22 HG23) and not (protein and resid 25 and name HG1) and not (protein and resid 33 and name HZ1 HZ2 HZ3) and not (protein and resid 40 and name HZ1 HZ2 HZ3) and not (protein and resid 44 and name HZ1 HZ2 HZ3) and within $cutoff_H of index $ionID"] ;
         ## only without 17. 21, 25 and charged residues

         puts $out2 "$frame, $ionID, [$proh_m17 get resid] [$proh_m17 get serial], [$proh_h17 get resid] [$proh_h17 get serial], [$proh_m21 get resid] [$proh_m21 get serial] , [$proh_h25 get resid] [$proh_h25 get serial], [$proh_other get resid] [$proh_other get serial], [$proh_other get resid] [$proh_other get name]"

         puts $out "$frame [$ion num] [$ion get z] [$wto num] [$wth num] [$proh_m17 num] [$proh_h17 num] [$proh_m21 num] [$proh_h25 num] [$proh_k33 num] [$proh_k40 num] [$proh_k44 num] [$proall num] [$proh_other num] [$proh_1inN num]"
    }
    puts "Done."
}

source ./bigdcd.tcl

mol load pdb ../traj-fit-nodt.pdb

set out [open nh4-in-pore.dat w]
set out2 [open nh4-in-pore-protein.dat w]
set all [atomselect top all]

set cutoff_O 3.85; # to be replaced by g(r) min location
set cutoff_H 2.92; # to be replaced by g(r) min location
set pro [atomselect top "protein"]
set popc [atomselect top "name P"]

set squareR 225; # radius 15A, 15*15 = 225 --- please note that if you increase halfL this may also need to be slightly increased --- check in VMD visualization

bigdcd mycoordnum ../traj-fit-nodt.xtc
bigdcd_wait ; # important

close $out;
exit; # comment this out in debugging

