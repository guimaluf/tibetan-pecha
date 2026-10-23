\ProvidesExplClass{pecha}{2025/10/23}{v1.0}{Tibetan~Pecha~document~class~with~translation~glossing}
\NeedsTeXFormat{LaTeX2e}

\LoadClass{article}

\RequirePackage{graphicx}
\RequirePackage{xcolor}

\bool_new:N \g_pecha_unicode_bool
\bool_new:N \g_pecha_wylie_bool
\bool_new:N \g_pecha_rotate_bool
\bool_new:N \g_pecha_duplex_bool
\bool_new:N \g_pecha_singleframe_bool
\bool_new:N \g_pecha_fancyframe_bool
\bool_new:N \g_pecha_septitle_bool
\bool_new:N \g_pecha_has_title_bool
\bool_new:N \g_pecha_noframe_bool

\bool_set_true:N \g_pecha_unicode_bool
\bool_set_false:N \g_pecha_wylie_bool
\bool_set_false:N \g_pecha_rotate_bool
\bool_set_false:N \g_pecha_singleframe_bool
\bool_set_false:N \g_pecha_fancyframe_bool
\bool_set_false:N \g_pecha_septitle_bool
\bool_set_false:N \g_pecha_has_title_bool
\bool_set_false:N \g_pecha_duplex_bool
\bool_set_false:N \g_pecha_noframe_bool

\DeclareOption{wylie}{
  \bool_set_true:N \g_pecha_wylie_bool
  \bool_set_false:N \g_pecha_unicode_bool
}

\DeclareOption{a4pecha3}{
  \dim_set:Nn \paperwidth {297mm}
  \dim_set:Nn \paperheight {70mm}
}
\DeclareOption{a4pecha2}{
  \dim_set:Nn \paperwidth {297mm}
  \dim_set:Nn \paperheight {140mm}
}
\DeclareOption{a4paper}{
  \dim_set:Nn \paperwidth {297mm}
  \dim_set:Nn \paperheight {210mm}
}
\DeclareOption{a5pecha3}{
  \dim_set:Nn \paperwidth {210mm}
  \dim_set:Nn \paperheight {47mm}
}
\DeclareOption{a5pecha2}{
  \dim_set:Nn \paperwidth {210mm}
  \dim_set:Nn \paperheight {74mm}
}
\DeclareOption{a5paper}{
  \dim_set:Nn \paperwidth {210mm}
  \dim_set:Nn \paperheight {148mm}
}
\DeclareOption{b5pecha3}{
  \dim_set:Nn \paperwidth {250mm}
  \dim_set:Nn \paperheight {58.67mm}
}
\DeclareOption{b5pecha2}{
  \dim_set:Nn \paperwidth {250mm}
  \dim_set:Nn \paperheight {88mm}
}
\DeclareOption{b5paper}{
  \dim_set:Nn \paperwidth {250mm}
  \dim_set:Nn \paperheight {176mm}
}
\DeclareOption{letterpecha3}{
  \dim_set:Nn \paperwidth {11in}
  \dim_set:Nn \paperheight {2.83in}
}
\DeclareOption{letterpecha2}{
  \dim_set:Nn \paperwidth {11in}
  \dim_set:Nn \paperheight {4.25in}
}
\DeclareOption{letterpaper}{
  \dim_set:Nn \paperwidth {11in}
  \dim_set:Nn \paperheight {8.5in}
}
\DeclareOption{legalpecha3}{
  \dim_set:Nn \paperwidth {14in}
  \dim_set:Nn \paperheight {2.83in}
}
\DeclareOption{legalpecha2}{
  \dim_set:Nn \paperwidth {14in}
  \dim_set:Nn \paperheight {4.25in}
}
\DeclareOption{legalpaper}{
  \dim_set:Nn \paperwidth {14in}
  \dim_set:Nn \paperheight {8.5in}
}
\DeclareOption{executivepaper}{
  \dim_set:Nn \paperwidth {10.5in}
  \dim_set:Nn \paperheight {7.25in}
}

\DeclareOption{rotate}{\bool_set_true:N \g_pecha_rotate_bool}
\DeclareOption{duplex}{
  \bool_set_true:N \g_pecha_duplex_bool
  \bool_set_false:N \g_pecha_rotate_bool
}
\DeclareOption{fancyframe}{
  \bool_set_true:N \g_pecha_singleframe_bool
  \bool_set_true:N \g_pecha_fancyframe_bool
}
\DeclareOption{doubleframe}{
  \bool_set_false:N \g_pecha_singleframe_bool
}
\DeclareOption{simpleframe}{
  \bool_set_true:N \g_pecha_singleframe_bool
}
\DeclareOption{septitle}{\bool_set_true:N \g_pecha_septitle_bool}

