#!/bin/bash
echo "by suzu!"
for i in {1..1013}; do
  shuf -i 1-40 -n4 >> all_numbers.txt
done
sort all_numbers.txt | uniq -c | awk '{print $2, $1}' | sort -k2,2nr > frequency_sorted.txt
gnuplot <<EOF
set terminal pngcairo size 1600,900 enhanced font 'Arial,10'
set output 'sorted_frequency_plot.png'
set title 'Top 1-40'
set xlabel 'Number'
set ylabel 'Frequency'
set style data histograms
set style fill solid
set boxwidth 0.8
set xtics rotate by -30
set xrange [-0.5:*]
set key top right
plot 'frequency_sorted.txt' using 0:2:( \$0 < 4 ? 0x6aadff : 0xfaadff ):xtic(1) \
     with boxes lc rgb variable title '', \
     '' using (0):(0):(0) with boxes lc rgb 0x6aadff title 'Top 4', \
     '' using (0):(0):(0) with boxes lc rgb 0xfaadff title 'Others'
EOF
echo "OK!"