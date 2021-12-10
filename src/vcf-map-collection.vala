/*
 * Copyright 2021 Nahuel Gomez https://nahuelgomez.com.ar
 *
 * SPDX-License-Identifier: LGPL-3.0-or-later
 */

private class Vcf.MapCollection<E,R> : Object, Iterable<R>, Collection<R>
{
    public Iterable<E>? iterable { private get; construct; }
    public MapFuncClosure<E,R>? closure { private get; construct; }

    public MapCollection (Iterable<E> iterable, owned MapFunc<E,R> func)
    {
        Object (iterable: iterable,
            closure: new MapFuncClosure<E,R> ((owned) func));
    }

    private Iterator<R> iterator () requires (iterable != null)
                                    requires (closure != null)
    {
        return new MapIterator<E,R> (iterable.iterator (), closure);
    }
}

private class Vcf.MapIterator<E,R> : Object, Iterable<R>, Iterator<R>
{
    private R _current;

    public Iterator<E>? iterator { private get; construct; }
    public MapFuncClosure<E,R>? closure { private get; construct; }

    public MapIterator (Iterator<E> iterator, MapFuncClosure<E,R> closure)
    {
        Object (iterator: iterator, closure: closure);
    }

    private new R @get ()
    {
        return _current;
    }

    private Iterator<R> Iterable.iterator ()
    {
        return this;
    }

    private bool next () requires (iterator != null)
                         requires (closure != null)
    {
        if (!iterator.next ())
            return false;

        _current = closure.func (iterator.@get ());

        return true;
    }
}
