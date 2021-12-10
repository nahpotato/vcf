/*
 * Copyright 2021 Nahuel Gomez https://nahuelgomez.com.ar
 *
 * SPDX-License-Identifier: LGPL-3.0-or-later
 */

private class Vcf.WhereCollection<E> : Object, Iterable<E>, Collection<E>
{
    public Iterable<E>? iterable { private get; construct; }
    public PredicateFuncClosure<E>? closure { private get; construct; }

    public WhereCollection (Iterable<E> iterable, owned PredicateFunc<E> func)
    {
        Object (iterable: iterable,
            closure: new PredicateFuncClosure<E> ((owned) func));
    }

    private Iterator<E> iterator () requires (iterable != null)
                                    requires (closure != null)
    {
        return new WhereIterator<E> (iterable.iterator (), closure);
    }
}

private class Vcf.WhereIterator<E> : Object, Iterable<E>, Iterator<E>
{
    private E _current;

    public Iterator<E>? iterator { private get; construct; }
    public PredicateFuncClosure<E>? closure { private get; construct; }

    public WhereIterator (Iterator<E> iterator, PredicateFuncClosure<E> closure)
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
        do
        {
            if (!iterator.next ())
                return false;
        } while (!closure.func (iterator.@get ()));

        _current = iterator.@get ();

        return true;
    }
}
