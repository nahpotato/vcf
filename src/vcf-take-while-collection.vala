/*
 * Copyright 2021 Nahuel Gomez https://nahuelgomez.com.ar
 *
 * SPDX-License-Identifier: LGPL-3.0-or-later
 */

private class Vcf.TakeWhileCollection<E> : Object, Iterable<E>, Collection<E>
{
    public Iterable<E>? iterable { private get; construct; default = null; }

    public PredicateFuncClosure<E>? closure
    {
        private get; construct; default = null;
    }

    public TakeWhileCollection (Iterable<E> iterable,
                                owned PredicateFunc<E> func)
    {
        Object (iterable: iterable,
            closure: new PredicateFuncClosure<E> ((owned) func));
    }

    private Iterator<E> iterator () requires (iterable != null)
                                    requires (closure != null)
    {
        return new TakeWhileIterator<E> (iterable.iterator (), closure);
    }
}

private class Vcf.TakeWhileIterator<E> : Object, Iterable<E>, Iterator<E>
{
    private bool _taken = false;
    private E _current = null;

    public Iterator<E>? iterator { private get; construct; default = null; }

    public PredicateFuncClosure<E>? closure
    {
        private get; construct; default = null;
    }

    public TakeWhileIterator (Iterator<E> iterator,
                              PredicateFuncClosure<E> closure)
    {
        Object (iterator: iterator, closure: closure);
    }

    private new E @get ()
    {
        return _current;
    }

    private Iterator<E> Iterable.iterator ()
    {
        return this;
    }

    private bool next () requires (iterator != null)
                         requires (closure != null)
    {
        if (!iterator.next ())
            return false;

        if (!_taken && closure.func (iterator.@get ()))
        {
            _current = iterator.@get ();
            return true;
        }

        _taken = true;

        return false;
    }
}
