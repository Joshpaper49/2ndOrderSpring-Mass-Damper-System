u = 1; %force
b = 0.1 %damping constant
k = 0.4 %spring constant
m = 2 %mass
dt = 0.02; %timestep
position  = 0;
velocity  = 0;
acceleration  = 0;

%calculating second-order system characteristics and settling time
natural_freq = sqrt(k/m)
damping_ratio = b/(2*sqrt(m*k))
settle_time = 4/(natural_freq * damping_ratio)


%preparing data collection
time = 0:dt:settle_time;
y_values = zeros(1, length(time))
overshoot = zeros(1, length(time))
index = 1:1:length(time)

%equilibrium position
equil_pos = u/k

for num = index
    y_values(num) = position;

    acceleration = (u - (b*velocity) - (k*position))/m;
    
    velocity = velocity + acceleration * dt;
    position = position + velocity * dt;

    %finding and documenting peaks
    if num > 2
        if y_values(num-1) > y_values(num-2) && y_values(num-1) > position
            calc = ((y_values(num-1) - (equil_pos)) / (equil_pos)) * 100;
            overshoot(num) = calc;
        end
    end    

    y_values(num) = position;

end

%plotting
plot(time,y_values, "r")

hold on

overshoot

peak_indices = find(overshoot ~= 0);

plot(time(peak_indices), y_values(peak_indices), 'b*', 'MarkerSize', 10)