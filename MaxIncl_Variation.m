% Road 
mu_R = 0.05;
i = 0.02;
mu = 0.68; 

% Vehicle 
r = 0.3175;
m_c = 260;
m_d = 80;
m = m_c + m_d;
g = 9.81;

% Engine
w_e_tmax = 2700; % Engine Speed Range
T_e_max =  19; % Torque

% Transmission
eta_tf = 0.85; % Drivetrain Efficiency

% Aerodynamic
rho = 1.225;
A = 1;
C_D = 1;

% Plot
grid minor
yline(35,'r','Gradeability Limit')
title('Variation of climbable inclination with Drivetrain Low Ratio')
f = @(N_tf,theta) (T_e_max*N_tf*eta_tf)/r - m*g*(mu_R*cosd(theta)+sind(theta)) - 0.5*rho*A*C_D*((pi*r*w_e_tmax*(1-i))/(30*N_tf));
fimplicit(f,[15 40 0 45],'r','LineWidth',1.5)
xlabel('Drivetrain Low Gear Reduction Ratio')
ylabel('Max. Climbable Inclincation (degrees)')