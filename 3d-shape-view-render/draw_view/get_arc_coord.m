function [xc,yc,zc] = get_arc_coord(center, p1, p2)
% Calculate the arc from the given two points:p1,p2 and a center point

v1 = p1 - center;
v2 = p2 - center;
r = sqrt(sum(v1 .* v1));
points = zeros(101,3);
counter = 1;
for fi = 0:0.01:1
    v3 = v1 * fi + v2 * (1-fi);
    v3 = v3 ./ sqrt(sum(v3 .* v3)) * r;
    points(counter,:) = v3 + center;
    counter = counter + 1;
end

xc = points(:,1);
yc = points(:,2);
zc = points(:,3);
end