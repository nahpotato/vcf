/*
 * Copyright 2021 Nahuel Gomez https://nahuelgomez.com.ar
 *
 * SPDX-License-Identifier: LGPL-3.0-or-later
 */

[GenericAccessors]
public interface Vcf.Collection<E> : Object, Iterable<E>
{
    public virtual Type element_type
    {
        get { return typeof (E); }
    }

    public virtual bool is_empty
    {
        get
        {
            var it = iterator ();
            return !it.next ();
        }
    }

    public virtual bool any (PredicateFunc<E> predicate)
    {
        foreach (var element in this)
        {
            if (predicate (element))
                return true;
        }

        return false;
    }

    public virtual E at (int index)
    {
        uint real_idx = index >= 0 ? index : count () + index;

        var current_idx = 0U;
        foreach (E element in this)
        {
            if (current_idx++ == real_idx)
                return element;
        }

        critical ("The given index is out of bounds of the collection");

        return null;
    }

    public virtual Collection<E> concat (Iterable<E> other)
    {
        return new ConcatCollection<E> (this, other);
    }

    public virtual bool contains (E element)
    {
        EqualFunc<E> equal = Utils.equal_func_for<E> ();
        return any (e => equal (e, element));
    }

    public virtual uint count ()
    {
        return fold<uint> (0, size => size + 1);
    }

    public virtual List<E> distinct ()
    {
        return fold<List<E>> (new List<E> (), (list, element) =>
        {
            if (!(element in list))
                list.add (element);

            return list;
        });
    }

    public virtual bool every (PredicateFunc<E> predicate)
    {
        foreach (E element in this)
        {
            if (!predicate (element))
                return false;
        }

        return true;
    }

    public virtual E first ()
    {
        Iterator<E> it = iterator ();

        if (!it.next ())
        {
            critical ("The collection has no elements");
            return null;
        }

        return it.@get ();
    }

    public virtual E first_where (PredicateFunc<E> predicate,
                                  OrElseFunc<E>? or_else = null)
    {
        Iterator<E> it = iterator ();

        if (!it.next ())
        {
            critical ("The collection has no elements");
            return null;
        }

        do
        {
            var element = it.@get ();

            if (predicate (element))
                return element;
        } while (it.next ());

        if (or_else != null)
            return or_else ();

        critical ("No element matches the given predicate");

        return null;
    }

    public virtual Collection<R> flat<R> (owned FlatFunc<E,R> func)
    {
        return new FlatCollection<E,R> (this, (owned) func);
    }

    public virtual V fold<V> (V initial, CombineFunc<E,V> combine)
    {
        V current = initial;

        foreach (E element in this)
            current = combine (current, element);

        return current;
    }

    public virtual Map<K,List<E>> group<K> (SelectorFunc<E,K> key_selector)
    {
        return fold<Map<K,List<E>>> (new Map<K,List<E>> (), (map, element) =>
        {
            K key = key_selector (element);

            if (map[key] == null)
                map[key] = new List<E> ();

            map[key].add (element);

            return map;
        });
    }

    public virtual string join (string separator = "")
    {
        StringifierFunc<E> stringify = Utils.stringifier_func_for<E> ();

        return fold<string> ("", (str, element) =>
        {
            if (str == "")
                return stringify (element);

            return str + separator + stringify (element);
        });
    }

    public virtual E last ()
    {
        Iterator<E> it = iterator ();

        if (!it.next ())
        {
            critical ("The collection has no elements");
            return null;
        }

        E result = null;

        do
            result = it.@get ();
        while (it.next ());

        return result;
    }

    public virtual E last_where (PredicateFunc<E> predicate,
                                 OrElseFunc<E>? or_else = null)
    {
        Iterator<E> it = iterator ();

        if (!it.next ())
        {
            critical ("The collection has no elements");
            return null;
        }

        E result = null;
        var is_found = false;

        do
        {
            E element = it.@get ();

            if (predicate (element))
            {
                result = element;
                is_found = true;
            }
        } while (it.next ());

        if (is_found)
            return result;

        if (or_else != null)
            return or_else ();

        critical ("No element matches the given predicate");

        return null;
    }

    public virtual Collection<R> map<R> (owned MapFunc<E,R> func)
    {
        return new MapCollection<E,R> (this, (owned) func);
    }

    public virtual bool none (PredicateFunc<E> predicate)
    {
        foreach (E element in this)
        {
            if (predicate (element))
                return false;
        }

        return true;
    }

    public virtual E reduce (CombineFunc<E,E> func)
    {
        Iterator<E> it = iterator ();

        if (!it.next ())
        {
            critical ("The collection has no elements");
            return null;
        }

        E current = it.@get ();

        while (it.next ())
            current = func (current, it.@get ());

        return current;
    }

    public virtual List<E> reverse ()
    {
        return fold<List<E>> (new List<E> (), (list, element) =>
        {
            list.prepend (element);
            return list;
        });
    }

    public virtual E single ()
    {
        Iterator<E> it = iterator ();

        if (!it.next ())
        {
            critical ("The collection has no elements");
            return null;
        }

        E result = it.@get ();

        if (it.next ())
        {
            critical ("The collection has more than one element");
            return null;
        }

        return result;
    }

    public virtual E single_where (PredicateFunc<E> predicate,
                                   OrElseFunc<E>? or_else = null)
    {
        Iterator<E> it = iterator ();

        if (!it.next ())
        {
            critical ("The collection has no elements");
            return null;
        }

        E result = null;
        var is_found = false;

        do
        {
            var element = it.@get ();

            if (predicate (element))
            {
                if (is_found)
                {
                    critical ("More than one element matches the given predicate");
                    return null;
                }

                result = element;
                is_found = true;
            }
        } while (it.next ());

        if (is_found)
            return result;

        if (or_else != null)
            return or_else ();

        critical ("No element matches the given predicate");

        return null;
    }

    public virtual Collection<E> skip (uint amount)
    {
        return new SkipCollection<E> (this, amount);
    }

    public virtual Collection<E> skip_while (owned PredicateFunc<E> predicate)
    {
        return new SkipWhileCollection<E> (this, (owned) predicate);
    }

    public virtual Collection<E> take (uint amount)
    {
        return new TakeCollection<E> (this, amount);
    }

    public virtual Collection<E> take_while (owned PredicateFunc<E> predicate)
    {
        return new TakeWhileCollection<E> (this, (owned) predicate);
    }

    public virtual List<E> to_list ()
    {
        return new List<E>.from_iterable (this);
    }

    public virtual Map<K,E> to_map<K> (SelectorFunc<E,K> key_selector)
    {
        var result = new Map<K,E> ();

        foreach (E element in this)
            result[key_selector (element)] = element;

        return result;
    }

    public virtual Collection<E> where (owned PredicateFunc<E> predicate)
    {
        return new WhereCollection<E> (this, (owned) predicate);
    }
}
