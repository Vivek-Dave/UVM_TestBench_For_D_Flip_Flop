
vsim +access+r;
run -all;
acdb save;
acdb report -db fcover.acdb -html -o coverage_data.html;
exit

