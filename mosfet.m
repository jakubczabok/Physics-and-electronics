% This MATLAB script calculates transconductance for electronic system with MOSFET
% Where Id = f(Ugs)
% Id is electric current, Ugs is voltage
% Data
Id=[12.7,11.6,10.96,10.05,9.16,8.37,7.55,6.76,5.98,5.18,4.48,3.84,3.16,2.55,1.96,1.42,0.92,0.54,0.24,0.06,0.006,0];
Ugs=[0,-0.21,-0.38,-0.6,-0.81,-1,-1.2,-1.4,-1.6,-1.81,-2,-2.2,-2.4,-2.6,-2.8,-3,-3.2,-3.4,-3.6,-3.8,-4,-4.1];

% Linear regression for first 7 measurements
x = polyfit(Ugs(1:7), Id(1:7), 1);
f= x(1) * Ugs + x(2);

% Trabsconductance
trans = x(1);

plot(Ugs, f, '-.', Ugs, Id, 'o');
hold on;
grid on;
title('Relationship Id=f(Ugs)');
xlabel('Current dren stream [mA]');
ylabel('Voltage on connector [V]');

text(Ugs(5), Id(5), sprintf('Transconductance is  %.2f', trans), 'HorizontalAlignment', 'left');
legend('Relationship from linear regression', 'Measurements Id', 'Location', 'best');
hold off;
