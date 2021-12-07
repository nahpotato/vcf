/*
 * Copyright 2021 Nahuel Gomez https://nahuelgomez.com.ar
 *
 * SPDX-License-Identifier: LGPL-3.0-or-later
 */

namespace Vcf.Utils
{
    public EqualFunc<T> equal_func_for<T> ()
    {
        Type type = typeof (T);

        if (type.is_a (typeof (Equatable)))
        {
            return (v1, v2) =>
            {
                if (v1 == v2)
                    return true;

                if (v1 == null)
                    return false;

                if (v2 == null)
                    return false;

                return ((Equatable<T>) v1).equal (v2);
            };
        }

        if (type.is_enum ())
            return (v1, v2) => (int?) v1 == (int?) v2;

        switch (type)
        {
            case Type.BOOLEAN:
                return (v1, v2) => (bool?) v1 == (bool?) v2;

            case Type.CHAR:
                return (v1, v2) => (char?) v1 == (char?) v2;

            case Type.DOUBLE:
                return (v1, v2) => (double?) v1 == (double?) v2;

            case Type.FLOAT:
                return (v1, v2) => (float?) v1 == (float?) v2;

            case Type.INT:
                return (v1, v2) => (int?) v1 == (int?) v2;

            case Type.INT64:
                return (v1, v2) => (int64?) v1 == (int64?) v2;

            case Type.LONG:
                return (v1, v2) => (long?) v1 == (long?) v2;

            case Type.STRING:
                return (v1, v2) => (string?) v1 == (string?) v2;

            case Type.UCHAR:
                return (v1, v2) => (uchar?) v1 == (uchar?) v2;

            case Type.UINT:
                return (v1, v2) => (uint?) v1 == (uint?) v2;

            case Type.UINT64:
                return (v1, v2) => (uint64?) v1 == (uint64?) v2;

            case Type.ULONG:
                return (v1, v2) => (ulong?) v1 == (ulong?) v2;

            case Type.VARIANT:
                return (v1, v2) =>
                {
                    if (v1 == v2)
                        return true;

                    if (v1 == null)
                        return false;

                    if (v2 == null)
                        return false;

                    return ((Variant) v1).equal ((Variant) v2);
                };
        }

        return (v1, v2) => v1 == v2;
    }

    public StringifierFunc<T> stringifier_func_for<T> ()
    {
        Type type = typeof (T);

        if (type.is_a (typeof (Stringifiable)))
        {
            return @value =>
            {
                if (@value == null)
                    return "(null)";

                return ((Stringifiable) @value).to_string ();
            };
        }

        if (type.is_enum ())
        {
            return @value =>
            {
                if (@value == null)
                    return "(null)";

                return EnumClass.to_string (type, (int?) @value);
            };
        }

        switch (type)
        {
            case Type.BOOLEAN:
                return @value =>
                {
                    if (@value == null)
                        return "(null)";

                    return ((bool?) @value).to_string ();
                };

            case Type.CHAR:
                return @value =>
                {
                    if (@value == null)
                        return "(null)";

                    return ((char?) @value).to_string ();
                };

            case Type.DOUBLE:
                return @value =>
                {
                    if (@value == null)
                        return "(null)";

                    return ((double?) @value).to_string ();
                };

            case Type.FLOAT:
                return @value =>
                {
                    if (@value == null)
                        return "(null)";

                    return ((float?) @value).to_string ();
                };

            case Type.INT:
                return @value =>
                {
                    if (@value == null)
                        return "(null)";

                    return ((int?) @value).to_string ();
                };

            case Type.INT64:
                return @value =>
                {
                    if (@value == null)
                        return "(null)";

                    return ((int64?) @value).to_string ();
                };

            case Type.LONG:
                return @value =>
                {
                    if (@value == null)
                        return "(null)";

                    return ((long?) @value).to_string ();
                };

            case Type.STRING:
                return @value =>
                {
                    if (@value == null)
                        return "(null)";

                    return ((string?) @value).to_string ();
                };

            case Type.UCHAR:
                return @value =>
                {
                    if (@value == null)
                        return "(null)";

                    return ((uchar?) @value).to_string ();
                };

            case Type.UINT:
                return @value =>
                {
                    if (@value == null)
                        return "(null)";

                    return ((uint?) @value).to_string ();
                };

            case Type.UINT64:
                return @value =>
                {
                    if (@value == null)
                        return "(null)";

                    return ((uint64?) @value).to_string ();
                };

            case Type.ULONG:
                return @value =>
                {
                    if (@value == null)
                        return "(null)";

                    return ((ulong?) @value).to_string ();
                };
        }

        return () => type.name ();
    }

    public HashFunc<E> hash_func_for<E> ()
    {
        Type type = typeof (E);

        if (type.is_a (typeof (Hashable)))
        {
            return @value =>
            {
                if (@value == null)
                    return 0U;

                return ((Hashable) @value).hash ();
            };
        }

        if (type.is_enum ())
        {
            return @value =>
            {
                if (@value == null)
                    return 0U;

                return (uint) (int?) @value;
            };
        }

        switch (type)
        {
            case Type.BOOLEAN:
                return @value =>
                {
                    if (@value == null)
                        return 0U;

                    return (uint) (bool?) @value;
                };

            case Type.CHAR:
                return @value =>
                {
                    if (@value == null)
                        return 0U;

                    return (5381U << 5) + 5381U + (char?) @value;
                };

            case Type.DOUBLE:
                return @value =>
                {
                    if (@value == null)
                        return 0U;

                    return (uint) (double?) @value;
                };

            case Type.FLOAT:
                return @value =>
                {
                    if (@value == null)
                        return 0U;

                    return (uint) (float?) @value;
                };

            case Type.INT:
                return @value =>
                {
                    if (@value == null)
                        return 0U;

                    return (uint) (int?) @value;
                };

            case Type.INT64:
                return @value =>
                {
                    if (@value == null)
                        return 0U;

                    return (uint) (int64?) @value;
                };

            case Type.LONG:
                return @value =>
                {
                    if (@value == null)
                        return 0U;

                    return (uint) (long?) @value;
                };

            case Type.STRING:
                return @value =>
                {
                    if (@value == null)
                        return 0U;

                    var str = (string?) @value;
                    var h = 5381U;

                    for (var i = 0U; str[i] != '\0'; i++)
                        h = (h << 5) + h + str[i];

                    return h;
                };

            case Type.UCHAR:
                return @value =>
                {
                    if (@value == null)
                        return 0U;

                    return (5381U << 5) + 5381U + (uchar?) @value;
                };

            case Type.UINT:
                return @value =>
                {
                    if (@value == null)
                        return 0U;

                    return (uint) (uint?) @value;
                };

            case Type.UINT64:
                return @value =>
                {
                    if (@value == null)
                        return 0U;

                    return (uint) (uint64?) @value;
                };

            case Type.ULONG:
                return @value =>
                {
                    if (@value == null)
                        return 0U;

                    return (uint) (ulong?) @value;
                };

            case Type.VARIANT:
                return @value =>
                {
                    if (@value == null)
                        return 0U;

                    return ((Variant) @value).hash ();
                };
        }

        return @value => (uint) (void*) @value;
    }
}
