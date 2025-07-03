gmx rdf -f ../step5_1.xtc -s ../step4.0_minimization.tpr -ref 'name CLA' -sel 'name OH2' -rmax 1 -o rdf_cl-o.xvg -cn rdf_cl-o_cn.xvg

gmx rdf -f ../step5_1.xtc -s ../step4.0_minimization.tpr -ref 'name SOD' -sel 'name OH2' -rmax 1 -o rdf_na-o.xvg -cn rdf_na-o_cn.xvg

gmx rdf -f ../step5_1.xtc -s ../step4.0_minimization.tpr -ref 'name CLA' -sel 'name H1 H2' -rmax 1 -o rdf_cl-h.xvg -cn rdf_cl-h_cn.xvg

gmx rdf -f ../step5_1.xtc -s ../step4.0_minimization.tpr -ref 'name SOD' -sel 'name H1 H2' -rmax 1 -o rdf_na-h.xvg -cn rdf_na-h_cn.xvg

#grep -vE '^(#|@)' rdf.xvg | awk 'BEGIN{max=-99999999} {if($2>max){max=$2; col1=$1}} END{print col1}'

