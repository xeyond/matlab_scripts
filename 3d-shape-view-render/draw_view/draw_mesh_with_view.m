% draw a mesh with its views around

% load mesh
mesh = loadMesh('./data/airplane_0627.off');
% draw mesh
h = trimesh(mesh.F', mesh.V(2,:)', mesh.V(1,:)' ,mesh.V(3,:)',   'FaceColor', 'w', 'EdgeColor', 'none', ...
        'AmbientStrength', 0.3, 'DiffuseStrength', 0.6, 'SpecularStrength', 0.0,  'FaceLighting', 'gouraud');
set(gcf, 'Color', 'w', 'Renderer', 'OpenGL');
set(gca, 'Projection', 'perspective');    
axis equal;
axis off;
cl = camlight('HEADLIGHT'); 
hold on;

% draw views
sphere_radius = 600;

vertices = get_points();
center = [mean(mesh.V(2,:)), mean(mesh.V(1,:)), mean(mesh.V(3,:))];
v = vertices * sphere_radius + center;

[x,y,z] = sphere();
h = surf(x * sphere_radius + center(1),y * sphere_radius + center(2),z * sphere_radius + center(3));
set(h, 'FaceAlpha', 0.1, 'FaceColor',[1 1 1],'FaceLighting','gouraud','EdgeColor','none');
% load view images
for fi = 1:20
    img = imread(sprintf('./data/airplane_0627_%03d.jpg',fi*4 - 3));
    img = fliplr(img);
    r_vec = v(fi,:)-center;
    [xI,yI,zI] = get_mesh_pos(r_vec,v(fi,:) + 0.015 * r_vec,200);
    surf(xI,yI,zI,'CData',img,'FaceColor','texturemap');
%     text(double(v(fi,1)),double(v(fi,2)),double(v(fi,3)),num2str(fi));
end

sim_mat = zeros(20,20);
for fi = 1:20
    for fj = 1:20
        v1 = v(fi,:) - center;
        v2 = v(fj,:) - center;
        theta = sum(v1 .* v2) / (sqrt(sum(v1 .* v1)) * sqrt(sum(v2 .* v2))) + 1;
        sim_mat(fi,fj) = theta / 2;
    end
end

% % draw arcs between the vertexs
% for fi = 1:19
%     for fj = (fi+1):20
%         v1 = v(fi,:) - center;
%         v2 = v(fj,:) - center;
%         theta = sum(v1 .* v2) / (sqrt(sum(v1 .* v1)) * sqrt(sum(v2 .* v2))) + 1.5;
%         theta = theta ^ 3;
%         [xc,yc,zc] = get_arc_coord(center,v(fi,:),v(fj,:));
%         plot3(xc,yc,zc, 'LineWidth',theta);
%     end
% end

% for fi = 7:7
%     for fj = 10:10
%         v1 = v(fi,:) - center;
%         v2 = v(fj,:) - center;
%         theta = sum(v1 .* v2) / (sqrt(sum(v1 .* v1)) * sqrt(sum(v2 .* v2))) + 1.5;
%         if abs(theta - 0.5) < 1e-6
%             continue
%         end
%         theta = theta ^ 3;
%         [xc,yc,zc] = get_arc_coord(center,v(fi,:),v(fj,:));
%         plot3(xc,yc,zc, 'LineWidth',theta);
%     end
% end
% 
% for fi = 7:7
%     for fj = 20:20
%         v1 = v(fi,:) - center;
%         v2 = v(fj,:) - center;
%         theta = sum(v1 .* v2) / (sqrt(sum(v1 .* v1)) * sqrt(sum(v2 .* v2))) + 1.5;
%         theta = theta ^ 3;
%         [xc,yc,zc] = get_arc_coord(center,v(fi,:),v(fj,:));
%         plot3(xc,yc,zc, 'LineWidth',theta);
%     end
% end

% set view point
view(-55,14)