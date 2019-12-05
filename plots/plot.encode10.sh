#!/bin/bash

dir=`pwd`
outdir=$dir/encode10
mkdir -p $outdir
	
cd $outdir

for gtf in `echo "000 gtf"`
do

for aaa in `echo "scallop stringtie"`
do

for bbb in `echo "star hisat"`
do

for xxx in `echo "0 A"`
do

if [ "$gtf" == "gtf" ] && [ "$bbb" == "hisat" ]; then
	continue
fi

datafile=$dir/results.D131/encode10-$gtf-$aaa-$bbb-$xxx

# draw precision
id="$gtf-$aaa-$bbb-$xxx-precision"
texfile=$outdir/$id.tex

tmpfile=$dir/tmpfile.R
rm -rf $tmpfile

echo "source(\"$dir/R/barplot.adjusted.R\")" > $tmpfile
echo "plot.precision(\"$datafile\", \"$texfile\", \"$aaa\", \"Coral+$aaa\")" >> $tmpfile
R CMD BATCH $tmpfile
$dir/wrap.sh $id.tex
pdflatex $id.tex


# draw recall
id="$gtf-$aaa-$bbb-$xxx-correct"
texfile=$outdir/$id.tex

tmpfile=$dir/tmpfile.R
rm -rf $tmpfile

echo "source(\"$dir/R/barplot.adjusted.R\")" > $tmpfile
echo "plot.correct(\"$datafile\", \"$texfile\", \"$aaa\", \"Coral+$aaa\")" >> $tmpfile
R CMD BATCH $tmpfile
$dir/wrap.sh $id.tex
pdflatex $id.tex

rm -rf $tmpfile

done
done
done
done
