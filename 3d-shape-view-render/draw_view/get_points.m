function vertices = get_points()
%GET_POINTS Return a 12face's vertex vectors
%   None
phi = (1+sqrt(5))/2;
r = sqrt(3);
vertices = [
        1, 1, 1;
        1, 1, -1;
        1, -1, 1;
        1, -1, -1;
        -1, 1, 1;
        -1, 1, -1;
        -1, -1, 1;
        -1, -1, -1;
        
        0, 1/phi, phi;
        0, 1/phi, -phi;
        0, -1/phi, phi;
        0, -1/phi, -phi;
        
        phi, 0, 1/phi;
        phi, 0, -1/phi;
        -phi, 0, 1/phi;
        -phi, 0, -1/phi;
        
        1/phi, phi, 0;
        -1/phi, phi, 0;
        1/phi, -phi, 0;
        -1/phi, -phi, 0;
        ];
% normalization
vertices = vertices / r;
end