\dim_new:N \g_pecha_pheight_dim
\DeclareOption{narrowpage}{\dim_set:Nn \g_pecha_pheight_dim {26ex}}
\DeclareOption{mediumpage}{\dim_set:Nn \g_pecha_pheight_dim {28ex}}
\DeclareOption{widepage}{\dim_set:Nn \g_pecha_pheight_dim {33ex}}
\DeclareOption{extrawide}{\dim_set:Nn \g_pecha_pheight_dim {36ex}}

\dim_new:N \g_pecha_rulers_dim

\ExecuteOptions{a4pecha2,doubleframe,10pt,mediumpage}
\ProcessOptions

\bool_if:NTF \g_pecha_singleframe_bool
  { \dim_set:Nn \g_pecha_rulers_dim {1.6pt} }
  { \dim_set:Nn \g_pecha_rulers_dim {9.2pt} }

\sys_if_engine_xetex:T { \bool_set_true:N \g_pecha_unicode_bool }
\sys_if_engine_luatex:T { \bool_set_true:N \g_pecha_unicode_bool }
\sys_if_engine_pdftex:T {
  \bool_if:NT \g_pecha_unicode_bool {
    \ClassWarning{pecha}{PDFTeX~detected.~Use~XeLaTeX~or~LuaLaTeX~for~Unicode~Tibetan.~Forcing~wylie~mode.}
    \bool_set_false:N \g_pecha_unicode_bool
    \bool_set_true:N \g_pecha_wylie_bool
  }
}

\bool_if:NTF \g_pecha_unicode_bool {
  \RequirePackage{fontspec}
}{
  \bool_if:NT \g_pecha_wylie_bool {
    \IfFileExists{ctib.sty}{
      \RequirePackage{ctib}
    }{
      \ClassError{pecha}{ctib~package~not~found.~Install~texlive-lang-other}{}
    }
  }
}

\dim_new:N \g_pecha_marginht_dim
\dim_new:N \g_pecha_margindp_dim
\dim_new:N \g_pecha_pechadim_dim
\dim_new:N \g_pecha_titledim_dim
\dim_new:N \g_pecha_pechawidth_dim
\dim_new:N \g_pecha_textwidth_saved_dim
\dim_new:N \g_pecha_titlewidth_dim
\dim_new:N \g_pecha_outermargin_dim
\dim_new:N \g_pecha_innermargin_horiz_dim
\dim_new:N \g_pecha_innermargin_vert_dim

\dim_set:Nn \g_pecha_marginht_dim {3ex}
\dim_set:Nn \g_pecha_margindp_dim {1ex}
\dim_set:Nn \g_pecha_outermargin_dim {8mm}
\dim_set:Nn \g_pecha_innermargin_horiz_dim {4ex}
\dim_set:Nn \g_pecha_innermargin_vert_dim  {25pt}

\newcounter{pechasheet}
\setcounter{pechasheet}{1}

\dim_gset:Nn \g_pecha_pechadim_dim {6em}
\dim_gadd:Nn \g_pecha_pechadim_dim { \g_pecha_rulers_dim }
\dim_gadd:Nn \g_pecha_pechadim_dim { 2\g_pecha_marginht_dim }
\dim_gadd:Nn \g_pecha_pechadim_dim { 2\g_pecha_margindp_dim }

\dim_set:Nn \textwidth { \paperwidth - 2\g_pecha_outermargin_dim }
\dim_gset_eq:NN \g_pecha_pechawidth_dim \textwidth
\dim_gset:Nn \g_pecha_titledim_dim { 0.2\textwidth }

\dim_gsub:Nn \textwidth { \g_pecha_pechadim_dim }
\dim_gset_eq:NN \g_pecha_textwidth_saved_dim \textwidth

\bool_if:NT \g_pecha_fancyframe_bool {
  \dim_gsub:Nn \textwidth { 12em }
}

\dim_gset:Nn \g_pecha_titlewidth_dim { \textwidth - \g_pecha_titledim_dim }

\dim_set_eq:NN \textheight \g_pecha_pheight_dim

\setlength{\headheight}{0pt}
\setlength{\headsep}{0pt}
\setlength{\marginparsep}{0pt}
\setlength{\marginparwidth}{0pt}
\setlength{\footskip}{0pt}
\setlength{\marginparpush}{0pt}
\setlength{\parindent}{0pt}
\setlength{\parskip}{12pt}

