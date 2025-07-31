# 1. Post-processing
gmx make_ndx -f ../step5_input.pdb -o index.ndx << EOF
3 & r 14
splitch 18
r 1-32
3 & 25
splitch 26
q
EOF

echo "C-alpha_&_r_14_chain1" "System" | gmx trjconv -f ../step7_1.xtc -o center.xtc -center -pbc mol -s ../step6.0_minimization.tpr -n index.ndx -tu ns -dt 0.05

echo "C-alpha_&_r_1-32" "System" |  gmx trjconv -f center.xtc  -o traj-fit-nodt.xtc -s ../step6.0_minimization.tpr -fit rot+trans -tu ns -dt 0.05 -n index.ndx

echo "C-alpha_&_r_1-32" "System" |  gmx trjconv -f ../step7_1.xtc  -o traj-fit-nodt.pdb -s ../step6.0_minimization.tpr -fit rot+trans -dump 0 -n index.ndx

# 2. Get current 
cd current
vmd -dispdev text -e get-currCLA.tcl > get-currCLA.log
vmd -dispdev text -e get-currSOD.tcl > get-currSOD.log

# 3. Get hydration number
# Updated cutoff 
cd ../hnum
vmd -dispdev text -e nh4_in_pore.tcl > nh4_in_pore.log
vmd -dispdev text -e cl_in_pore.tcl > cl_in_pore.log

# 4. RMS
cd ../rmsd
echo C-alpha | gmx rms -f ../traj-fit-nodt.xtc -s ../../step6.0_minimization.tpr -o rmsd-fit.xvg -fit no -tu ns

echo C-alpha | gmx rmsf -f ../traj-fit-nodt.xtc -o rmsf.xvg -s ../../step6.0_minimization.tpr -fit no -res

echo C-alpha | gmx gyrate -f ../traj-fit-nodt.xtc -s ../../step7_1.tpr -o gyrate.xvg

