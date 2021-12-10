/*
 * Copyright 2021 Nahuel Gomez https://nahuelgomez.com.ar
 *
 * SPDX-License-Identifier: LGPL-3.0-or-later
 */

private class Vcf.SkipCollection<E> : Object, Iterable<E>, Collection<E>
{
    public Iterable<E>? iterable { private get; construct; }
    public uint amount { private get; construct; }

    public SkipCollection (Iterable<E> iterable, uint amount)
    {
        Object (iterable: iterable, amount: amount);
    }

    private Iterator<E> iterator () requires (iterable != null)
    {
        return new SkipIterator<E> (iterable.iterator (), amount);
    }
}

private class Vcf.SkipIterator<E> : Object, Iterable<E>, Iterator<E>
{
    private uint _count;
    private E _current;

    public Iterator<E>? iterator { private get; construct; }
    public uint amount { private get; construct; }

    public SkipIterator (Iterator<E> iterator, uint amount)
    {
        Object (iterator: iterator, amount: amount);
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
    {
        do
            if (!iterator.next ()) return false;
        while (_count++ < amount);

        _current = iterator.@get ();

        return true;
    }
}