\dim_set:Nn \oddsidemargin {0pt}
\dim_set_eq:NN \evensidemargin \oddsidemargin
\dim_set:Nn \topmargin {0pt}

\pagenumbering{arabic}

\sys_if_engine_pdftex:T {
  \dim_set_eq:NN \pdfpagewidth \paperwidth
  \dim_set_eq:NN \pdfpageheight \paperheight
}
\sys_if_engine_xetex:T {
  \dim_set_eq:NN \pdfpagewidth \paperwidth
  \dim_set_eq:NN \pdfpageheight \paperheight
}
\sys_if_engine_luatex:T {
  \dim_set_eq:NN \pdfpagewidth \paperwidth
  \dim_set_eq:NN \pdfpageheight \paperheight
}

\hsize=\textwidth

\hoffset=-1in
\voffset=-1in

\pagestyle{empty}

\renewcommand{\baselinestretch}{0.7}
\raggedbottom

\tl_new:N \g_pecha_oleft_tl
\tl_new:N \g_pecha_oleft_alt_tl
\tl_new:N \g_pecha_eleft_tl
\tl_new:N \g_pecha_eright_tl
\tl_new:N \g_pecha_oright_tl

\newcommand{\oddleft}[2]{
  \tl_gset:Nn \g_pecha_oleft_tl {#1}
  \tl_gset:Nn \g_pecha_oleft_alt_tl {#2}
}
\newcommand{\oddright}[1]{
  \tl_gset:Nn \g_pecha_oright_tl {#1}
}
\newcommand{\evenleft}[1]{
  \tl_gset:Nn \g_pecha_eleft_tl {#1}
}
\newcommand{\evenright}[1]{
  \tl_gset:Nn \g_pecha_eright_tl {#1}
}

\tl_new:N \g_pecha_author_tl
\tl_new:N \g_pecha_translatedauthor_tl
\tl_new:N \g_pecha_subtitle_tl
\tl_new:N \g_pecha_date_tl

\newcommand{\shorttitle}[2]{
  \oddleft{#1}{#2}
}

\newcommand{\translatedtitle}[1]{
  \oddright{#1}
  \evenright{#1}
}

\renewcommand{\author}[1]{
  \tl_gset:Nn \g_pecha_author_tl {#1}
  \evenleft{#1}
}

\newcommand{\translatedauthor}[1]{
  \tl_gset:Nn \g_pecha_translatedauthor_tl {#1}
}

\newcommand{\subtitle}[1]{
  \tl_gset:Nn \g_pecha_subtitle_tl {#1}
}

\renewcommand{\date}[1]{
  \tl_gset:Nn \g_pecha_date_tl {#1}
}

\tl_new:N \g_pecha_title_tl
\newcommand{\pechatitle}[1]{
  \tl_gset:Nn \g_pecha_title_tl {#1}
  \bool_set_true:N \g_pecha_has_title_bool
}
\renewcommand{\title}[1]{\pechatitle{#1}}

\newcommand{\tibnumeral}[1]{
  \int_compare:nNnTF {#1} < {100} {
    \int_case:nn {#1} {
      {0} {}
      {1} {gcig}
      {2} {gnyis}
      {3} {gsum}
      {4} {bzhi}
      {5} {lnga}
      {6} {drug}
      {7} {bdun}
      {8} {b-rgyad}
      {9} {dgu}
      {10} {bcu}
      {11} {bcu~gcig}
      {12} {bcu~gnyis}
      {13} {bcu~gsum}
      {14} {bcu~bzhi}
      {15} {bco~lnga}
      {16} {bcu~drug}
      {17} {bcu~bdun}
      {18} {bco~b-rgyad}
      {19} {bcu~dgu}
      {20} {nyi~shu}
      {21} {nyi~shu~tsa~gcig}
      {22} {nyi~shu~tsa~gnyis}
      {23} {nyi~shu~tsa~gsum}
      {24} {nyi~shu~tsa~bzhi}
      {25} {nyi~shu~tse~lnga}
      {26} {nyi~shu~tsa~drug}
      {27} {nyi~shu~tsa~bdun}
      {28} {nyi~shu~tsa~b-rgyad}
      {29} {nyi~shu~tsa~dgu}
      {30} {gsum~bcu}
      {31} {gsum~bcu~so~gcig}
      {32} {gsum~bcu~so~gnyis}
      {33} {gsum~bcu~so~gsum}
      {34} {gsum~bcu~so~bzhi}
      {35} {gsum~bcu~so~lnga}
      {36} {gsum~bcu~so~drug}
      {37} {gsum~bcu~so~bdun}
      {38} {gsum~bcu~so~b-rgyad}
      {39} {gsum~bcu~so~dgu}
      {40} {bzhi~bcu}
      {41} {bzhi~bcu~zhe~gcig}
      {42} {bzhi~bcu~zhe~gnyis}
      {43} {bzhi~bcu~zhe~gsum}
      {44} {bzhi~bcu~zhe~bzhi}
      {45} {bzhi~bcu~zhe~lnga}
      {46} {bzhi~bcu~zhe~drug}
      {47} {bzhi~bcu~zhe~bdun}
      {48} {bzhi~bcu~zhe~b-rgyad}
      {49} {bzhi~bcu~zhe~dgu}
      {50} {lnga~bcu}
      {51} {lnga~bcu~nga~gcig}
      {52} {lnga~bcu~nga~gnyis}
      {53} {lnga~bcu~nga~gsum}
      {54} {lnga~bcu~nga~bzhi}
      {55} {lnga~bcu~nge~lnga}
      {56} {lnga~bcu~nga~drug}
      {57} {lnga~bcu~nga~bdun}
      {58} {lnga~bcu~nga~b-rgyad}
      {59} {lnga~bcu~nga~dgu}
      {60} {drug~bcu}
      {61} {drug~bcu~re~gcig}
      {62} {drug~bcu~re~gnyis}
      {63} {drug~bcu~re~gsum}
      {64} {drug~bcu~re~bzhi}
      {65} {drug~bcu~re~lnga}
      {66} {drug~bcu~re~drug}
      {67} {drug~bcu~re~bdun}
      {68} {drug~bcu~re~b-rgyad}
      {69} {drug~bcu~re~dgu}
      {70} {bdun~bcu}
      {71} {bdun~bcu~don~gcig}
      {72} {bdun~bcu~don~gnyis}
      {73} {bdun~bcu~don~gsum}
      {74} {bdun~bcu~don~bzhi}
      {75} {bdun~bcu~don~lnga}
      {76} {bdun~bcu~don~drug}
      {77} {bdun~bcu~don~bdun}
      {78} {bdun~bcu~don~b-rgyad}
      {79} {bdun~bcu~don~dgu}
      {80} {b-rgyad~bcu}
      {81} {b-rgyad~bcu~rgya~gcig}
      {82} {b-rgyad~bcu~rgya~gnyis}
      {83} {b-rgyad~bcu~rgya~gsum}
      {84} {b-rgyad~bcu~rgya~bzhi}
      {85} {b-rgyad~bcu~rgya~lnga}
      {86} {b-rgyad~bcu~rgya~drug}
      {87} {b-rgyad~bcu~rgya~bdun}
      {88} {b-rgyad~bcu~rgya~b-rgyad}
      {89} {b-rgyad~bcu~rgya~dgu}
      {90} {dgu~bcu}
      {91} {dgu~bcu~go~gcig}
      {92} {dgu~bcu~go~gnyis}
      {93} {dgu~bcu~go~gsum}
      {94} {dgu~bcu~go~bzhi}
      {95} {dgu~bcu~go~lnga}
      {96} {dgu~bcu~go~drug}
      {97} {dgu~bcu~go~bdun}
      {98} {dgu~bcu~go~b-rgyad}
      {99} {dgu~bcu~go~dgu}
    }
  }{
    #1
  }
}

\newcommand{\tibsmall}[1]{
  \bool_if:NTF \g_pecha_unicode_bool {
    {\footnotesize #1}
  }{
    {\footnotesize \tib #1\bit}
  }
}

\cs_new:Npn \pecha_doubleruler: { \vrule \kern 1.5pt \vrule }

\newcommand{\newsheet}{\clearpage\ifodd\c@page\else\hbox{}\newpage\fi}

\newcommand{\pechaglossreset}{
  \prop_gclear:N \g_pecha_seen_prop
}

\newcommand{\pechaglossresetall}{
  \prop_gclear:N \g_pecha_seen_prop
  \prop_gclear:N \g_pecha_gloss_prop
  \seq_gclear:N \g_pecha_gloss_order_seq
}

\newenvironment{pechatitlepage}{%
  \newsheet
  \setcounter{page}{1}
}{%
  \bool_if:NTF \g_pecha_septitle_bool {
    \newsheet
    \setcounter{page}{1}
    \setcounter{pechasheet}{1}
  }{
    \newpage
  }
}

\let\titlepage\pechatitlepage

\newcommand{\makepechatitle}{
  \bool_set_true:N \g_pecha_has_title_bool
  \hbox_set:Nn \l_tmpa_box { \parbox{\g_pecha_titlewidth_dim}{
    \centering
    { \pechatibfont \g_pecha_title_tl } \par\medskip
    \tl_if_empty:NF \g_pecha_translatedauthor_tl {
      \textit{ \g_pecha_translatedauthor_tl } \par\smallskip
    }
    \tl_if_empty:NF \g_pecha_subtitle_tl {
      { \pechatibfont \g_pecha_subtitle_tl } \par\smallskip
    }
    \tl_if_empty:NF \g_pecha_date_tl {
      \small \g_pecha_date_tl \par
    }
  }}
  \begin{pechatitlepage}
    \box_use:N \l_tmpa_box
  \end{pechatitlepage}
}
\let\maketitle\makepechatitle

\cs_new:Npn \pecha_title_numlabel: {
  \hbox_set:Nn \l_tmpa_box {
    \hbox_to_wd:nn { \textheight } {
      \scriptsize\pechatibfont
      \g_pecha_oleft_tl \hfil \tibnumeral{\thepechasheet} \hfil \g_pecha_oleft_alt_tl
    }
  }
  \box_set_ht:Nn \l_tmpa_box { \g_pecha_marginht_dim }
  \box_set_dp:Nn \l_tmpa_box { \g_pecha_margindp_dim }
  \kern \box_dp:N \l_tmpa_box
  \rotatebox{-90}{\kern -\textheight \box_use:N \l_tmpa_box}
}

\cs_new:Npn \pecha_oddleft: {
  \hbox_set:Nn \l_tmpa_box {
    \hbox_to_wd:nn { \textheight } {
      \scriptsize\pechatibfont
      \bool_if:NTF \g_pecha_unicode_bool {
        \g_pecha_oleft_tl \hfil \tibnumeral{\thepechasheet} \hfil \g_pecha_oleft_alt_tl
      }{
        \tib \g_pecha_oleft_tl \hfil \tibnumeral{\thepechasheet} \hfil \g_pecha_oleft_alt_tl \bit
      }
    }
  }
  \box_set_ht:Nn \l_tmpa_box { \g_pecha_marginht_dim }
  \box_set_dp:Nn \l_tmpa_box { \g_pecha_margindp_dim }
  \rotatebox{-90}{\kern -\textheight \box_use:N \l_tmpa_box}
}

\cs_new:Npn \pecha_evenleft: {
  \hbox_set:Nn \l_tmpa_box {
    \skip_horizontal:n { -\textheight }
    \hbox_to_wd:nn { \textheight } {
      \scriptsize\pechatibfont
      \bool_if:NTF \g_pecha_unicode_bool {
        \hfil \g_pecha_eleft_tl \hfil
      }{
        \tib \hfil \g_pecha_eleft_tl \hfil \bit
      }
    }
  }
  \box_set_ht:Nn \l_tmpa_box { \g_pecha_marginht_dim }
  \box_set_dp:Nn \l_tmpa_box { \g_pecha_margindp_dim }
  \rotatebox{-90}{\box_use:N \l_tmpa_box}
}

\cs_new:Npn \pecha_oddright: {
  \hbox_set:Nn \l_tmpa_box {
    \hbox_to_wd:nn { \textheight } {
      \footnotesize \hfil \kern 1em \g_pecha_oright_tl \hfil
    }
  }
  \box_set_ht:Nn \l_tmpa_box { \g_pecha_marginht_dim }
  \box_set_dp:Nn \l_tmpa_box { \g_pecha_margindp_dim }
  \rotatebox{90}{\box_use:N \l_tmpa_box}
}

\cs_new:Npn \pecha_evenright: {
  \hbox_set:Nn \l_tmpa_box {
    \hbox_to_wd:nn { \textheight } {
      \footnotesize \hfil \kern 1em \g_pecha_eright_tl \hfil
    }
  }
  \box_set_ht:Nn \l_tmpa_box { \g_pecha_marginht_dim }
  \box_set_dp:Nn \l_tmpa_box { \g_pecha_margindp_dim }
  \rotatebox{90}{\box_use:N \l_tmpa_box}
}

\cs_new:Npn \pecha_oddfancy: {
  \hbox_set:Nn \l_tmpa_box {
    \hbox_to_wd:nn { \textheight } {
      \footnotesize\pechatibfont
      \bool_if:NTF \g_pecha_unicode_bool {
        \g_pecha_oleft_tl \hfil \tibnumeral{\thepechasheet} \hfil \g_pecha_oleft_alt_tl
      }{
        \tib \g_pecha_oleft_tl \hfil \tibnumeral{\thepechasheet} \hfil \g_pecha_oleft_alt_tl \bit
      }
    }
  }
  \box_set_ht:Nn \l_tmpa_box { \g_pecha_marginht_dim }
  \box_set_dp:Nn \l_tmpa_box { \g_pecha_margindp_dim }
  \rotatebox{-90}{\skip_horizontal:n { -\textheight } \box_use:N \l_tmpa_box}
}

\cs_new:Npn \pecha_evenfancy: {
  \hbox_set:Nn \l_tmpa_box {
    \skip_horizontal:n { -\textheight }
    \hbox_to_wd:nn { \textheight } {
      \footnotesize\pechatibfont
      \bool_if:NTF \g_pecha_unicode_bool {
        \hfil \g_pecha_eleft_tl \hfil
      }{
        \tib \hfil \g_pecha_eleft_tl \hfil \bit
      }
    }
  }
  \box_set_ht:Nn \l_tmpa_box { \g_pecha_marginht_dim }
  \box_set_dp:Nn \l_tmpa_box { \g_pecha_margindp_dim }
  \rotatebox{-90}{\box_use:N \l_tmpa_box}
}

\cs_new:Npn \pecha_doubleframe:n #1 {
  \hbox{
    \vrule
    \vbox{\hrule\kern 1.5pt
      \hbox{\kern 1.5pt\vrule
        \vbox{\hrule
          \hbox{
            \vbox{
              \hbox{
                \l_pecha_theleft_tl
                \pecha_doubleruler:\kern \g_pecha_innermargin_horiz_dim
                \vbox{
                  \kern \g_pecha_innermargin_vert_dim
                  \vbox to \textheight{
                    \vss
                    \box_use:N #1
                    \vss
                  }
                  \kern \g_pecha_innermargin_vert_dim
                }
                \pecha_doubleruler:\kern \g_pecha_innermargin_horiz_dim
                \l_pecha_theright_tl
              }
            }
          }\hrule
        }\vrule\kern 1.5pt
      }\kern 1.5pt\hrule
    }\vrule
  }
}

\cs_new:Npn \pecha_singleframe:n #1 {
  \hbox{
    \vrule
    \vbox{\hrule
      \hbox{
        \vbox{
          \hbox{
            \l_pecha_theleft_tl
            \vrule\kern 0.5em
            \vbox{
              \kern \g_pecha_innermargin_vert_dim
              \vbox to \textheight{
                \vss
                \box_use:N #1
                \vss
              }
              \kern \g_pecha_innermargin_vert_dim
            }
            \vrule
            \l_pecha_theright_tl
          }
        }
      }\hrule
    }\vrule
  }
}

\cs_new:Npn \pecha_fancyframe:n #1 {
  \hbox{
    \vrule
    \vbox{\hrule\kern 1.5pt
      \hbox{\kern 1.5pt\vrule
        \vbox{\hrule\kern 2em
          \hbox{
            \int_if_odd:nTF {\c@page} {
              \pecha_oddfancy:
            }{
              \pecha_evenfancy:
            }
            \vrule
            \vbox{\hrule\kern 1.5pt
              \hbox{\kern 1.5pt
                \vrule
                \vbox{
                  \hrule
                  \hbox{
                    \kern 4em\pecha_doubleruler:\kern 2em\pecha_doubleruler:\kern 0.5em
                    \vbox{
                      \kern \g_pecha_innermargin_vert_dim
                      \vbox to \textheight{ \vss \box_use:N #1 \vss }
                      \kern \g_pecha_innermargin_vert_dim
                    }
                    \pecha_doubleruler:\kern 2em\pecha_doubleruler:\kern 4em
                  }
                  \hrule
                }\vrule\kern 1.5pt
              }\kern 1.5pt\hrule
            }\vrule\kern 2em
          }\kern 2em\hrule
        }\vrule\kern 1.5pt
      }\kern 1.5pt\hrule
    }\vrule
  }
}

\def\@outputpage{\pecha_outputpage:}

\tl_new:N \l_pecha_theleft_tl
\tl_new:N \l_pecha_theright_tl

\cs_new:Npn \pecha_outputpage: {
  \group_begin:
    \let\protect\noexpand
    \set@typeset@protect
    \reset@font
    \normalsize
    \normalsfcodes
    \@parboxrestore
    \setbox\@outputbox\vbox{\hfil\box\@outputbox\hfil}
    \bool_if:NTF \g_pecha_has_title_bool {
      \bool_if:NTF \g_pecha_septitle_bool {
        \tl_set:Nn \l_pecha_theleft_tl {}
      }{
        \tl_set:Nn \l_pecha_theleft_tl { \pecha_title_numlabel: }
      }
      \tl_set:Nn \l_pecha_theright_tl {}
      \setbox\@outputbox\hbox{ \pecha_selectframe:n {\@outputbox} }
      \bool_set_false:N \g_pecha_has_title_bool
    }{
      \int_if_odd:nTF {\c@page} {
        \bool_if:NTF \g_pecha_duplex_bool {
          \tl_set:Nn \l_pecha_theleft_tl { \pecha_oddleft: }
          \tl_set:Nn \l_pecha_theright_tl { \pecha_oddright: }
        }{
          \tl_set:Nn \l_pecha_theleft_tl { \pecha_oddleft: }
          \tl_set:Nn \l_pecha_theright_tl { \pecha_oddright: }
        }
        \setbox\@outputbox\hbox{\pecha_selectframe:n {\@outputbox}}
      }{
        \bool_if:NTF \g_pecha_duplex_bool {
          \tl_set:Nn \l_pecha_theleft_tl { \pecha_oddleft: }
          \tl_set:Nn \l_pecha_theright_tl { \pecha_oddright: }
        }{
          \tl_set:Nn \l_pecha_theleft_tl { \pecha_evenleft: }
          \tl_set:Nn \l_pecha_theright_tl { \pecha_evenright: }
        }
        \bool_if:NTF \g_pecha_rotate_bool {
          \setbox\@outputbox\hbox{
            \rotatebox{180}{\pecha_selectframe:n {\@outputbox}}
          }
        }{
          \setbox\@outputbox\hbox{\pecha_selectframe:n {\@outputbox}}
        }
        \stepcounter{pechasheet}
      }
    }
    \shipout\vbox to \paperheight{
      \vss
      \hbox to \paperwidth{
        \hss
        \box\@outputbox
        \hss
      }
      \vss
    }
    \set@typeset@protect
  \group_end:
  \stepcounter{page}
}

\cs_new:Npn \pecha_selectframe:n #1 {
  \bool_if:NTF \g_pecha_noframe_bool {
    \hbox{#1}
  }{
    \bool_if:NTF \g_pecha_fancyframe_bool {
      \pecha_fancyframe:n {#1}
    }{
      \bool_if:NTF \g_pecha_singleframe_bool {
        \pecha_singleframe:n {#1}
      }{
        \pecha_doubleframe:n {#1}
      }
    }
  }
}

\newcommand{\pechaglosssize}{\fontsize{6pt}{7pt}\selectfont}
\newcommand{\pechaglosscolor}{\color{gray}}
\newcommand{\pechaglossfont}{\normalfont\pechaglosssize}
\newcommand{\pechatextsize}{\large}

\prop_new:N \g_pecha_gloss_prop
\prop_new:N \g_pecha_seen_prop
\seq_new:N \g_pecha_gloss_order_seq

\cs_new_protected:Npn \pecha_gloss_render:nnn #1#2#3 {
  \prop_if_in:NnTF \g_pecha_seen_prop {#1} {
    { \pechatibfont #1 }
    \skip_horizontal:n { 0.3em plus 0.1em minus 0.05em }
    \tex_penalty:D 0
  }{
    \prop_gput:Nnn \g_pecha_seen_prop {#1} {1}
    \prop_gput:Nnn \g_pecha_gloss_prop {#1} {#2}
    \seq_gput_right:Nn \g_pecha_gloss_order_seq { {#1}{#2}{#3} }
    \group_begin:
      \nobreak\kern 0.3em
      \smash{\raisebox{1.2em}{\makebox[0pt][c]{\pechaglossfont\pechaglosscolor#2}}}%
      {\pechatibfont#1}%
    \group_end:
    \skip_horizontal:n { 0.3em plus 0.1em minus 0.05em }
    \tex_penalty:D 0
  }
}

\cs_new_protected:Npn \pecha_gloss_silent:nnn #1#2#3 {
  \prop_gput:Nnn \g_pecha_gloss_prop {#1} {#2}
  \seq_gput_right:Nn \g_pecha_gloss_order_seq { {#1}{#2}{#3} }
}

\NewDocumentCommand{\pg}{s m m +o}{
  \IfBooleanTF{#1} {
    \IfNoValueTF{#4} {
      \pecha_gloss_silent:nnn {#2}{#3}{}
    }{
      \pecha_gloss_silent:nnn {#2}{#3}{#4}
    }
  } {
    \IfNoValueTF{#4} {
      \pecha_gloss_render:nnn {#2}{#3}{}
    }{
      \pecha_gloss_render:nnn {#2}{#3}{#4}
    }
  }
}

\NewDocumentCommand{\pechagloss}{s m m +o}{
  \IfBooleanTF{#1} {
    \IfNoValueTF{#4} {
      \pecha_gloss_silent:nnn {#2}{#3}{}
    }{
      \pecha_gloss_silent:nnn {#2}{#3}{#4}
    }
  } {
    \IfNoValueTF{#4} {
      \pecha_gloss_render:nnn {#2}{#3}{}
    }{
      \pecha_gloss_render:nnn {#2}{#3}{#4}
    }
  }
}

\newcommand{\pechatrans}[1]{%
  \par\vskip 2pt
  \bgroup
    \parskip=0pt
    \normalfont\small\itshape
    \setlength{\leftskip}{1.5em}
    #1%
  \egroup
  \par\vskip 2pt
}

\NewDocumentEnvironment{pecha}{}{%
  \par \raggedright \sloppy \parindent=0pt
  \parskip=4pt
  \hfuzz=0.5em
  \pechatibfont \pechatextsize
}{%
  \par
}

\newcommand{\pechatext}[1]{\begin{pecha}#1\end{pecha}}

\newlength{\pechaglossarycolsep}
\setlength{\pechaglossarycolsep}{2em}

\cs_new_protected:Npn \pecha_print_glossary_entry:nnn #1#2#3 {
  \hbox{
    \hbox_to_wd:nn { 0.28\textwidth } { \raggedleft { \pechatibfont #1 } \hfil }
    \hbox_to_wd:nn { \pechaglossarycolsep } { \hfil }
    \hbox_to_wd:nn { 0.44\textwidth } { #2 \hfil }
  }
  \tl_if_empty:nF {#3} {
    \par
    \hbox{
      \hbox_to_wd:nn { 0.28\textwidth } { \hfil }
      \hbox_to_wd:nn { \pechaglossarycolsep } { \hfil }
      \hbox_to_wd:nn { 0.44\textwidth } { \footnotesize\itshape #3 \hfil }
    }
  }
  \par\vskip 2pt
}

\NewDocumentCommand{\printpechaglossary}{o}{
  \clearpage
  \bool_set_true:N \g_pecha_noframe_bool
  \par
  \vskip 12pt
  \group_begin:
    \centering
    \textbf{\Large \pecha_glossary_title:}\par\vskip 12pt
  \group_end:
  \seq_if_empty:NTF \g_pecha_gloss_order_seq {
    \noindent \textit{No~glossary~entries~defined.}
  }{
    \seq_map_inline:Nn \g_pecha_gloss_order_seq {
      \pecha_print_glossary_entry:nnn ##1
    }
  }
  \par
  \bool_set_false:N \g_pecha_noframe_bool
}

\newcommand{\pechaglossarytitle}[1]{
  \tl_gset:Nn \g_pecha_glossary_title_tl {#1}
}
\tl_new:N \g_pecha_glossary_title_tl
\tl_gset:Nn \g_pecha_glossary_title_tl {Glossary}

\cs_new:Npn \pecha_glossary_title: {
  \tl_use:N \g_pecha_glossary_title_tl
}

\newcommand{\setpechafont}[1]{
  \bool_if:NTF \g_pecha_unicode_bool {
    \RenewDocumentCommand{\pechatibfont}{}{\fontspec[Script=Tibetan]{#1}}
  }{
    \ClassWarning{pecha}{setpechafont~has~no~effect~in~wylie~mode}
  }
}

\newcommand{\settranslationfont}[1]{
  \bool_if:NTF \g_pecha_unicode_bool {
    \newfontface\pechatranslationfont{#1}
  }{
    \ClassWarning{pecha}{settranslationfont~has~no~effect~in~wylie~mode}
  }
}

\newcommand{\setpechamargins}[3]{
  \dim_set:Nn \g_pecha_outermargin_dim {#1}
  \dim_set:Nn \g_pecha_innermargin_horiz_dim {#2}
  \dim_set:Nn \g_pecha_innermargin_vert_dim {#3}
}

\bool_if:NT \g_pecha_unicode_bool {
  \newfontfamily\pechatibfont[Script=Tibetan]{Noto~Serif~Tibetan}
  \providecommand{\pechatranslationfont}{\normalfont}
}

\AtBeginDocument{
  \bool_if:NT \g_pecha_unicode_bool {
    \XeTeXlinebreaklocale "bo"
    \XeTeXlinebreakskip 0pt plus 0.1pt minus 0.05pt
    \@ifundefined{pechatibfont}{
      \ClassWarning{pecha}{No~Tibetan~font~set.~Use~\string\setpechafont\space to~set~one.}
    }{}
  }
}

\endinput