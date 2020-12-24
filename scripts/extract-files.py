#!/bin/python3
import glob
import gzip
import os
import os.path
import re
import shutil
import subprocess
import sys
import tempfile
import zipfile


def filtered_lines(lines):
    # Remove comments, line breaks, and empty lines
    return list(filter(
        lambda s: len(s),                # remove empty lines
        (re.sub('#.*', '', line).strip() # remove comments and line breaks
         for line in lines)))


def unpack_bootimage(path):
    dir = os.path.split(path)[0]
    print(dir)
    
    # Unpack bootimg.cfg initrd.img zImage
    print('Unpacking boot.img')
    subprocess.run(('abootimg', '-x', 'boot.img'), cwd=dir, check=True)

    # Extract initrd.img to root directory
    print('Unpacking ramdisk')
    os.makedirs(f'{dir}/root', exist_ok=True)
    with gzip.GzipFile(f'{dir}/initrd.img', 'r') as f:
        subprocess.run(('cpio', '-id', '--quiet', '-D', 'root'),
                       input=f.read(), cwd=dir, check=True)


if __name__ == '__main__':
    # Check command line
    if len(sys.argv) != 4:
        print('Expected 3 arguments but got {}'.format(len(sys.argv)-1))
        print(f'Usage: {sys.argv[0]} <list-of-filenames.txt> <firmware.zip> <destination dir>')
        sys.exit(1)

    filenames_path = sys.argv[1]
    firmware_path = sys.argv[2]
    destination_dir = sys.argv[3]

    # Check if input files exist

    for path in (filenames_path, firmware_path):
        if not os.path.exists(path):
            print(f'File "{path}" does not exist')
            sys.exit(1)

    # Read the list of relative paths
    
    with open(filenames_path, 'r') as f:
        print(f'Reading {filenames_path}')
        relative_paths = filtered_lines(f.readlines())

    # Extract the firmware
    
    with tempfile.TemporaryDirectory(dir='.') as temp_dir:
        with zipfile.ZipFile(firmware_path, mode='r') as myzip:
            # Extract everything from the zip file
            
            print(f'Extracting {firmware_path} to {temp_dir}')
            myzip.extractall(path=temp_dir)

            # Unpack the bootimage
            
            print('Unpacking bootimage')
            unpack_bootimage(f'{temp_dir}/boot.img')

            # Copy the kernel to destination dir

            src_path = f'{temp_dir}/zImage'
            dst_path = f'{destination_dir}/kernel'
            shutil.copyfile(src_path, dst_path)
            print(f'Extracted kernel to {dst_path}')

            # Copy files from temp dir to destination dir

            os.makedirs(destination_dir, exist_ok=True)
            for relative_path in relative_paths:
                src_path = os.path.normpath(f'{temp_dir}/{relative_path}')
                dst_path = os.path.normpath(f'{destination_dir}/{relative_path}')

                # Create directories if neccessary
                dst_dir = os.path.split(dst_path)[0]
                if not os.path.exists(dst_dir):
                    os.makedirs(dst_dir)
                    
                shutil.copyfile(src_path, dst_path)
                
            print('Extracted {} files to {}'.format(len(relative_paths), destination_dir))

            # Create vendor makefile

            makefile_path = f'{destination_dir}/BoardConfigVendor.mk'
            with open(makefile_path, 'w') as f:
                print(f'Creating makefile {makefile_path}')
                f.write('PRODUCT_COPY_FILES +=')
                for relative_path in relative_paths:
                    src_path = os.path.normpath(f'vendor/quanta/fg6q/{relative_path}')
                    if relative_path.startswith('/'):
                        dst_path = relative_path[1:]
                    else:
                        dst_path = relative_path
                    f.write(f' \\\n    {src_path}:{dst_path}')

