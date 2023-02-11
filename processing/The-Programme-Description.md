# Program Function Description 
## Image Processing
The programme ``img_processing`` is used for making image processing about the video. The main function of the programme is find the coordinations of vehicles by frames and save the results in the ``centroid`` folder in the ``data`` and ``processing`` folders seperately.

Image processing is performed on the image obtained by subtracting two consecutive frames, and the specific process is as follows：
+ Medium Filter: apply medium filter to the image
+ Binarization：convert the grayscale image into binary image, the ``threshold`` of binarization is quite low to prevent removal of valid information, noise is removed during subsequent image processing
+ Opening Operation: remove burrs and small noises by opening operation, and get the best results by adjusting structure element (SE).
+ Erosion: make objects smaller to prevent two objects from sticking together too closely and being judged as one object
+ Connected-component labeling (CCL): label the objects by 4-connectivity

******
## Assiciation
+ Distance-Based Association: The programme ``association_DB`` is used to making association on multiple vehicles according to distance.
+ Single Association: The programme ``association_S`` is used to making association on single vehicle.  
+ Multi Association: The programme ``association_M`` is used to making association on multiple vehicles. 

******
## Auxiliary Programmes
+ Video Maker: The ``videomaker`` is used to generate the video about the result based on the series of data in the ``data`` folder. This is an auxiliary program for displaying results

+ Kalman Filter: The programme ``kalmanfilter`` is the MATLAB function which used as Kalman filter in both single vehicle association and multiple vehicle association. 
