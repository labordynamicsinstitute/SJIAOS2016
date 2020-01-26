#/bin/bash
if [[ -z $2 ]]
then
cat << EOF

  $0 var position

EOF
exit 2
fi
var=$1
position=$2

basename=r_e_agesz_all
basesuffix=2_post
suffixes="syn pub alg1n0 alg1n5 alg2 alg2w0 alg2n0 nois25"
set -- $suffixes
nsuffixes=$#
i=1

outfile=${basename}_${var}.csv
[[ -f extra ]] && rm -f extra

for suffix in $suffixes
do
  infile=${basename}_${suffix}${basesuffix}.csv
  tmpfile=tmp_$suffix
#  if [[ $i == 1 ]]
#  then
     awk -F, "  { print \$3 \",\" \$${position} }" $infile | sed "s/${var}.*/${var}$i/; s/ //g" > $tmpfile
     dos2unix $tmpfile
     # for the missingness print the confidential number
     [[ $var == missing && $suffix == pub ]] &&  awk -F, "  { print \$3 \",\" \$4 }" $infile | sed "s/ //g" > extra
     # for the significance, also print the data from the
     [[ $var == significant && $suffix == pub ]] && awk -F, "  { print \$3 \",\" \$$(( position - 1 )) }" $infile | sed "s/ //g" > extra
     [[ -f extra ]] && join -t , extra $tmpfile > tmp && mv tmp $tmpfile && rm extra
  [[ $i == 1 ]] && cat $tmpfile > $outfile || join -t , $outfile $tmpfile > tmp
  mv tmp $outfile
  let i++
done
rm tmp*
