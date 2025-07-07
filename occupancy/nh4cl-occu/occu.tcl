# 1. Remove extra atoms
cd ../post-processing-run3

echo "15" | gmx trjconv -f traj-fit-nodt.xtc -s traj-fit-nodt.pdb -o NH4.xtc

echo "16" | gmx trjconv -f traj-fit-nodt.xtc -s traj-fit-nodt.pdb -o CLA.xtc

cd ../post-processing-run4

echo "15" | gmx trjconv -f traj-fit-nodt.xtc -s traj-fit-nodt.pdb -o NH4.xtc

echo "16" | gmx trjconv -f traj-fit-nodt.xtc -s traj-fit-nodt.pdb -o CLA.xtc

# 2. Combine trajectories

gmx trjcat -f */NH4.xtc -o NH4.xtc -settime

gmx trjcat -f */CLA.xtc -o CLA.xtc -settime

# 3. Make new pdb file

vmd post-process-run1/traj-fit-nodt.pdb

mol new post-process-run1/traj-fit-nodt.pdb

set sel [atomselect top "resname NH4"]

$sel writepdb NH4.pdb

set sel [atomselect top "resname CLA"]

$sel writepdb CLA.pdb

# 4. Find occupancy

vmd NH4.pdb NH4.xtc

volmap occupancy [atomselect top "resname NH4"] -res 0.5 -allframes -combine avg -o occu-NH4.dx

vmd CLA.pdb CLA.xtc

volmap occupancy [atomselect top "name CLA"] -res 0.5 -allframes -combine avg -o occu-CLA.dx

# 1. Remove extra atoms

echo "15" | gmx trjconv -f traj-fit-nodt.xtc -s traj-fit-nodt.pdb -o SOD.xtc

echo "16" | gmx trjconv -f traj-fit-nodt.xtc -s traj-fit-nodt.pdb -o CLA.xtc

cd ../run2

echo "15" | gmx trjconv -f traj-fit-nodt.xtc -s traj-fit-nodt.pdb -o SOD.xtc

echo "16" | gmx trjconv -f traj-fit-nodt.xtc -s traj-fit-nodt.pdb -o CLA.xtc

cd ../run3

echo "15" | gmx trjconv -f traj-fit-nodt.xtc -s traj-fit-nodt.pdb -o SOD.xtc

echo "16" | gmx trjconv -f traj-fit-nodt.xtc -s traj-fit-nodt.pdb -o CLA.xtc

cd ../run4

echo "15" | gmx trjconv -f traj-fit-nodt.xtc -s traj-fit-nodt.pdb -o SOD.xtc

echo "16" | gmx trjconv -f traj-fit-nodt.xtc -s traj-fit-nodt.pdb -o CLA.xtc

# 2. Combine trajectories

gmx trjcat -f */SOD.xtc -o SOD.xtc -settime

gmx trjcat -f */CLA.xtc -o CLA.xtc -settime

# 3. Make new pdb file

vmd 

mol new run1/traj-fit-nodt.pdb

set sel [atomselect top "name SOD"]

$sel writepdb SOD.pdb

set sel [atomselect top "name CLA"]

$sel writepdb CLA.pdb

# 4. Find occupancy

mol new SOD.pdb

mol addfile SOD.xtc

volmap occupancy [atomselect top "name SOD"] -res 0.5 -allframes -combine avg -o occu-SOD.dx

mol new CLA.pdb

mol addfile CLA.xtc

volmap occupancy [atomselect top "name CLA"] -res 0.5 -allframes -combine avg -o occu-CLA.dx

