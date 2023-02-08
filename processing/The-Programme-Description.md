# Program Function Description 
## Image Processing
The programmes ``img_processing`` and ``img_processing_test`` are used for making image processing about the video. The ``img_processing_test`` programme is used to test if there is any modification needed in the ``img_processing``. The main function of these programmes is find the coordinations of vehicles by frames and save the results in the ``centroid`` folder in the ``data`` folder.

Image processing is performed on the image obtained by subtracting two consecutive frames, and the specific process is as follows：
+ Medium Filter: apply medium filter to the image
+ Binarization：convert the grayscale image into binary image, the ``threshold`` of binarization is quite low to prevent removal of valid information, noise is removed during subsequent image processing
+ Opening Operation: remove burrs and small noises by opening operation, and get the best results by adjusting structure element (SE).
+ Erosion: make objects smaller to prevent two objects from sticking together too closely and being judged as one object
+ Connected-component labeling (CCL): label the objects by 4-connectivity

******
## Multi Association
The programmes ``multi_association`` and ``multi_association_test`` are used to making association on multiple vehicles. 
******
## Single Association
The programmes ``single_association`` and ``single_association_test`` are used to making association on single vehicle. 
******
## Video Maker
The ``videomaker`` is used to generate the video about the result based on the series of data in the ``data`` folder. This is an auxiliary program for displaying results
******
## Kalman Filter
The programme ``kalmanfilter_function`` is the MATLAB function which used as Kalman filter in both single vehicle association and multiple vehicle association. 
