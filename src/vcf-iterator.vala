/*
 * Copyright 2021 Nahuel Gomez https://nahuelgomez.com.ar
 *
 * SPDX-License-Identifier: LGPL-3.0-or-later
 */

[GenericAccessors]
public interface Vcf.Iterator<T> : Object, Iterable<T>
{
    public abstract bool next ();
    public abstract T @get ();
}
