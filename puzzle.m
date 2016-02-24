
m1 = [0.15 0.2 0.08 0.1]';
C1 = [ 0.2 0.05 -0.01 0.0
       0.05 0.30 0.015 0.0
      -0.01 0.015 0.10 0.0
       0.0 0.0 0.0 0.0];
m2 = [0.15 0.2 0.08]';
C2 = [ 0.2 0.05 -0.01
       0.05 0.30 0.015
      -0.01 0.015 0.10];
%%
[V1, M1, PWts1] = NaiveMV(m1, C1, 100);
[V2, M2, PWts2] = NaiveMV(m2, C2, 100);
figure(1),clf,
plot(V1, M1, 'b', 'LineWidth', 4)
hold on
plot(V2, M2, 'r', 'LineWidth', 2)
title('Mean Variance Portfolio', 'FontSize', 22)
xlabel('Portfolio Risk', 'FontSize',18)
ylabel('Portfolio Return', 'FontSize', 18);
grid on
hold off




