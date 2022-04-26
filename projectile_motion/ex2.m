clear; close all; clc;

% Lennard-Jones(LJ)ポテンシャルによる粒子間の相互作用（引力、斥力）から生じる加速度を求めよう。

%% 実験条件設定
% パラメータ
initial_position = [2 1.5].';
initial_speed = [-0.05 0].';
delta_t = 0.1;
max_t = 100;
epsilon = 1/48;
sigma = 1;
isSave = true;

% 結果保存用
res = [];
out_dir_path = "./out/";
excel_file_name = "result.xlsx"; % 結果を保存するエクセルファイル名
excel_file_path = out_dir_path + excel_file_name; % エクセルファイルのパス（outDir内のexcelFileName）


%% シミュレーション
cnt = 1;
time = 0;
position_n = initial_position;
speed_n = initial_speed;
position_2 = [0 0].';
while time <= max_t
    % record
    res(:,cnt) = position_n;

    % calc force of particle1
    F1 = calc_F1(position_n, position_2, epsilon, sigma);

    % parameter updates
    cnt = cnt + 1;
    time = time + delta_t;
    position_n = position_n + speed_n * delta_t;
    speed_n = speed_n + F1 * delta_t;
end


%% プロット
f = figure;
f.Position = [0 0 1200 800];
f = plot(res(1, :), res(2, :), "Marker", "o", "MarkerSize", 3);
ax = gca;
ax.FontSize = 12;
title('Line Plot of projectile motion with initial values \epsilon = 1 and \sigma = 1 ', FontSize=20)
xlabel('Position of the mass point1 [m] (x coordinate)', FontSize=18) 
ylabel('Position of the mass point1 [m] (y coordinate)', FontSize=18) 



%% データ保存
if isSave == true
    fig_name = "projectile_motion_ex2";
    fig_path = out_dir_path + fig_name;
    saveas(f, fig_path, "png");
    
    file_name = "projectile_motion_ex2.csv";
    file_path = out_dir_path + file_name;
    writematrix(res, file_path);
end

%-----------------------------------------------------------------
% Local function
function F1 = calc_F1(pos1, pos2, epsilon, sigma)
    pos_vector = pos1 - pos2;
    pos_norm = norm(pos_vector);
    norm6 = (sigma / pos_norm) ^ 6;
    Fr = (48*epsilon/pos_norm) * (norm6^2 - 1/2 * norm6);
    F1 = Fr* pos_vector/pos_norm;
end
