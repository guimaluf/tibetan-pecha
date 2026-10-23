# pecha — Tibetan Pecha Document Class for Translation Studies

A LaTeX document class for creating traditional Tibetan pechas
(དཔེ་ཆ) with interlinear glossing, translation, and glossary
generation. Designed for A4 landscape printing with classic
pecha formatting.

## Features

- Traditional Tibetan pecha layout (landscape, framed pages,
  sheet numbering, margin texts)
- Word-by-word glosses above Tibetan text using `\pg{word}{gloss}`
- Glosses appear only on first occurrence (de-clutters the pecha)
- Free-form translation paragraphs below Tibetan text
- Automatic glossary generation at document end
- Unicode Tibetan support via XeLaTeX/LuaLaTeX (recommended)
- Wylie transliteration support via the legacy `ctib` package

## Requirements

- **XeLaTeX** or **LuaLaTeX** (recommended for Unicode Tibetan)
- A Tibetan Unicode font (e.g. Noto Serif Tibetan, Jomolhari)
- `texlive-latex-recommended` and `texlive-latex-extra` (Ubuntu)
- For Wylie mode: `texlive-lang-other` (provides the `ctib` package)

Install on Ubuntu:

    sudo apt-get install texlive-xetex texlive-latex-extra
    sudo apt-get install fonts-noto  # for Noto Serif Tibetan

## Quick Start

```latex
\documentclass{pecha}
\setpechafont{Noto Serif Tibetan}

\title{Example Pecha}
\oddleft{T}{E}

\begin{document}
\maketitle

\pecha{
  \pg{དཔེ་ཆ}{pecha} \pg{ནི}{is} \pg{བོད་ཀྱི}{Tibetan}
}
\pechatrans{The pecha is the traditional Tibetan book format.}

\printpechaglossary
\end{document}
```

## Compilation

    xelatex pecha-example.tex

## Key Commands

| Command | Description |
|---------|-------------|
| `\pg{word}{gloss}` | Gloss a Tibetan word (shown only on first occurrence) |
| `\pg*{word}{gloss}` | Silent gloss: glossary only, no in-text display |
| `\pecha{...}` | Tibetan text paragraph |
| `\pechatrans{...}` | Translation paragraph |
| `\printpechaglossary` | Print glossary at end of document |
| `\pechaglossreset` | Reset gloss tracking (new chapter/section) |
| `\pechaglossresetall` | Reset all gloss tracking and glossary entries |
| `\setpechafont{font}` | Set the Tibetan font |
| `\settranslationfont{font}` | Set a dedicated font for translations |
| `\oddleft{a}{b}` | Left margin text on odd pages |
| `\oddright{text}` | Right margin text on odd pages |
| `\evenleft{text}` | Left margin text on even pages |
| `\evenright{text}` | Right margin text on even pages |

## Class Options

| Option | Description |
|--------|-------------|
| `a4pecha2` | A4 landscape, 140mm height (default) |
| `a4pecha3` | A4 landscape, 70mm height |
| `letterpecha2` | Letter landscape, 2 pechas per page |
| `doubleframe` | Double-line border (default) |
| `simpleframe` | Single-line border |
| `fancyframe` | Ornamented frame on first pages |
| `rotate` | Rotate even pages 180° |
| `narrowpage` | Narrower text block |
| `mediumpage` | Medium text block (default) |
| `widepage` | Wider text block |
| `extrawide` | Maximum text width |
| `septitle` | Separate title page |
| `wylie` | Use ctib/Wylie input mode |

## Merging Pages for Printing

Use `pdfjam` to merge pecha pages for A4 printing:

    pdfjam pecha-example.pdf --nup 1x2 --landscape \
      --outfile pecha-example-merged.pdf

## License

Code: MIT License — see [LICENSE](LICENSE)
Content: Creative Commons Attribution 4.0

This package builds upon the original `pecha.cls` by Dieter Jäger
(2004, GPL) and the `ctib` package by Oliver Corff (2002).