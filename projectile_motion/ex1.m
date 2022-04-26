clear; close all; clc;

%% 実験条件設定
% パラメータ
v0 = 2.0;
theta0 = pi/6;
basis_vector = [cos(theta0), sin(theta0)].';
initial_position = [0 0].';
initial_speed = v0 * basis_vector;
delta_t = 0.01;
g = 9.81;
acceleration = [0 -g].';

% 結果保存用
res = [];
out_dir_path = "./out/";
excel_file_name = "result.xlsx"; % 結果を保存するエクセルファイル名
excel_file_path = out_dir_path + excel_file_name; % エクセルファイルのパス（outDir内のexcelFileName）


%% シミュレーション
cnt = 1;
res(:,cnt) = initial_position;
position_p = initial_position;
speed_p = initial_speed;
time = -delta_t;
while res(2,cnt) >= 0
    cnt = cnt + 1;
    time = time + delta_t;
    position_n = position_p + speed_p * delta_t;
    speed_n = speed_p + acceleration * delta_t;
    res(:,cnt) = position_n;
    position_p = position_n;
    speed_p = speed_n;
end


%% プロット
f = figure;
f.Position = [0 0 1200 800];
f = plot(res(1, :), res(2, :), "Marker", "o", "MarkerSize", 3);
ax = gca;
ax.FontSize = 12;
title('Line Plot of projectile motion with initial values \theta = \pi / 6 [rad] and v = 0.2 [m/s]', FontSize=20)
xlabel('Position of the mass point [m] (x coordinate)', FontSize=18) 
ylabel('Position of the mass point [m] (y coordinate)', FontSize=18) 



%% データ保存
fig_name = "projectile_motion_ex1";
fig_path = out_dir_path + fig_name;
saveas(f, fig_path, "png");

file_name = "projectile_motion_ex1.csv";
file_path = out_dir_path + file_name;
writematrix(res, file_path);
