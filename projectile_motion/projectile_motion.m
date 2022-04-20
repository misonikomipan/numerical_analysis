function [res] = projectile_motion(init_pos,init_speed,d_t)
%UNTITLED2 この関数の概要をここに記述
%   詳細説明をここに記述
cnt = 1;
res(:,cnt) = init_pos;
position_p = init_pos;
speed_p = init_speed;
time = -d_t;
while res(2,cnt) >= 0
    cnt = cnt + 1;
    time = time + d_t;
    position_n = position_p + speed_p * d_t;
    speed_n = speed_p + acceleration * d_t;
    res(:,cnt) = position_n;
    position_p = position_n;
    speed_p = speed_n;
end
end