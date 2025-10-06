#!/bin/bash

# Import data into GRASS
# for LOCATION = Brooke1; import LANDISII raster data that has already undergone RasterConversionCESM1.sh

cd  $HOME/Desktop/CESMRep1
FILES=`ls -a *.img`
for f in $FILES
do
    in=`echo $f`
    out=`echo $in | sed -e 's/.img//g'`
    r.in.gdal input=$in output=$out memory=2047
    rm $in $out
done

# leave with exit status 0 which means "ok":
exit 0