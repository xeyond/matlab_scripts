function [xI,yI,zI] = get_mesh_pos(norm_vec, center, scale)
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
xI = [p1(1),p2(1);p4(1),p3(1)];
yI = [p1(2),p2(2);p4(2),p3(2)];
zI = [p1(3),p2(3);p4(3),p3(3)];
end
