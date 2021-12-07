# Vcf - Vala Collection Framework

> **Work in Progress**: This library is in active development and it's not yet
> ready to be used in anything that matters. You're warned.

`Vcf` is a new framework for collections in Vala. It aims to provide an useful
set of utilities to work with data collections, either they are stored in
existing structures (such as `GLib.List`), in which case `Vcf` will simply wrap
them; or you want to use the structures provided by it.

As indicated, the current status of the project is WIP, and currently the only
things implemented are: the `Vcf.Iterable` interface, which will allow the
creation of iterable objects with minimum requirements; the `Vcf.Collection`
interface, which will allow the creation of data collection types; the auxiliary
classes for the lazy methods of `Vcf.Collection`; and the initial implementation
of the two most used data collection types: `Vcf.List` and `Vcf.Map`.

## Contributing

If you want to contribute, that's great! At the moment any kind of help is
welcome: from optimization improvements of existing methods, to implementation
of new missing methods, also adding new types of data collections or improving
existing ones.

Note that we are making use of the Allman style (also known as "BSD style") for
indentation, and that it is absolutely necessary to make the type of the
variables explicit if it is not obvious from the right side of the assignment.
The rest should be obvious from the surrounding code.

## Building

The `Vcf` dependencies are minimal, but still worth remembering:

- `glib-2.0` (>= 2.50)
- `gobject-2.0` (>= 2.50)
- `meson`
- `ninja`

To install them, you will need to make use of your distribution's package
manager. A Docker image will be available in the future.

Once you have the dependencies in place, run

```sh
meson build
ninja -C build
```

at the root of this repo, and you're done :)

## License

`Vcf` is distributed under the terms of the GNU Lesser General Public License
3.0.

You can check its details in the `COPYING` and `COPYING.LESSER` files available
in the root of this repository.
