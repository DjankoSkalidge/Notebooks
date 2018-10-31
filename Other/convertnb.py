import argparse
import os
import sys
import nbformat

# parse the options and arguments of the script
parser = argparse.ArgumentParser(description='This script converts a Jupyter notebook into a Python program.')

parser.add_argument('filename', help='File with Jupyter notebook')
parser.add_argument('-d',metavar="directory", help='The target directory (optional)')
parser.add_argument('-silent', action="store_true", default=False, help='No print statements')

args = parser.parse_args()
silent = args.silent
fullfilename = args.filename

# find the file names and paths
spath, filename = os.path.split(fullfilename)
fname, ext = os.path.splitext(filename)

if not ext in [".ipynb", ""]:
	print("extension {} not supported.".format(ext))
	sys.exit()

nbname = fname+".ipynb"
pyname = fname+".py"

dpath = spath
if not (args.d is None):
	dpath = args.d
	if not os.path.isdir(dpath):
		print("{} is not a directory.".format(dpath) )
		sys.exit()

sourcefilename = os.path.join(spath, nbname)
pythonfilename = os.path.join(dpath, pyname)

if not silent:
	print("converting notebook '{}' into '{}'".format(sourcefilename, pythonfilename))

# check whether the jupyter notebook exists.
if not os.path.isfile(sourcefilename):
	print("{} is not a file.".format(sourcefilename) )
	sys.exit()

# read the notebook
nb = nbformat.read(sourcefilename, as_version=4)

# currently only python notebooks are supported
kernellanguage = nb["metadata"]["kernelspec"]["language"]
if kernellanguage != "python":
	print("{} notebooks are not supported.".format(kernellanguage))
	sys.exit()

# generate the python file
pythonfile = open(pythonfilename, 'w')

code = [cell["source"] for cell in nb["cells"] if cell["cell_type"]=="code"]
pythonfile.write("\n\n".join(code))

pythonfile.close()
