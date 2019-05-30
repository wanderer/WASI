Weak Imports
============

It can be useful for WASI programs to weakly depend certain functions in a WASI
API.  For example, if a WASI API evolves to include a new function a program
might want to continue to run on older system that don't yet support the new
function.  In this case a weak import mechanism allows the program to run on
older systems and detect the presence of the function at runtime.

WebAssembly itself does not currently provide a mechanism for weak imports.
There is some discussion of adding it the spec [^1], and WASI would
likely use such a feature if/when it is added.

This document describes the mechanism used by WASI to achieve a form a weak
import on top of the existing primitives.  Currently this is only defined for
function imports.

Declaring a weak function import
--------------------------------

Weak function imports are implemened by using two imports for each function.
The first being the weak function and the second being a WebAssembly i32 global
to indicate if the function is present at runtime.

For example, if a module called `wasi:fs` added a new `statvfs` function to it
interface a program could import this new function weakly in the following way:

```wasm
(func $statvfs (import "wasi:fs" "statvfs.weak"))
(global $statvfs_is_present (import "wasm:fs" "statvfs.is_present") i32)
```

On older systems that don't support the new function `$statvfs_is_present` would
be set to zero and calling `$statvfs` would result in a trap.

On system that do support the new function `$statvfs_is_present` is set to
non-zero and calling `$statvfs` would work as expected.

Using a weak function import
----------------------------

In order to use the above weak function import its presence should first be
tested for.  In C code this would looks something like this:

```c
if (wasm_fs.statvfs) {
  wasm_fs.statvfs(...)
}
```

At the WebAssembly level might look like this:

```wasm
global.get $statvfs_is_present
if i32
  call $statvfs
end
```

[^1]: https://github.com/WebAssembly/design/issues/1281
