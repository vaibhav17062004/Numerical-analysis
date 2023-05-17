% Ask the user for input on SpO2 and body temperature
spo2_before = input('Enter SpO2 level before exercise (%): ');
temp_before_f = input('Enter body temperature before exercise (F): ');
temp_before = (temp_before_f - 32) * 5/9; % Convert Fahrenheit to Celsius
spo2_after = input('Enter SpO2 level after exercise (%): ');
temp_after_f = input('Enter body temperature after exercise (F): ');
temp_after = (temp_after_f - 32) * 5/9; % Convert Fahrenheit to Celsius
% Define exercise intensity levels x = 1:0.1:10;
% Define the effect of exercise on different organs as a function of exercise intensity
y_heart_before = 30*(1 - exp(-0.2*x)); % Heart rate increases by 30% of baseline
y_lungs_before = 40*(1 - exp(-0.3*x)); % Oxygen consumption increases by 40% of baseline
y_muscles_before = 50*(1 - exp(-0.4*x)); % Oxygen uptake increases by 50% of baseline
y_heart_after = 30*(1 - exp(- 0.2*x))*((spo2_after/100)/(spo2_before/100))^0.25*((temp_after+273.15)/(temp_before+273.15))^0.15;
y_lungs_after = 40*(1 - exp(- 0.3*x))*((spo2_after/100)/(spo2_before/100))^0.25*((temp_after+273.15)/(temp_before+273.15))^0.15;
y_muscles_after = 50*(1 - exp(- 0.4*x))*((spo2_after/100)/(spo2_before/100))^0.25*((temp_after+273.15)/(temp_before+273.15))^0.15;
% Perform cubic spline interpolation xq = linspace(min(x), max(x), 1000);
yq_heart_before = interp1(x, y_heart_before, xq, 'spline');
yq_lungs_before = interp1(x, y_lungs_before, xq, 'spline');

yq_muscles_before = interp1(x, y_muscles_before, xq, 'spline');
yq_heart_after = interp1(x, y_heart_after, xq, 'spline'); yq_lungs_after = interp1(x, y_lungs_after, xq, 'spline');
yq_muscles_after = interp1(x, y_muscles_after, xq, 'spline');
% Plot the effect of exercise on different organs before exercise
figure; hold on;
plot(xq, yq_heart_before, 'r', 'LineWidth', 2); rate before exercise
plot(xq, yq_lungs_before, 'g', 'LineWidth', 2); consumption before exercise
% Heart % Oxygen
plot(xq, yq_muscles_before, 'b', 'LineWidth', 2); % Oxygen uptake before exercise
xlabel('Exercise Intensity (METs)'); ylabel('Effect on Organ (%)'); title('Before Exercise');

legend('Heart Rate', 'Oxygen Consumption', 'Oxygen Uptake by lungs');
% Plot the effect of exercise on different organs after exercise
figure; hold on;
plot(xq, yq_heart_after, 'r', 'LineWidth', 2); rate after exercise
plot(xq, yq_lungs_after,'g','Linewidth',2); plot(xq,yq_muscles_after,'b','Linewidth',2); xlabel('Exercise Intensity (METs)'); ylabel('Effect on Organ (%)');
title('After Exercise');
% Heart
legend('Heart Rate', 'Oxygen Consumption', 'Oxygen Uptake by lungs');
