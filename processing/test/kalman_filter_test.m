%% This programme is used for testing %%
clear; clc;
for i = 1:100
    % construct a position matrix about two points
    % produce the measurand with the error ± 0.5 
    M_t(1,i) = 3*i + (-0.5 + rand(1,1)); 
    M_t(2,i) = 3*i + (-0.5 + rand(1,1));
    % save the actual state information in the same matrix for comparion
    M_t(3,i) = 3*i;
    M_t(4,i) = 3*i;
end 

%% Kalman filter test
% The initial state matrix
S = 10^6 * eye(4);
% X = [746,1000,0,0]'; % The centre of image
X = [0,0,0,0]';
% Whether this is the first time to run the kalman filter
firstRun = 1;
for i = 1:100
    K = M_t(:,i);
    [xk, S, X, firstRun] = kalmanfilter(K, S, X, firstRun);
    M_t(5,i) = xk(1);
    M_t(6,i) = xk(2);
end


% %% The loop using distance-base association to associate centroid together
% for i = 1:99
%      a = M_t(:,i);
%      b = M_t(:,i+1);
%      for m = 1:length(a)/2
%          K(1,1) = a(2*m-1,1);
%          K(2,1) = a(2*m-1,1);
%          xk = kalmanfilter(K);
%          M_k(2*m-1:2*m,i) = xk;
%      end 
%      D = pdist2(M_k(:,i),b);
%      for m = 1:length(a)/2
%          for n = 1:length(b)/2
%              distance(m,n) = sqrt(D(m*2-1,n*2-1)^2 + D(m*2,n*2)^2);
%          end
%      end
%      for m = 1:length(a)/2 
%         [x,y] = find(min(min(distance)) == distance);
%         asso(2*m-1,i) = x;
%         asso(2*m,i) = y;
%         distance(x,:) = 1000000;
%         distance(:,y) = 1000000;
%       end
% end










