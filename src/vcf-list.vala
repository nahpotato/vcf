/*
 * Copyright 2021 Nahuel Gomez https://nahuelgomez.com.ar
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

public class Vcf.List<E> : Object, Iterable<E>, Collection<E>, Equatable<List<E>>, Stringifiable, Hashable
{
    private E[] _data = new E[5];

    public uint size { get; private set; }

    public List () {}

    public List.from_array (E[] array)
    {
        _data = array;
        size = array.length;
    }

    public List.from_iterable (Iterable<E> iterable)
    {
        if (iterable is List)
        {
            var list = (List<E>) iterable;

            this.from_array (list._data[0:list.size]);

            return;
        }

        foreach (E element in iterable)
            add (element);
    }

    public void add (E element)
    {
        grow_if_needed ();
        _data[size++] = element;
    }

    public void clear ()
    {
        _data = new E[5];
        size = 0;
    }

    public bool equal (List<E> other)
    {
        if (size != other.size)
            return false;

        EqualFunc<E> equal = Utils.equal_func_for<E> ();

        for (var i = 0U; i < size; i++)
        {
            if (!equal (this[i], other[i]))
                return false;
        }

        return true;
    }

    public new E @get (uint index)
    {
        if (index >= size)
        {
            critical ("The given index is out of bounds of the list");
            return null;
        }

        return _data[index];
    }

    public uint hash ()
    {
        var hash = Utils.hash_func_for<E> ();
        var h = size;

        foreach (E element in _data)
            h ^= hash (element);

        return h;
    }

    public void insert (uint index, E element)
    {
        grow_if_needed ();
        shift_from (index);

        _data[index] = element;

        size++;
    }

    public void prepend (E element)
    {
        insert (0, element);
    }

    public new void @set (uint index, E element)
    {
        if (index >= size)
        {
            critical ("The given index is out of bounds of the list");
            return;
        }

        _data[index] = element;
    }

    public List<E> slice (uint start, uint end)
    {
        return new List<E>.from_array (_data[start:end]);
    }

    public string to_string ()
    {
        return "[" + join (", ") + "]";
    }

    private void grow_if_needed ()
    {
        if (size < _data.length - 1)
            return;

        _data.resize (_data.length + 5);
    }

    private Iterator<E> iterator ()
    {
        return new ListIterator<E> (this);
    }

    private void shift_from (uint index)
    {
        for (var i = size; i >= size; i--)
            _data[i + 1] = _data[i];
    }
}

private class Vcf.ListIterator<E> : Object, Iterable<E>, Iterator<E>
{
    private bool _initialized = false;
    private uint _current_idx = 0U;
    private E _current = null;

    public List<E>? list { private get; construct; default = null; }

    public ListIterator (List<E> list)
    {
        Object (list: list);
    }

    private new E @get ()
    {
        return _current;
    }

    private Iterator<E> iterator ()
    {
        return this;
    }

    private bool next () requires (list != null)
    {
        if (_initialized)
            _current_idx++;

        _initialized = true;

        if (_current_idx >= list.size)
        {
            _current = null;
            return false;
        }

        _current = list[_current_idx];

        return true;
    }
}
