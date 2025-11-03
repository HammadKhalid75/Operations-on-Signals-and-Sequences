% MATLAB Program for Signal Operations (Continuous & Discrete)
% Outputs plots exactly as shown in the provided images
% Uses switch-case for choice 1 (continuous) or 2 (discrete)

clc; clear; close all;

choice = input('1. operations on continuous time signals\n2. operations on discrete time signals\nenter your choice : ');

switch choice
    case 1
        % =============== CONTINUOUS TIME SIGNALS (Choice 1) ===============
        t1 = 0:0.001:1;
        t2 = 0:0.001:1;
        
        % Original signals
        s1 = sin(2*pi*1*t1);  % frequency 1
        s2 = sin(2*pi*2*t2);  % frequency 2
        
        % Sum
        sum_sig = s1 + s2;
        
        % Multiplication
        mul_sig = s1 .* s2;
        
        % Time delayed (shift right by 0.5)
        t_delay = t1 - 0.5;
        delayed_sig = sin(2*pi*1*max(t_delay,0));
        delayed_sig(t_delay < 0) = 0;
        
        % Time advanced (shift left by 0.2)
        t_advance = t1 + 0.2;
        advanced_sig = sin(2*pi*1*t_advance);
        
        % Time compressed (scale time by 2)
        t_comp = t1 * 2;
        compressed_sig = sin(2*pi*1*t_comp);
        t_comp_plot = 0:0.001:0.5;
        compressed_sig_plot = sin(2*pi*1*(t_comp_plot*2));
        
        % Time expanded (scale time by 0.5)
        t_exp = t1 / 2;
        expanded_sig = sin(2*pi*1*t_exp);
        t_exp_plot = 0:0.001:2;
        expanded_sig_plot = sin(2*pi*1*(t_exp_plot/2));
        
        % Reflected (time reversal)
        t_ref = -t1;
        reflected_sig = sin(2*pi*1*flip(t1));
        
        % Amplitude scaled (by 2)
        scaled_sig = 2 * s1;
        
        % Plotting in 4x2 grid
        figure('Position', [100, 100, 800, 1000]);
        
        % Row 1
        subplot(4,2,1);
        plot(t1, s1, 'b', 'LineWidth', 1.5); grid on;
        title('original signal with frequency 1'); xlabel('time t'); ylim([-1.5 1.5]);
        
        subplot(4,2,2);
        plot(t2, s2, 'b', 'LineWidth', 1.5); grid on;
        title('original signal with frequency 2'); xlabel('time t'); ylim([-1.5 1.5]);
        
        % Row 2
        subplot(4,2,3);
        plot(t1, sum_sig, 'b', 'LineWidth', 1.5); grid on;
        title('sum of 2 signals'); xlabel('time t'); ylim([-2.5 2.5]);
        
        subplot(4,2,4);
        plot(t1, mul_sig, 'b', 'LineWidth', 1.5); grid on;
        title('multiplication of s1 and s2'); xlabel('time t'); ylim([-1.2 1.2]);
        
        % Row 3
        subplot(4,2,5);
        plot(t1, delayed_sig, 'b', 'LineWidth', 1.5); grid on;
        title('time delayed signal'); xlabel('time t'); xlim([0 1]); ylim([-1.5 1.5]);
        
        subplot(4,2,6);
        plot(t_advance, advanced_sig, 'b', 'LineWidth', 1.5); grid on;
        title('time advanced signal'); xlabel('time t'); xlim([-0.2 1]); ylim([-1.5 1.5]);
        
        % Row 4
        subplot(4,2,7);
        plot(t_comp_plot, compressed_sig_plot, 'b', 'LineWidth', 1.5); grid on;
        title('compressed signal'); xlabel('time t'); xlim([0 0.5]); ylim([-1.5 1.5]);
        
        subplot(4,2,8);
        plot(t_exp_plot, expanded_sig_plot, 'b', 'LineWidth', 1.5); grid on;
        title('expanded signal'); xlabel('time t'); xlim([0 2]); ylim([-1.5 1.5]);
        
        % Additional plots: reflected and amplitude scaled
        figure('Position', [900, 100, 800, 600]);
        
        subplot(2,1,1);
        plot(t_ref, reflected_sig, 'b', 'LineWidth', 1.5); grid on;
        title('reflected signal'); xlabel('time t'); xlim([-1 0]); ylim([-1.5 1.5]);
        
        subplot(2,1,2);
        plot(t1, scaled_sig, 'b', 'LineWidth', 1.5); grid on;
        title('amplitude scaled signal'); xlabel('time t'); ylim([-3 3]);
        
        % Energy and Power
        energy = trapz(t1, s1.^2);
        power = energy / length(t1);
        fprintf('Continuous Signal - Energy: %.4f, Average Power: %.4f\n', energy, power);
        
    case 2
        % =============== DISCRETE TIME SIGNALS (Choice 2) ===============
        n1 = -10:10;
        n2 = -10:10;
        
        % Discrete sine waves
        x1 = sin(2*pi*(1/10)*n1);  % period 10
        x2 = sin(2*pi*(1/8)*n2);   % period 8
        
        % Operations
        sum_x = x1 + x2;
        mul_x = x1 .* x2;
        
        % Time shifted (right shift by 3)
        shift = 3;
        n_shifted = n1 - shift;
        x1_shifted = zeros(size(n_shifted));
        for i = 1:length(n1)
            idx = find(n_shifted == n1(i), 1);
            if ~isempty(idx)
                x1_shifted(i) = x1(idx);
            end
        end
        
        % Time folded (reflection about n=0)
        n_folded = -n1;
        x1_folded = x1(end:-1:1);
        
        % Amplitude scaled (by 2)
        x2_scaled = 2 * x2;
        
        % Plotting
        figure('Position', [100, 100, 900, 1000]);
        markersize = 6;
        linewidth = 1.5;
        
        % Row 1
        subplot(4,2,1);
        stem(n1, x1, 'b', 'filled', 'MarkerSize', markersize, 'LineWidth', linewidth); grid on;
        title('discrete sine wave x1(n) with time period=10'); xlabel('n'); ylim([-1.2 1.2]);
        
        subplot(4,2,2);
        stem(n2, x2, 'b', 'filled', 'MarkerSize', markersize, 'LineWidth', linewidth); grid on;
        title('discrete sine wave x2(n) with time period=8'); xlabel('n'); ylim([-1.2 1.2]);
        
        % Row 2
        subplot(4,2,3);
        stem(n1, sum_x, 'b', 'filled', 'MarkerSize', markersize, 'LineWidth', linewidth); grid on;
        title('sum of two discrete time signals'); xlabel('n'); ylim([-2.5 2.5]);
        
        subplot(4,2,4);
        stem(n1, mul_x, 'b', 'filled', 'MarkerSize', markersize, 'LineWidth', linewidth); grid on;
        title('multiplication of two discrete time signals'); xlabel('n'); ylim([-1.2 1.2]);
        
        % Row 3
        subplot(4,2,5);
        stem(n_shifted, x1_shifted, 'b', 'filled', 'MarkerSize', markersize, 'LineWidth', linewidth); grid on;
        title('time shifted signal of x1(n)'); xlabel('n'); ylim([-1.2 1.2]);
        
        subplot(4,2,6);
        stem(n_folded, x1_folded, 'b', 'filled', 'MarkerSize', markersize, 'LineWidth', linewidth); grid on;
        title('time folded signal of x1(n)'); xlabel('n'); ylim([-1.2 1.2]);
        
        % Row 4
        subplot(4,2,7);
        stem(n2, x2_scaled, 'b', 'filled', 'MarkerSize', markersize, 'LineWidth', linewidth); grid on;
        title('amplitude scaled discrete time signal of x2(n)'); xlabel('n'); ylim([-2.5 2.5]);
        
        % Energy and Power for x1
        energy_disc = sum(x1.^2);
        power_disc = energy_disc / length(x1);
        fprintf('Discrete Signal - Energy: %.4f, Average Power: %.4f\n', energy_disc, power_disc);
        
    otherwise
        disp('Invalid choice! Please enter 1 or 2.');
end