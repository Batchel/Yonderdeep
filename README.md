# Yonderdeep
This is code that I wrote to analyze aspects of our AUV, such as center of mass, Buoyancy, Sink rate, etc.

## Buoyancy
I coded this to aggregate all of the part volumes from our AUV in order to discern our total Buoyancy. These parts were changing all of the time so
the code is linked to an excel file that contains all necessary values.

It is imperative that our AUV's buoyancy fell within a range so as not to sink (negative buoyancy), but still be able to ascend and descend in water without trouble.

## Center of Mass
This is code is self explanatory but it is built to check that our COM values are in an acceptable range so are AUV does not roll or tip significantly during its voyage.

## Surfacing
This is a code that determines the time it would take for our AUV to rise to the surface of the water, potentially given a leak.
