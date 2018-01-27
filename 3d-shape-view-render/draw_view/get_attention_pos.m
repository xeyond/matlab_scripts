function [vects, faces] = get_attention_pos( norm_vec, center, scale, length)
%GET_ATTENTION_POS 此处显示有关此函数的摘要
%   此处显示详细说明
% Calculate a square mesh given the normal vector and center(start point), 
% scale decides the size of the mesh 

v1 = [norm_vec(2), -norm_vec(1), 0];
v2 = cross(v1,norm_vec);
v1 = v1 / sqrt(sum(v1 .* v1));
v2 = v2 / sqrt(sum(v2 .* v2));
v1 = v1 + v2;
v2 = cross(v1,norm_vec);
v1 = v1 / sqrt(sum(v1 .* v1)) * scale;
v2 = v2 / sqrt(sum(v2 .* v2)) * scale;

p1 = center + v1;
p3 = center - v1;
p2 = center + v2;
p4 = center - v2;

norm_vec = norm_vec / sqrt(sum(norm_vec .* norm_vec));
p5 = p1 + norm_vec * length;
p6 = p2 + norm_vec * length;
p7 = p3 + norm_vec * length;
p8 = p4 + norm_vec * length;

vects = [p1;p2;p3;p4;p5;p6;p7;p8];
faces = [1,2,3,4;5,6,7,8; 1,2,6,5; 2,3,7,6;3,4,8,7;1,4,8,5];

end

