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