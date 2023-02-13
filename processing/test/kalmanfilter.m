function [xk, S, X, firstRun] = kalmanfilter(m, S, X, firstRun) 
% Initialization
dt=0.2;
noise_process = 1;
noise_measurement = 0.5;
% Initialize state transition matrix
F=[ 1 0 dt 0;...     % [x ]            
    0 1 0 dt;...     % [y ]
    0 0 1 0 ;...     % [Vx]
    0 0 0 1];...     % [Vy]
% Initialize measurement matrix
H = [ 1 0 0 0 ;...
      0 1 0 0];   
% The error covariance matrices
Q = [dt^4/4 0 dt^3/2 0;
     0 dt^4/4 0 dt^3/2;
     dt^3/2 0 dt^2 0;
     0 dt^3/2 0 dt^2].*(noise_process^2);

R = eye(2).* noise_measurement;

% This used to be the parameter that would not take into account in main function %
% However, this would be unconvenient for the debug %
% persistent S X firstRun
% if isempty(firstRun)
%     % The initial state matrix
%     S = 10^6 * eye(4);
%     % X = [746,1000,0,0]'; % The centre of image
%     X = [0,0,0,0]';
%   firstRun = 1;
% end

X_ = F*X;
S_ = F*S*F.' + Q;
K = S_ * H.' * inv(H * S_ * H.' + R);

Y = [m(1) m(2)]';
X = X_ + K*(Y - H * X_);
S = S_ - K * H * S_;
xk(1,1) = X(1);
xk(2,1) = X(2);
end
