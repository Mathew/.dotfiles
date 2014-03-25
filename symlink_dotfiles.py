"""
Symlinks files in the files_to_link list from the
dotfiles dir to the users home dir
"""
import os
import shutil
import sys

files_to_link = ['gitconfig', 'profile', ]
#get home dir
home_dir = os.path.expanduser('~')
#path where the dotfiles are (assuming the script hasn't been moved)
dotfiles_path = sys.path[0]

for file in files_to_link:
    #for each file, check if it exists, if so do nothing since
    #we don't want to destroy someone's files
    if os.path.exists("{0}/.{1}".format(home_dir, file)):
        print "{0} already exists".format(file)
    else:
        #print message to display link, then link
        print "linking {0}/.{1} to {3}/{1}".format(home_dir, file, dotfiles_path)
        os.symlink(
            "{0}/{1}".format(dotfiles_path, file),
            "{0}/.{1}".format(home_dir, file)
        )

