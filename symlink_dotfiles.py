import os, sys

files_to_link = ['gitconfig', 'profile', 'vimrc', 'vim']
home_dir = os.path.expanduser('~')
dotfiles_path = sys.path[0]

for file in files_to_link:
    if os.path.exists(home_dir+'/.'+file):
        print '%s already exists' % file
    else:
        print 'linking %s/.%s to %s/%s' % (home_dir,
            file, dotfiles_path, file) 
        os.symlink('%s/%s' % (dotfiles_path, file),
            '%s/.%s' % (home_dir, file))
