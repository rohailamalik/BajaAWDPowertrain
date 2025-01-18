% Engine
w_e_tmax = 2700; % Max Torque Speed
w_e_max = 3800; % Max Engine Speed
T_e_max = 19; % Max Torque

% Transmission
N_tf = [15:0.1:40];
eta_tf = 0.85; % Drivetrain Efficiency
N_tf_overall = 10/3.5;
N_tf_high = N_tf./N_tf_overall;

% Road
miu_R = 0.05;
theta = 0*pi/180;
i = 0.02;

% Vehicle 
r = 0.3175;
m_c = 260;
m_d = 80;
g = 9.81;

% Aerodynamic
rho = 1.225;
A = 1;
C_D = 1;
h_a = 0.8;

% Engine Tractive Force
F_t = (T_e_max*N_tf.*eta_tf)/r;

% Rolling Load
F_r = (m_c + m_d)*g*miu_R*cos(theta)*ones(1,length(N_tf));

% Grade Load
F_g = (m_c + m_d)*g*sin(theta)*ones(1,length(N_tf));

% Drag Load
F_d = (0.5*rho*A*C_D*((pi*r*w_e_tmax*(1-i)*ones(1,length(N_tf)))./(30*N_tf)).^2);

% Equivalent Mass
m_eq = m_d*ones(1,length(N_tf)) + m_c*(1.04+(0.025*N_tf)+0.0000004*(N_tf).^2);

% Max. Acceleration
a_max = (F_t - F_r - F_g - F_d)./ m_eq;

% Top Speed
V_top = 3.6*(pi*r*w_e_max*(1-i)*ones(1,length(N_tf)))./(30*N_tf_high);

% Plots
grid minor
title('Variation of vehicle top characteristics with Drivetrain Low Ratio')
yyaxis right
plot(N_tf,a_max,'r','LineWidth',1.5)
xlabel('Drivetrain Low Gear Reduction Ratio')
ylabel('Max. Acceleration (m/s^2)')
yline(6.2,'r','Acceleration Limit')
yyaxis left
plot(N_tf,V_top,'b','LineWidth',1.5)
ylabel('Top Speed (km/h)')
yline(60,'b','Drivetrain Top Speed Limit')
yline(65,'b','Ideal Top Speed Limit')
legend('Top Speed','Max. Acceleration','Location','Northwest')