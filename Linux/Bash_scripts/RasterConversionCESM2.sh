#!/bin/bash
for FILE in /home/bmarron/Downloads/Climate_Change_Runs/CESM1_noharv/replicate2/output/biomass/*
do
  echo "Processing $FILE file..."
  gdal_translate -a_srs $HOME/Desktop/WKT.txt -a_ullr 610998.725 1169715.252 755998.725 1049715.252 -of HFA $FILE $FILE.grass
done


mv $HOME/Downloads/Climate_Change_Runs/CESM1_noharv/replicate2/output/biomass/*.grass $HOME/Desktop/CESMRep2/


for f in $HOME/Desktop/CESMRep2/*
do
  echo "Processing $f file..." 
  mv "$f" "${f%.grass}"
done


mv $HOME/Downloads/Climate_Change_Runs/CESM1_noharv/replicate2/output/biomass/*.xml $HOME/Desktop/CESMRep2/


for f in $HOME/Desktop/CESMRep2/*.xml 
do
  echo "Processing $f file..."
  mv "$f" "${f/.grass}"
done