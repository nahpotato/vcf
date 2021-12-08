/*
 * Copyright 2021 Nahuel Gomez https://nahuelgomez.com.ar
 *
 * SPDX-License-Identifier: LGPL-3.0-or-later
 */

private class Vcf.TakeCollection<E> : Object, Iterable<E>, Collection<E>
{
    public Iterable<E>? iterable { private get; construct; default = null; }
    public uint amount { private get; construct; default = 0U; }

    public TakeCollection (Iterable<E> iterable, uint amount)
    {
        Object (iterable: iterable, amount: amount);
    }

    private Iterator<E> iterator () requires (iterable != null)
    {
        return new TakeIterator<E> (iterable.iterator (), amount);
    }
}

private class Vcf.TakeIterator<E> : Object, Iterable<E>, Iterator<E>
{
    private uint _count = 0U;
    private E _current = null;

    public Iterator<E>? iterator { private get; construct; default = null; }
    public uint amount { private get; construct; default = 0U; }

    public TakeIterator (Iterator<E> iterator, uint amount)
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
        if (_count++ < amount && iterator.next ())
        {
            _current = iterator.@get ();
            return true;
        }

        return false;
    }
}
