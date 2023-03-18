# Program Function Description 
## Image Processing
The programme ``centroid_finding`` is used for making image processing about the video. The main function of the programme is find the coordinations of vehicles by frames and save the results in the ``centroid`` folder in the ``data`` and ``processing`` folders seperately.

Image processing is performed on the image obtained by subtracting two consecutive frames, and the specific process is as follows：
+ *Medium Filter*: apply medium filter to the image
+ *Binarization*：convert the grayscale image into binary image, the ``threshold`` of binarization is quite low to prevent removal of valid information, noise is removed during subsequent image processing
+ *Opening Operation*: remove burrs and small noises by opening operation, and get the best results by adjusting structure element (SE).
+ *Erosion*: make objects smaller to prevent two objects from sticking together too closely and being judged as one object
+ *Connected-component labeling (CCL)*: label the objects by 4-connectivity

******
## Tracking
The programme ``tracking`` would generate track according to the following algorithm and store traced information in a structure variable 
### Variabels
+ ``Track``
  + ``Track.centroid``: The series of centroid of specific vehicle
  + ``Track.kalmanX``: The X matrix of kalman filter
  + ``Track.kalmanS``: The S matrix of kalman filter
  + ``Track.delete``: The variable used for tracking deletion

+ ``Nt``: The number of Tracks that already exist
+ ``Nd``: The number of Measurement that detected

### Algorithm
````
if Nd == 0
    if Nt == 0
        Do nothing
    else (Nt ~= 0)
        Update tracking without measurement
        if the track cannot match to the measurement for 10 frames
            stop tracking
        end
    end
else (Nd ~= 0)
    if Nt == 0
        start tracking
    else (Nt ~= 0)
        Ⅰ) use pdist2 to generate the distance matrix => (m1 x m2)
        Ⅱ) Basic association matrix => (n x n)
        Ⅲ) Labelling:
            number of matched centroid => n (1)
            number of tracks without measurement => m1-n (-1)
            number of new tracks => m2-n (0)
        Ⅳ) Complete assocaition matrix
        Ⅴ) Tracking according to label:
            label = 1: match with previous tracks
            label = 0: create new tracks
            label = -1: update track without measurement
                if track not match to measurements for 10 frames
                    stop tracking
                end
    end        
````

******
## Auxiliary Programmes
+ Trajectory Display: The programme ``trajectory_display`` is used to generate the video and images about the trajectory based on the ``Track`` data generate in the ``tracking`` programme. This is an auxiliary program for result visualization.

+ Kalman Filter: The programme ``F_kalmanfilter`` is the MATLAB function which used as Kalman filter in tracking algorithm. The function would update S and X matrices. If the measurement ``m`` is empty, the kalman filter would make prediction without measurement. If the measurement ``m`` is not empty, the kalman filter would help reduce the noises.
