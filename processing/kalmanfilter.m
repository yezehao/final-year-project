function y = kalmanfilter(z) 
%#codegen
dt=0.2;
% Initialize state transition matrix
A=[ 1 0 dt 0 0 0;...     % [x ]            
    0 1 0 dt 0 0;...     % [y ]
    0 0 1 0 dt 0;...     % [Vx]
    0 0 0 1 0 dt;...     % [Vy]
    0 0 0 0 1 0 ;...     % [Ax]
    0 0 0 0 0 1 ];       % [Ay]
% Initialize measurement matrix
H = [ 1 0 0 0 0 0;...
      0 1 0 0 0 0 ];   

% The airspace monitoring system is reliable 
% so Q matrix is small while the R matrix is large
Q = 0.1 * eye(6);        
R = 1000 * eye(2);

% Initial state conditions
persistent x_est p_est   
if isempty(x_est)
    x_est = zeros(6, 1); % x_est=[x,y,Vx,Vy,Ax,Ay]'
    p_est = zeros(6, 6);
end
% Predicted state and covariance
x_prd = A * x_est;
p_prd = A * p_est * A' + Q;
% Estimation
S = H * p_prd' * H' + R;
B = H * p_prd';
klm_gain = (S \ B)';
% Estimated state and covariance
x_est = x_prd + klm_gain * (z - H * x_prd);
p_est = p_prd - klm_gain * H * p_prd;
% Compute the estimated measurements
y = H * x_est;
end

%% Reference %%
% https://www.mathworks.com/help/coder/ug/c-code-generation-
% for-a-kalman-filtering-algorithm_zh_CN.html