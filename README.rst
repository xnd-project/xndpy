

xndpy
=====

xndpy is intended for packaging the Python bindings for xnd. The authoritative
sources for the Python modules are in the xnd repository, where they are built
for testing libndtypes, libxnd and libgumath.


usage
=====

To build all packages, execute the following commands:

python3 -m pip install build

cd xndlib
git clone https://github.com/xnd-project/xnd source/xnd
python3 -m build .

cd ../ndtypes
git clone https://github.com/xnd-project/xnd source/xnd
python3 -m build .

cd ../xnd
git clone https://github.com/xnd-project/xnd source/xnd
python3 -m build .

cd ../gumath
git clone https://github.com/xnd-project/xnd source/xnd
python3 -m build .
