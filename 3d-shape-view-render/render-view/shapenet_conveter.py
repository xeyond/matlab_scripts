import os
'''
convert shapenet model to standard format
'''

def conver_obj(file_name):
    print('convert', file_name)
    obj_file = open(file_name, 'r')
    lines = obj_file.readlines()
    obj_file.close()
    tag_file = open(file_name, 'w')
    for line in lines:
        if line.startswith('v '):
            tag_file.write(line)
    for line in lines:
        if line.startswith('f '):
            if '/' in line:
                tmp = line.split()
                line = '%s %s %s %s\n' % (
                    tmp[0].split('/')[0], tmp[1].split('/')[0], tmp[2].split('/')[0], tmp[3].split('/')[0])
            tag_file.write(line)
    tag_file.close()

def convert_dir(dir_path):
    print('convert', dir_path)
    for filename in os.listdir(dir_path):
        file_path = os.path.join(dir_path, filename)
        conver_obj(file_path)

def convert_fdir(dir_path):
    for dir_name in os.listdir(dir_path):
        convert_dir(os.path.join(dir_path, dir_name))


def gen_command():
    base_dir = r'E:\shapenet\val'
    dir_names = os.listdir(base_dir)
    dir_names.sort()
    for dir_name in dir_names:
        path_str = os.path.join(base_dir, dir_name)
        path_str = path_str.replace('\\', '\\\\')
        command_str = "my_render_80_views_in_folder('%s')" % path_str
        print(command_str)


# gen_command()
convert_fdir(r'E:\shapenet\train')