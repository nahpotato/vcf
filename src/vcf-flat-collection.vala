/*
 * Copyright 2021 Nahuel Gomez https://nahuelgomez.com.ar
 *
 * SPDX-License-Identifier: LGPL-3.0-or-later
 */

private class Vcf.FlatCollection<E,R> : Object, Iterable<R>, Collection<R>
{
    public Iterable<E>? iterable { private get; construct; default = null; }

    public FlatFuncClosure<E,R>? closure
    {
        private get; construct; default = null;
    }

    public FlatCollection (Iterable<E> iterable, owned FlatFunc<E,R> func)
    {
        Object (iterable: iterable,
            closure: new FlatFuncClosure<E,R> ((owned) func));
    }

    private Iterator<R> iterator () requires (iterable != null)
                                    requires (closure != null)
    {
        return new FlatIterator<E,R> (iterable.iterator (), closure);
    }
}

private class Vcf.FlatIterator<E,R> : Object, Iterable<R>, Iterator<R>
{
    private Iterator<R>? _current_it = null;
    private R _current = null;

    public Iterator<E>? iterator { private get; construct; default = null; }

    public FlatFuncClosure<E,R>? closure
    {
        private get; construct; default = null;
    }

    public FlatIterator (Iterator<E> iterator, FlatFuncClosure<E,R> closure)
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
        while ((_current_it == null) || (!_current_it.next ()))
        {
            if (!iterator.next ())
                return false;

            Iterable<R> iterable = closure.func (iterator.@get ());
            _current_it = iterable.iterator ();
        }

        _current = _current_it.@get ();

        return true;
    }
}
