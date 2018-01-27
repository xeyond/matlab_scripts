function my_render_20_views_in_folder(src_folder)
mesh_filenames = [rdir( sprintf('%s\\*.obj', src_folder) ); rdir( sprintf('%s\\*.off', src_folder) )];
fig = figure('Visible','off');
range = 1:length(mesh_filenames);
ext = '.jpg';
for fi = range
   fprintf('Loading and rendering input shape %s...', mesh_filenames(fi).name );
   view_20_name = strsplit(mesh_filenames(fi).name, '.');
   vier_20_name = [view_20_name{1},'_020.jpg']
   
   if exist(vier_20_name, 'file') == 2
       continue
   end
   mesh = loadMesh( mesh_filenames(fi).name );
    if isempty(mesh.F)
        error('Could not load mesh from file');
    else
        fprintf('Done.\n');
    end
    ims = my_render_views_20(mesh,fig);
    for ij=1:length(ims)
        file_path =  sprintf('%s_%03d%s',mesh_filenames(fi).name(1:end-4), ij, ext);
        imwrite( ims{ij}, file_path);
    end
end

end