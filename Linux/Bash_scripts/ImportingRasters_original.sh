#!/bin/bash

# https://pvanb.wordpress.com/2015/03/18/importing-data-in-grass-gis-an-example/
# First step is to open a terminal and go to the directory where you keep the downloaded data. 
#The shell script below will take the compressed layers one by one, (i) decompress them, 
#(ii) cut out the region of interest, (iii) import that in the GRASS GIS database and 
#(iv) delete the temporary tif files.

# AFsoil gzip -d af_ALUM3S_T__M_xd1_250m.tif.gz
# gdalinfo af_ALUM3S_T__M_xd1_250m.tif


cd  /media/HD2/Data/AFsoil/
FILES=`ls -a *.gz`
for f in $FILES
do
    in=`echo $f | sed -e 's/.gz//g'`
    out1=`echo $in | sed -e 's/__/_/g'`
    out2=`echo $out1 | sed -e 's/.tif//g'`
    gzip -d $f
    gdal_translate -projwin  216000 1134000  3055500 -2537000 $in $out1
    r.in.gdal input=$out1 output=$out2 memory=2047
    rm $in $out1
done