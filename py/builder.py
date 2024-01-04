#!/usr/bin/python
import os
os.chdir("..")
print(os.path.abspath(os.curdir))
cmd = "puro dart run build_runner build --delete-conflicting-outputs"
os.system(cmd)
input("Press Enter to continue...")