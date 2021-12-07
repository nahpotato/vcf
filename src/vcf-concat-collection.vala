/*
 * Copyright 2021 Nahuel Gomez https://nahuelgomez.com.ar
 *
 * SPDX-License-Identifier: LGPL-3.0-or-later
 */

private class Vcf.ConcatCollection<E> : Object, Iterable<E>, Collection<E>
{
    public Iterable<E>? iterable1 { private get; construct; default = null; }
    public Iterable<E>? iterable2 { private get; construct; default = null; }

    public ConcatCollection (Iterable<E> iterable1, Iterable<E> iterable2)
    {
        Object (iterable1: iterable1, iterable2: iterable2);
    }

    private Iterator<E> iterator () requires (iterable1 != null)
                                    requires (iterable2 != null)
    {
        return new ConcatIterator<E> (iterable1.iterator (),
            iterable2.iterator ());
    }
}

private class Vcf.ConcatIterator<E> : Object, Iterable<E>, Iterator<E>
{
    private Iterator<E>? _current_it = null;
    private E _current = null;

    public Iterator<E>? iterator1 { private get; construct; default = null; }
    public Iterator<E>? iterator2 { private get; construct; default = null; }

    public ConcatIterator (Iterator<E> iterator1, Iterator<E> iterator2)
    {
        Object (iterator1: iterator1, iterator2: iterator2);
    }

    private new E @get ()
    {
        return _current;
    }

    private Iterator<E> iterator ()
    {
        return this;
    }

    private bool next () requires (iterator1 != null)
                         requires (iterator2 != null)
    {
        if (_current_it == null)
            _current_it = iterator1;

        if (!_current_it.next ())
        {
            if (_current_it == iterator2)
                return false;

            _current_it = iterator2;
        }

        _current = _current_it.@get ();

        return true;
    }
}
