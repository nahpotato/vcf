/*
 * Copyright 2021 Nahuel Gomez https://nahuelgomez.com.ar
 *
 * SPDX-License-Identifier: LGPL-3.0-or-later
 */

[Compact (opaque = true)]
[CCode (ref_function = "vcf_flat_func_closure_ref", unref_function = "vcf_flat_func_closure_unref")]
private class Vcf.FlatFuncClosure<E,R>
{
    private uint _ref_count = 1;

    public FlatFunc<E,R> func { get; private owned set; }

    public FlatFuncClosure (owned FlatFunc<E,R> func)
    {
        this.func = (owned) func;
    }

    public unowned FlatFuncClosure<E,R> @ref () requires (_ref_count > 0)
    {
        AtomicUint.inc (ref _ref_count);
        return this;
    }

    public void unref () requires (_ref_count > 0)
    {
        if (AtomicUint.dec_and_test (ref _ref_count))
            free ();
    }

    private extern void free ();
}

[Compact (opaque = true)]
[CCode (ref_function = "vcf_map_func_closure_ref", unref_function = "vcf_map_func_closure_unref")]
private class Vcf.MapFuncClosure<E,R>
{
    private uint _ref_count = 1;

    public MapFunc<E,R> func { get; private owned set; }

    public MapFuncClosure (owned MapFunc<E,R> func)
    {
        this.func = (owned) func;
    }

    public unowned MapFuncClosure<E,R> @ref () requires (_ref_count > 0)
    {
        AtomicUint.inc (ref _ref_count);
        return this;
    }

    public void unref () requires (_ref_count > 0)
    {
        if (AtomicUint.dec_and_test (ref _ref_count))
            free ();
    }

    private extern void free ();
}

[Compact (opaque = true)]
[CCode (ref_function = "vcf_predicate_func_closure_ref", unref_function = "vcf_predicate_func_closure_unref")]
private class Vcf.PredicateFuncClosure<E>
{
    private uint _ref_count = 1;

    public PredicateFunc<E> func { get; private owned set; }

    public PredicateFuncClosure (owned PredicateFunc<E> func)
    {
        this.func = (owned) func;
    }

    public unowned PredicateFuncClosure<E> @ref () requires (_ref_count > 0)
    {
        AtomicUint.inc (ref _ref_count);
        return this;
    }

    public void unref () requires (_ref_count > 0)
    {
        if (AtomicUint.dec_and_test (ref _ref_count))
            free ();
    }

    private extern void free ();
}
