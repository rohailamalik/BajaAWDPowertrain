w_e = 2000:1:3800; % Engine rpm
w_e_SI = (pi/30)*w_e; % Engine Speed in rad/s
T_0 =  9.2260636364;
T_1 =  0.0074237652;
T_2 = -0.0000014089;
T_e =  T_0 + T_1*w_e + T_2*w_e.^2; % Engine Torque
P_e = (T_e.*w_e_SI)/1000; % Engine Power (W)
% Plots
title('B&S Vanguard M19 Performance Curve')
yyaxis right
plot(w_e,T_e,'r','LineWidth',1.5)
xlabel('Engine Speed (RPM)')
ylabel('Torque (Nm)')
yyaxis left
plot(w_e,P_e,'b','LineWidth',1.5)
ylabel('Power (kW)')
legend('Power','Torque','Location','Northwest')