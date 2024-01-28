#!/bin/bash

min=-48
max=48
objects=200

rm -rf out.txt
touch out.txt

for i in {1..200}
do
    x=$(($RANDOM%($max-$min+1)+$min))
    y=$(($RANDOM%($max-$min+1)+$min))
    template="[node name=\"Tree$i\" parent=\"SubViewport/Level/Geometry/Trees\" instance=ExtResource(\"5_ky1k1\")]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, $x, 0, $y)" 
    echo $template >> out.txt
    echo "" >> out.txt
done


