### This is a note about the reference, relevant knowledge which are mentioned would be write in this note as well. 

# 1. Kalman Filter
## 1.1. State Update Equation
The following equation is `State Update Equation`, which is used to estimate the state of static system. The characteristic of static system is that the true value of the system is still.

$$
\hat{x_{n,n}}=\hat{x_{n,n-1}}+\frac{1}{n}*(z_n-\hat{x}_{n,n-1})
$$

+ $\hat{x}_{n,n}$: the estimate state of `x` at the time `n` based on the measurement at time `n`
+ $\hat{x}_{n,n-1}$: the estimate state of `x` at the time `n` based on the measurement at time `n-1`
+ $\frac{1}{n}$: Kalman Gain $K_n=\frac{1}{n}$, can also be written as $a_n$
+ $z_n$: the meausurement

## 1.2. State Extrapolation Equation
To explain this equation, we are going to track a **constant-velocity** aircraft in **one dimension** using the α-β filter. In this system, the dynamic equation (Uniform Linear Motion Equation) is:

$$
x_{n+1}=x_{n}+\Delta t*\dot{x}_n
$$ 

The update equation which is used to track the aircraft is called `α−β track update equations` or `α−β track filtering equations`.

+ The Update State Equation for position:
  $$
  \hat{x}_{n,n}=\hat{x}_{n,n-1}+\frac{1}{n}*(z_n-\hat{x}_{n,n-1})
  $$
  
+ The Update State Equation for velocity:
  $$
  \hat{\dot{x}}_{n,n}=\hat{\dot{x}}_{n,n-1}+\beta*(\frac{z_n-\hat{x}_{n,n-1}}{\Delta t})
  $$

## 1.3. Dynamic Model Equation (α−β−γ Filter)
In this example, we are going to track an aircraft that is moving with `constant acceleration` in `one dimension` with the α−β−γ filter. The update equations about position, velocity and acceleration are shown as follow: 

$$\hat{x}_{n,n}=\hat{x}_{n,n-1}+\alpha*(z_n-\hat{x}_{n,n-1})$$

$$\hat{\dot{x}}_{n,n}=\hat{\dot{x}}_{n,n-1}+\beta*(\frac{z_n-\hat{x}_{n,n-1}}{\Delta t})$$

$$\hat{\ddot{x}}_{n,n}=\hat{\ddot{x}}_{n,n-1}+\gamma*(\frac{z_n-\hat{x}_{n,n-1}}{0.5* \Delta t^2})$$
