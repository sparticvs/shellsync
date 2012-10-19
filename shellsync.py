"""
Author: sparticvs
Description: Setups symlinks for shell scripts
License: Public Domain
"""
import sys
import os
import argparse

# Disabling to keep from junk building up
sys.dont_write_bytecode = True

FILES = "files"

if __name__ == "__main__":
    confs = os.listdir(FILES)
    for conf in confs:
        src = os.path.join(os.getcwd(), FILES, conf)
        dest = os.path.join(os.environ["HOME"], conf)
        backup = "%s~" % dest
        do_backup = os.path.isdir(dest) or os.path.isfile(dest)

        if not os.path.islink(dest):
            if do_backup:
                try:
                    os.rename(dest, backup)
                except OSError:
                    # Unexpected really...
                    backup = "%s~" % backup
                    os.rename(dest, backup)
            print("[+] Creating Link for %s" % conf)
            os.symlink(src, dest)

    print("[@] Comppleted")
