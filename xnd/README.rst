Overview
--------

The ``xnd`` module implements a container type that maps most Python values
relevant for scientific computing directly to typed memory.

Whenever possible, a single, pointer-free memory block is used.

``xnd`` supports ragged arrays, categorical types, indexing, slicing, aligned
memory blocks and type inference.

Operations like indexing and slicing return zero-copy typed views on the data.

Importing PEP-3118 buffers is supported.

Links
-----

* https://github.com/xnd-project/
