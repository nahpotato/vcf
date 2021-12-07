/*
 * Copyright 2021 Nahuel Gomez https://nahuelgomez.com.ar
 *
 * SPDX-License-Identifier: LGPL-3.0-or-later
 */

public delegate V Vcf.CombineFunc<E,V> (V previous_value, E current_value);
public delegate int Vcf.CompareFunc<E> (E element);
public delegate bool Vcf.EqualFunc<E> (E element, E other);
public delegate Iterable<R> Vcf.FlatFunc<E,R> (E element);
public delegate uint Vcf.HashFunc<E> (E element);
public delegate R Vcf.MapFunc<E,R> (E element);
public delegate E Vcf.OrElseFunc<E> ();
public delegate bool Vcf.PredicateFunc<E> (E element);
public delegate S Vcf.SelectorFunc<E,S> (E element);
public delegate string Vcf.StringifierFunc<E> (E element);
