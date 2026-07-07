# Spring-Mass-Damper Simulation

This project simulates a basic spring-mass-damper system in MATLAB. The goal was to understand how a second-order system responds to a constant applied force and how parameters like mass, spring stiffness, damping, and time step affect the motion.

**The m file is the visible file to Github with plot quality of life updates**

## System Overview

The system includes:
u: constant applied force
m: mass
k: spring constant
b: damping coefficient
dt: simulation time step

The system is modeled is the spring mass damper system with the following equation:

mẍ = u - bẋ - kx

In the code, this was rearranged and calculated as:

acceleration = (u - (b * velocity) - (k * position))/m;


The applied force pushes the mass forward, the spring force pulls it back proportional to its displacement, and the damping force opposes motion proportional to its velocity.

## Forward Euler Method

This simulation uses the Forward Euler Method to approximate the motion over time.
Instead of solving the differential equation analytically, the code evaluates the acceleration at each small time step, then updates velocity and position:
velocity = velocity + acceleration * dt;
position = position + velocity * dt;

## Equilibrium Position

The equilibrium position is calculated using:
equil_pos = u/k;

This works because equilibrium occurs when the system is no longer moving and all forces are balanced. At equilibrium, velocity is zero, so the damping force is also zero. That leaves the applied force and spring force balancing each other:

u = kx ===> x = u/k 

## Settling Time

The code estimates settling time using the standard second-order system approximation:

natural_freq = sqrt(k/m);
damping_ratio = b/(2 * sqrt(m*k));
settle_time = 4/(natural_freq * damping_ratio);

This estimates the time needed for the system to settle within about 2% of its final value.

## Overshoot Detection

The code also detects local peaks in the response and calculates percent overshoot:

calc = ((y_values(num-1) - equil_pos) / equil_pos) * 100;

This compares the peak value to the equilibrium position and expresses the overshoot as a percentage.The detected peaks are plotted using blue stars.

## What I Learned

This project helped me understand that a system’s behavior is determined by the interaction of multiple parameters, not just one variable. The applied force and spring constant determine the equilibrium position, while damping affects how quickly the system loses energy and settles.

I also realized that the Forward Euler Method is for the approximation of system response with a specified time step and thus assumes the system's acceleration remains approximately constant over each time step. 
