# `mkttf`: BDF to TTF conversion #

The `mkttf.py` script converts a set of BDF files into
a TTF file, automatically generating the required scalable outlines
(actually, any font format supported by FontForge is accepted).
Call it with the `-h` option for usage help.

The `mkttf.sh` script generates medium (normal), bold and italic versions
of the Terminus font. It will create three directories ("Normal", "Bold"
and "Italic") in the current working directory.

To use `mktff.py`, you need the following tools installed in your PATH:
  - [FontForge](http://fontforge.sf.net): This tool and its Python extension
    enable me to modify the font using Python. You need a version that has
    Python support enabled (i. e. provides a Python extension).
  - [Potrace](http://potrace.sf.net): To generate the scalable outlines.
  - A recent version of [Python](http://python.org). Whether you have to choose
    Python 2 or Python 3 depends on how your version of FontForge was built:
    FontForge can either be built with support for Python 2 or with support for
    Python 3. `mkttf.py` supports both versions.

To use `mkttf.sh`, you additionally need the following programs in your path:
  - Obviously, you need a POSIX-compliant shell.
  - [mkitalic](http://hp.vector.co.jp/authors/VA013651/freeSoftware/mkbold-mkitalic.html):
    To generate the italic font.

The `mkttf.sh` script takes two mandatory arguments:

1. The directory containing the Terminus BDF files. The italic versions of the BDF
   files will be placed there.
2. The font version which will be included in the file names of the generated files
   and in the font files themselves (so it can be e. g. shown to the user).

All other arguments are passed directly to `mkttf.py`.

Additionally to generating TTF fonts, the script will also generate an SFD
file (FontForge's native file format) for each font weight so that the generated
fonts can be easily modified, if necessary.

If you want to generate TTF versions of other fonts, you should only need
to modify `mkttf.sh` -- the `mkttf.py` script is completely generic.

Have fun!

## Generating TTF fonts for Windows ##

Windows, and native Windows programs like Visual Studio, will only use the bitmaps
embedded in the TTF fonts generated by `mkttf` if certain Hiragana characters are
present in the fonts (for full details, see
[Raster fonts in Visual Studio 2010](http://www.electronicdissonance.com/2010/01/raster-fonts-in-visual-studio-2010.html)).

`mkttf` can ensure that those Hiragana characters are present in the generated
fonts. To enable this feature, pass the `--visual-studio-fixes` (or just `-s`)
option to your invocations of `mkttf.sh` or `mkttf.py`.

**Caveat:** `mkttf` will not add _real_ Hiragana glyphs to the font! Instead,
it will try to add a _fake_ glyph for every required Hiragana character that is
missing from the font to fool Windows into thinking that the font is an Asian
font for which bitmaps should be used.

In detail, `mkttf` will ensure that glyphs for the following Hiragana
characters are present:

- [U+3044 "HIRAGANA LETTER I"](https://www.fileformat.info/info/unicode/char/3044/index.htm)
- [U+3046 "HIRAGANA LETTER U"](https://www.fileformat.info/info/unicode/char/3046/index.htm)
- [U+304B "HIRAGANA LETTER KA"](https://www.fileformat.info/info/unicode/char/304B/index.htm)
- [U+3057 "HIRAGANA LETTER SI"](https://www.fileformat.info/info/unicode/char/3057/index.htm)
- [U+306E "HIRAGANA LETTER NO"](https://www.fileformat.info/info/unicode/char/306E/index.htm)
- [U+3093 "HIRAGANA LETTER N"](https://www.fileformat.info/info/unicode/char/3093/index.htm)

For missing Hiragana characters, `mkttf` will simply re-use the glyph for another
character from the font; it will use the first character from the following list that exists
in the font:

- [U+0000 "NULL"](https://www.fileformat.info/info/unicode/char/0000/index.htm)
- [U+003F "QUESTION MARK"](https://www.fileformat.info/info/unicode/char/003F/index.htm)
- [U+0020 "SPACE"](https://www.fileformat.info/info/unicode/char/0020/index.htm)

Doing this has one big **drawback**: For the above Hiragana characters,
the "fake" glyphs will be used instead of real Hiragana glyphs
from another suitable font -- i. e. falling back to another font will not work,
and those characters will not be displayed correctly. This of course is an issue
if you actually need those Hiragana characters to display correctly, so you cannot
use this `mkttf` feature in that case.
