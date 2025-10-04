### Sadhanas

* [Dudjom Tersar Ngöndro](dudjom-tersar-ngondro/)
* [Prajna Paramita](prajnaparamita/)
* [Chuva de bençãos](tsigdun-soldeb-naldjor)
* []

### Requirements

[CTAN Tibetan Language](http://ctan.mackichan.com/language/tibetan/)
---
* ctib
* pecha

These packages can be found in `texlive-lang-others` and `texlive-latex-extra`
on Ubuntu, which can be installed as the following:

`sudo apt-get install texlive-lang-others texlive-latex-extra`

Compiling is done using XeLaTeX, which can be obtained with:

`sudo apt-get install texlive-xetex `

Example of usage:

Using xelatex

`xelatex prajnaparamita.tex`

Using latexmk

`latexmk -pdf -pv -xelatex tsigdun-soldeb-naldjor.tex`


Merging `a4pecha2` into one single printable pdf using `pdfjam`

`pdfjam tsigdun-soldeb-naldjor/tsigdun-soldeb-naldjor.pdf --nup 1x2 --landscape --outfile tsigdun-soldeb-naldjor-merged.pdf`

## License

The content of this project itself is licensed under the [Creative Commons Attribution 4.0 license](https://creativecommons.org/licenses/by/4.0/), and the underlying source code used to format and display that content is licensed under the [MIT license](http://opensource.org/licenses/mit-license.php).
