function ims = my_render_views_2( mesh, fig )
%RENDER_VIEWS render a 3d shape from multiple views
%   mesh::
%       a mesh object containing fileds
%           .F 3 x #faces (1-based indexing)
%           .V 3 x #vertices
%       OR a path to .off file
%   `az`:: (default) [0:30:330]
%       horizontal viewing angles, use this setting for shapes that are
%       upright oriented according to +Z axis!
%   `el`:: (default) 30
%       vertical elevation, , use this setting for shapes that are
%       upright oriented according to +Z axis!
%   `use_dodecahedron_views`:: (default) false
%       ignores az, el -  places cameras on the vertices of a unit
%       dodecahedron, rotates them, and produces 80 views.
%       use this setting for shapes that are not upright oriented.
%   `colorMode`:: (default)  'rgb'
%       color mode of output images ('rgb' or 'gray')
%   `outputSize`::  (default)  224
%       output image size (both dimensions)
%   `minMargin`:: (default)  0.1
%       minimun margin ratio in output images
%   `maxArea`:: (default)  0.3
%       maximun area ratio in output images
%   `figHandle`:: (default) []
%       handle to existing figure

opts.az = 0;
opts.el = [90, -90];
opts.use_dodecahedron_views = true;
opts.colorMode = 'rgb';
opts.outputSize = 224;
opts.minMargin = 0.1;
opts.maxArea = 0.3;
opts.figHandle = fig;

if isempty(opts.figHandle)
    opts.figHandle = figure;
end

if ischar(mesh)
    if strcmpi(mesh(end-2:end),'off') || strcmpi(mesh(end-2:end),'obj')
        mesh = loadMesh(mesh);
    else
        error('file type (.%s) not supported.',mesh(end-2:end));
    end
end

ims = cell(1,length(opts.az) * length(opts.el));

for i=1:length(opts.el)
        plotMesh(mesh,'solid',opts.az,opts.el(i));
        ims{i} = print('-RGBImage', '-r100');  %in case of an error,you have an old matlab version: comment this line and uncomment the following 2 ones
        %saveas(opts.figHandle, '__temp__.png');
        %ims{i} = imread('__temp__.png');
        if strcmpi(opts.colorMode,'gray'), ims{i} = rgb2gray(ims{i}); end
        ims{i} = resize_im(ims{i}, opts.outputSize, opts.minMargin, opts.maxArea);
end
%delete('__temp__.png');

end




function im = resize_im(im,outputSize,minMargin,maxArea)

max_len = outputSize * (1-minMargin);
max_area = outputSize^2 * maxArea;

nCh = size(im,3);
mask = ~im2bw(im,1-1e-10); %#ok<IM2BW>
mask = imfill(mask,'holes');
% blank image (all white) is outputed if not object is observed
if isempty(find(mask, 1))
    im = uint8(255*ones(outputSize,outputSize,nCh));
    return;
end
[ys,xs] = ind2sub(size(mask),find(mask));
y_min = min(ys); y_max = max(ys); h = y_max - y_min + 1;
x_min = min(xs); x_max = max(xs); w = x_max - x_min + 1;
scale = min(max_len/max(h,w), sqrt(max_area/sum(mask(:))));
patch = imresize(im(y_min:y_max,x_min:x_max,:),scale);
[h,w,~] = size(patch);
im = uint8(255*ones(outputSize,outputSize,nCh));
loc_start = floor((outputSize-[h w])/2);
im(loc_start(1)+(0:h-1),loc_start(2)+(0:w-1),:) = patch;

end
