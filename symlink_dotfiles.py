"""
Symlinks files in the files_to_link list from the
dotfiles dir to the users home dir
"""
import os
import shutil
import sys

files_to_link = ['gitconfig', 'profile', 'vimrc', 'vim']
#get home dir
home_dir = os.path.expanduser('~')
#path where the dotfiles are (assuming the script hasn't been moved)
dotfiles_path = sys.path[0]

for file in files_to_link:
    #for each file, check if it exists, if so do nothing since
    #we don't want to destroy someone's files
    if os.path.exists(home_dir + '/.' + file):
        print '%s already exists' % file
    else:
        #print message to display link, then link
        print 'linking %s/.%s to %s/%s' % (home_dir,
            file, dotfiles_path, file)
        os.symlink('%s/%s' % (dotfiles_path, file),
            '%s/.%s' % (home_dir, file))

# sublime text setting sit in it's own directory so we'll do this
# seperately
sublime_path = '{0}/Library/Application Support/Sublime Text 2/Packages/User'.format(home_dir)

#delete then copy, st2 doesn't work with a symlink
try:
    shutil.rmtree(sublime_path)
except OSError, e:
    print e
shutil.copytree("{0}/{1}".format(dotfiles_path, 'sublime_settings'),
    sublime_path)
