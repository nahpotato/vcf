/*
 * Copyright 2021 Nahuel Gomez https://nahuelgomez.com.ar
 *
 * SPDX-License-Identifier: LGPL-3.0-or-later
 */

[GenericAccessors]
public interface Vcf.Iterable<T> : Object
{
    public abstract Iterator<T> iterator ();
}
