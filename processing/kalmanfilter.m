function [xk] = kalmanfilter(m) 
% Initialization
dt=0.2;
% Initialize state transition matrix
F=[ 1 0 dt 0;...     % [x ]            
    0 1 0 dt;...     % [y ]
    0 0 1 0 ;...     % [Vx]
    0 0 0 1];...     % [Vy]
% Initialize measurement matrix
H = [ 1 0 0 0 ; 0 1 0 0];   
% The error covariance matrices
Q = [dt*dt/4 0 dt/2 0;
     0 dt*dt/4 0 dt/2;
     dt/2 0 1 0;
     0 dt/2 0 1];
R = 0.5 * eye(2);

persistent S X firstRun

if isempty(firstRun)
    % The initial state matrix
    S = 10^6 * eye(4);
    % X = [746,1000,0,0]'; % The centre of image
    X = [0,0,0,0]';
  firstRun = 1;
end

X_ = F*X;
S_ = F*S*F.' + Q;
K = S_ * H.' * inv(H * S * H.' + R);

Y = [m(1) m(2)]';
X = X_ + K*(Y - H * X_);
S = S_ - K * H * S_;
xk(1,1) = X(1);
xk(2,1) = X(2);
end
