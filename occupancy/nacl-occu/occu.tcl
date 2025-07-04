volmap occupancy [atomselect top "name SOD"] -res 0.5 -allframes -combine avg -o occu-SOD.dx

volmap occupancy [atomselect top "name CLA"] -res 0.5 -allframes -combine avg -o occu-CLA.dx

volmap occupancy [atomselect top "protein and resid 17"] -res 0.5 -allframes -combine avg -o occu17.dx

volmap occupancy [atomselect top "protein and resid 21"] -res 0.5 -allframes -combine avg -o occu21.dx

exit
