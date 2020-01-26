#/bin/bash
if [[ -z $1 ]]
then
cat << EOF

  $0 start

EOF
exit
fi

./collate_results.sh Jk 6
./collate_results.sh coverage 5
./collate_results.sh missing 9
./collate_results.sh significant 8
