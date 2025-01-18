% This code calculates the limits for the vehicle's max. acceleration and
% top speed

% Road 
mu_R = 0.05;
theta = 0*pi/180;
mu = 0.68; 

% Vehicle 
r = 0.3175;
m_c = 260;
m_d = 80;
m = m_c + m_d;
g = 9.81;
V = 0.01:1:75;

% Engine
P_e = 6714*ones(1,length(V)); % Max Engine Power

% Traction Force
F_tmaxeng = 3.6*(P_e./V); % Traction Engine Limited 
F_tmaxfr = mu*m*g*cos(theta); % Traction Friction Limited

% Aerodynamic
rho = 1.225;
A = 1;
C_D = 1;

% Rolling Load
F_r = mu_R*m*g*cos(theta);

% Drag Load
F_d = 0.5*rho*C_D*A*(V./3.6).^2; % Drag with maximum traction

% Grade Load
F_g = m*g*sin(theta);

% Net Force Eng Max
a_maxeng = (F_tmaxeng - F_d - F_g*ones(1,length(V)) - F_r*ones(1,length(V)))./m;

% Net Force Fric Max
a_maxfr = (F_tmaxfr - F_d - F_g*ones(1,length(V)) - F_r*ones(1,length(V)))./m;

% Acceleration Limits
plot(V,a_maxeng,V,a_maxfr,'LineWidth',1.5)
xlim([0 70]);
ylim([0 7]);
title('Max Acceleration vs. Vehicle Speed')
xlabel('Vehicle Speed (km/h)')
ylabel(['Max Acceleration (m/s^2)']) 
y1 = yline(6.2,'--','Max. Acceleration Limit');
x1 = xline(65,'--','Ideal Top Speed Limit');
x2 = xline(60,'--','Drivetrain Top Speed Limit');
x1.LabelVerticalAlignment = 'middle';
x2.LabelVerticalAlignment = 'middle';
y1.LabelHorizontalAlignment = 'center';
legend('Engine Limit','Friction Limit','Location','Southwest')