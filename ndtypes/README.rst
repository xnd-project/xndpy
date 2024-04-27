Overview
--------

The ``ndtypes`` module is the Python interface to the ``libndtypes`` library.
``libndtypes`` implements dynamic types relevant for scientific computing.

These types contain full memory layout information and are used both for type
checking and  accessing values in memory.

Types are specified using a close variant of the datashape language.

``ndtypes`` supports other container modules.  It displays types, performs
type checking, and the concrete type layout information is used to traverse
memory.

As an example, ``xnd`` is a container module that is based on ``ndtypes``.

Links
-----

* https://github.com/xnd-project/
