#!/bin/python3

import os.path
import re
import subprocess
import sys

# Finds all executables and libraries in a directory and checks if all
# direct dependencies can be found in that path.

if __name__ == '__main__':
    if len(sys.argv) != 2:
        print('Expected 1 argument but got {}'.format(len(sys.argv)-1))
        print(f'Usage: {sys.argv[0]} <directory>')

    directory = sys.argv[1]

    # Find all files

    print('Finding all files')
    paths = subprocess.run(('find', directory, '-type', 'f'),
                           capture_output=True, text=True).stdout.split()
    paths = set(paths)

    # Find executables by checking the output of the 'file' command

    print('Filtering executables')
    non_executable = set()
    for path in paths:
        result = subprocess.run(('file', path),
                                capture_output=True, text=True).stdout
        if not re.search('LSB (?:executable)|(?:shared object)', result):
            non_executable.add(path)
    paths = paths - non_executable

    print('Found {} executables'.format(len(paths)))

    # Create list of unique filenames
    
    filenames = set()
    duplicates = set()
    for path in paths:
        filename = os.path.split(path)[1]
        if filename in filenames:
            duplicates.add(filename)
        else:
            filenames.add(filename)

    # Print duplicate filenames
    
    if duplicates:
        print('Found {} unique filenames'.format(len(filenames)))
        print('Found {} duplicate filenames'.format(len(duplicates)))
        for filename in duplicates:
            for path in paths:
                if os.path.split(path)[1] in duplicates:
                    print(path)
            print('')

    # Find dependencies of all found executables

    print('Checking dependencies')
    all_missing = set()
    for path in paths:
        output = subprocess.run(('objdump', '-p', path),
                                capture_output=True, text=True).stdout
        dependencies = re.findall('NEEDED\s+(\S+)', output)
        missing = [d for d in dependencies if d not in filenames]
        if missing:            
            print('Missing dependencies in {path}:\n{missing}\n'.format(
                path=path,
                missing=' '.join(sorted(missing))))
            all_missing.update(set(missing))

    # Summarize what is missing
    
    if all_missing:
        print('Missing dependencies found:\n{missing}'.format(
            missing=' '.join(sorted(all_missing))))
    else:
        print('No missing dependencies found')

