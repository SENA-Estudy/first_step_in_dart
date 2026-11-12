# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A set of introductory Dart exercises (written in Spanish) that simulate a restaurant POS ("La Buena Mesa"). The exercise statements, starting data and expected outputs are in `doc/Guia_Introduccion_Dart_Restaurante.pdf` (section 10, "Ejercicios del restaurante"). Read it with `pdftotext doc/Guia_Introduccion_Dart_Restaurante.pdf -` when working on an exercise.

There is no `pubspec.yaml`, no packages and no test suite. Each `.dart` file at the root is a standalone script with its own `main()`, one per exercise:

| # | Exercise (guide) | File |
|---|---|---|
| 1 | Abrir la caja | `AbrirCaja.dart` |
| 2 | Registrar la venta de una mesa | `RegistrarVenta.dart` |
| 3 | Venta con descuento | `ventaConDescuento.dart` |
| 4 | Devolución de un producto | not done yet |
| 5 | Jornada completa y cierre de caja | `jornadaConCierreCaja.dart` |

`retoAdicional/` is an empty folder for an extra challenge.

## Commands

```bash
dart run AbrirCaja.dart          # run one exercise (or: dart AbrirCaja.dart)
dart analyze                     # static analysis on all files
dart format .                    # format
```

"Testing" means running the script and checking the console output against the expected result in the guide. Each `main()` ends by calling the logic several times with changed inputs to show the different cases (error paths, edge cases).

## Conventions

- Code, identifiers, comments and printed messages are in Spanish; keep it that way.
- The exercises are meant to practise only the basics the guide covers: variables, `var`/`final`/`const`, operators (including `~/` for whole-peso amounts), null safety, `if`/ternary/`switch`, loops, `List` and `Map`. Avoid classes, external packages or advanced features unless asked.
- Money amounts are `int` pesos; percentages are calculated with integer division so there are no decimals.
- All exercises share the same `menu` map (`Map<String, int>` of product → price); an ordered product that is not in the menu is reported and skipped with `continue`.
- Commit messages follow the `feat: <exercise name>` pattern.
