# Testing Method
The location information about the vehicles are numerous, which means it would spend a large amount time to label all the vehicle by frames. Sampling investigation would be a better way to calculate the error in this test. The sampling method is shown as follow. Select a video and sample it at fifty frame intervals. The vehicle information is annotated and compared with the image processing results to calculate the corresponding error and accuracy

# Sampling result
+ Video 2.5_2_4 Frame 50
  |Vehcile|Measurement|Labelled|Error|
  |:-|:-|:-|:-|
  |1|[1332.187,1655.925]|[1331,1656]|[1.187,-0.075]|
+ Video 2.5_2_4 Frame 100
  |Vehcile|Measurement|Labelled|Error|
  |:-|:-|:-|:-|
  |1|[483.150,1883.350]|[483,1887]|[0.150,-3.650]|
  |2|[1270.266,1024.485]|[1263,1024]|[7,0.485]|
  |3|[1345.655,1028.847]|[1337,1028]|[8.655,0.847]|
  |4|[1359.538,1343.495]|[1347,1342]|[12.538,1.495]|
  |5|[1370.976,1043.654]|[1390,1045]|[-19.024,-1.346]|
  |6|[1490.144,1038.437]|[1479.5,1037.5]|[10.644,0.937]|

+ Video 2.5_2_4 Frame 150
  |Vehcile|Measurement|Labelled|Error|
  |:-|:-|:-|:-|
  |1|[101.830,1945.560]
    [123.601,122.083]
    [176.479166666667,148.765625000000]
    [194.107142857143,126.178571428571]
    [250.766081871345,103.818713450292]
    [452.022222222222,1491.80888888889]
    [512.500000000000,20.7173913043478]
    [603.271739130435,1819.90217391304]
    [739.168674698795,1498.12048192771]
    [776.137500000000,1569.31250000000]
    [858.500000000000,1823.50000000000]
    [975,1871]
    [1026.96086956522,1265.90434782609]
    [1109.64814814815,636.351851851852]
    [1142.58227848101,1401.35443037975]
    [1160.23305084746,1208.66949152542]
    [1190.33333333333,670.333333333333]
    [1257.63043478261,1648.67391304348]
    [1271.86466165414,1336.13533834586]
    [1277.93814432990,1025.25257731959]
    [1352.50000000000,1029.83783783784]
    [1385.83870967742,1044.83870967742]
    [1404.16589861751,1663.07373271889]
    [1429.61658031088,1034.15544041451]

  



# Analysis
## The deviation between vehicle centre and tracking centre
+ The colour of vehicles: The grayscale image in MATLAB is 8-Byte grayscale, the value of the image would range from 0-255. In hence, we can assume that the value of the environment is 20. Vehicles with lighter colours appear white in the greyscale image, while vehicles with darker colours appear black in the greyscale image. To facilitate the distinction, we assume that the vehicles are pure white and pure black respectively, and their values in the greyscale image are 255(white) and 0(black). The result can be displayed by generating image through created matrices in MATLAB. The results are shown as follow.
  ````
  env1 = 30 * ones(8); 
  env2 = 10 * ones(8);
  w = 224; b = 1;

  white1=[0 0 0 0 0 0 0 0;
          0 w w w w 0 0 0;
          0 w w w w 0 0 0;
          0 w w w w 0 0 0;
          0 0 0 0 0 0 0 0;
          0 0 0 0 0 0 0 0;
          0 0 0 0 0 0 0 0;
          0 0 0 0 0 0 0 0;];
  white2=[0 0 0 0 0 0 0 0;
          0 0 0 w w w w 0;
          0 0 0 w w w w 0;
          0 0 0 w w w w 0;
          0 0 0 0 0 0 0 0;
          0 0 0 0 0 0 0 0;
          0 0 0 0 0 0 0 0;
          0 0 0 0 0 0 0 0;];
  black1=[0 0 0 0 0 0 0 0;
          0 0 0 0 0 0 0 0;
          0 0 0 0 0 0 0 0;
          0 b b b b 0 0 0;
          0 b b b b 0 0 0;
          0 b b b b 0 0 0;
          0 0 0 0 0 0 0 0;
          0 0 0 0 0 0 0 0;];
  black2=[0 0 0 0 0 0 0 0;
          0 0 0 0 0 0 0 0;
          0 0 0 0 0 0 0 0;
          0 0 0 b b b b 0;
          0 0 0 b b b b 0;
          0 0 0 b b b b 0;
          0 0 0 0 0 0 0 0;
          0 0 0 0 0 0 0 0;];
  ```` 
  + subtraction calculation and  result comparison
  ````
  whitet1 = (white1+env1)-(white2+env1); 
  whitet2 = (white1+env2)-(white2+env2);
  blackt1 = (black1+env1)-(black2+env1); 
  blackt2 = (black1+env2)-(black2+env2);
  I_w1 = mat2gray(whitet1); 
  I_w2 = mat2gray(whitet2);
  I_b1 = mat2gray(blackt1); 
  I_b2 = mat2gray(blackt2);

  figure,
  subplot(2,2,1);imshow(I_w1);
  subplot(2,2,2);imshow(I_w2);
  subplot(2,2,3);imshow(I_b1);
  subplot(2,2,4);imshow(I_b2);
  saveas(gcf,'comparison_subtraction_first.jpg', 'jpg')
  ````
  ![vehicles comparison](comparison_subtraction_first.jpg "cars with different colour and environment value")
  + For the first image, the subtraction of the matrices are made firstly, then the matrices are converted into image. In the process of transforming the grayscale image, the MATLAB programme automonously performs histogram equivalization. The positive and negative values of the subtraction of the two frames are represented simultaneously in the grayscale image.

  ![vehicle comparison](comparison_mat2gray_first.jpg "cars with different colour and environment value")
  + For the second image, the matrices are firstly convert into images and the images are used to make subtraction. In hence, only the positive value (where the car in the former frame) is displayed.

  According to the result, the colour of vehicles would not influence the tracking result. In reality, the However, the deviation between vehicle centre and tracking centre still exist. The influence of the vehicle size need to be take into account.

+ The size of vehicles: 
+ The speed of vehicles:

