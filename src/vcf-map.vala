/*
 * Copyright 2021 Nahuel Gomez https://nahuelgomez.com.ar
 *
 * SPDX-License-Identifier: LGPL-3.0-or-later
 */

public class Vcf.Map<K,V> : Object, Iterable<MapEntry<K,V>?>, Collection<MapEntry<K,V>?>
{
    private MapEntry<K,V>?[] _data = new MapEntry<K,V>?[5];
    private HashFunc<K> hash_key = Utils.hash_func_for<K> ();

    public uint size { get; private set; default = 0U; }

    public Map () {}

    public Map.from_array (MapEntry<K,V>?[] array)
    {
        foreach (MapEntry<K,V>? entry in array)
            this[entry?.key] = entry?.@value;
    }

    public List<MapEntry<K,V>?> entries ()
    {
        return new List<MapEntry<K,V>?>.from_array (_data[0:size]);
    }

    public new V @get (K key)
    {
        uint hashed_key = hash_key (key);

        foreach (MapEntry<K,V>? entry in _data)
        {
            if (hash_key (entry?.key) == hashed_key)
                return entry?.@value;
        }

        return null;
    }

    public new void @set (K key, V @value)
    {
        uint hashed_key = hash_key (key);

        for (var i = 0U; i < _data.length; i++)
        {
            if (hash_key (_data[i]?.key) == hashed_key)
            {
                _data[i] = { _data[i]?.key, @value };
                return;
            }
        }

        grow_if_needed ();
        _data[size++] = { key, @value };
    }

    private void grow_if_needed ()
    {
        if (size < _data.length - 1)
            return;

        _data.resize (_data.length + 5);
    }

    private Iterator<MapEntry<K,V>?> iterator ()
    {
        return entries ().iterator ();
    }
}

public struct Vcf.MapEntry<K,V>
{
    public K key;
    public V @value;

    public MapEntry (K key, V @value)
    {
        this.key = key;
        this.@value = @value;
    }
}
