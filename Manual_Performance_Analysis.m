% Code for analysing the behaviour of an AWD/4WD for a given manual
% transmission

% Road 
mu_R = 0.05;
theta = 0*pi/180;
i = 0.02;
mu = 0.68; 

% Vehicle 
r = 0.3175;
m_c = 260;
m_d = 80;
m = m_c + m_d;
g = 9.81;

% Engine
w_e = 2000:1:3800; % Engine Speed Range
T_0 =  9.2260636364;
T_1 =  0.0074237652;
T_2 = -0.0000014089;
T_e =  T_0 + T_1*w_e + T_2*w_e.^2; % Torque

% Transmission
N_t = [10 6 4.5 3.5]; % Gear Ratios
N_f = 3; % Final Ratio
N_tf = N_f*N_t;
eta_tf = 0.85; % Drivetrain Efficiency

% Aerodynamic
rho = 1.225;
A = 1;
C_D = 1;
h_a = 0.8;

% Speed at tires, Actual Tractive Effort
F_t = zeros(length(N_tf),length(w_e));
V = zeros(length(N_tf),length(w_e));
for x=1:length(N_tf)
    for y=1:length(w_e)
        V(x,y) = 3.6*(w_e(y)*pi*(1-i)*r)/(30*N_tf(x));
        F_t(x,y) = N_tf(x)*T_e(y)*eta_tf/r; 
    end
end

% Rolling Load
F_r = mu_R*m*g*cos(theta);

% Drag Load
F_d = 0.5*rho*C_D*A*(V./3.6).^2;
F_d_tmax = 0.5*rho*C_D*A*(V_pmax./3.6).^2; % Drag with maximum traction

% Grade Load
F_g = m*g*sin(theta);

% Vehicle Mass Factor
lambda = m_d + (1.04 +0.025*N_tf' +0.0000004*(N_tf.^2)')*m_c;

% Net Force
a = (F_t - F_d - F_g*ones(length(N_tf),length(w_e)) - F_r*ones(length(N_tf),length(w_e)))./lambda;

% Acceleration vs Vehicle Speed Graph
plot(V(1,:),a(1,:),'r',V(2,:),a(2,:),'g',V(3,:),a(3,:),'m',V(4,:),a(4,:),'b','LineWidth',1.5)
xlim([0 70]);
ylim([0 2.5]);
title('Net Acceleration vs. Vehicle Speed')
xlabel('Vehicle Speed (km/h)')
ylabel(['Net Acceleration (m/s^2)']) 
legend('1st Gear','2nd Gear','3rd Gear','4th Gear','Location','Northeast')

% Vehicle vs Engine Speed Graph
plot(V(1,:),w_e,'r',V(2,:),w_e,'m',V(3,:),w_e,'b',V(4,:),w_e,'g','LineWidth',1.5)
xlim([0 70]);
ylim([1500 4000]);
title('Vehicle Speed vs. Engine Speed')
xlabel('Vehicle Speed (km/h)')
ylabel(['Engine Speed (rpm)'])
legend('1st Gear','2nd Gear','3rd Gear','4th Gear','Location','Southeast')