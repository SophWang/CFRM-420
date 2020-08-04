CFRM 420 Autumn 2019
========================================================
author: Nam Lee
date: 
autosize: false
transition: rotate


Chapter 11: transform-both-sides (TBS) regression, Box-Cox transformation model, binary response regression, least-trimmed sum of squares (LTS) regression

Chapter 21: local polynomial regression, optimal bandwidth, spline regression


$\newcommand{\eps}{\varepsilon}$
$\newcommand{\Var}{\operatorname{Var}}$
$\newcommand\Cov{\operatorname{Cov}}$
$\newcommand{\sig}{\sigma}$
$\newcommand{\al}{\alpha}$
$\newcommand{\Xb}{\bar{X}}$
$\newcommand{\Yb}{\bar{Y}}$
$\newcommand\Eb{\mathbb{E}}$
$\newcommand\Pb{\mathbb{P}}$
$\newcommand\Qb{\mathbb{Q}}$
$\newcommand\Rb{\mathbb{R}}$
$\newcommand\Zb{\mathbb{Z}}$
$\newcommand\Nb{\mathbb{N}}$
$\newcommand\Av{\textbf{A}}$
$\newcommand\Fv{\textbf{F}}$
$\newcommand\Gv{\textbf{G}}$
$\newcommand\Hv{\textbf{H}}$
$\newcommand\Kv{\textbf{K}}$
$\newcommand\Iv{\textbf{I}}$
$\newcommand\Pv{\textbf{P}}$
$\newcommand\Sv{\textbf{S}}$
$\newcommand\Xv{\textbf{X}}$
$\newcommand\Yv{\textbf{Y}}$
$\newcommand\Zv{\textbf{Z}}$
$\newcommand\av{\mathbf{a}}$
$\newcommand\xv{\mathbf{x}}$
$\newcommand\yv{\mathbf{y}}$
$\newcommand\zv{\mathbf{z}}$
$\newcommand\Cv{\mathbf{C}}$
$\newcommand\mv{\mathbf{m}}$
$\newcommand\nv{\mathbf{n}}$
$\newcommand\pv{\mathbf{p}}$
$\newcommand\sv{\mathbf{s}}$
$\newcommand\wv{\mathbf{w}}$
$\newcommand\Wv{\textbf{W}}$
$\newcommand\betav{{\boldsymbol\beta}}$
$\newcommand\etav{{\boldsymbol\eta}}$
$\newcommand\epsv{{\boldsymbol\varepsilon}}$
$\newcommand\delv{{\boldsymbol\delta}}$
$\newcommand\Lamv{{\boldsymbol\Lambda}}$
$\newcommand\lamv{{\boldsymbol\lambda}}$
$\newcommand\muv{{\boldsymbol\mu}}$
$\newcommand\piv{{\boldsymbol\pi}}$
$\newcommand\Pbh{\widehat{\Pb}}$
$\newcommand\Ebh{\widehat{\Eb}}$
$\newcommand\Qh{\widehat{Q}}$
$\newcommand\Ih{\widehat{I}}$
$\newcommand\pih{\widehat{\pi}}$
$\newcommand\Pih{\widehat{\Pi}}$
$\newcommand\Wh{\widehat{W}}$
$\newcommand\Fh{\widehat{F}}$
$\newcommand\Yh{\widehat{Y}}$
$\newcommand\Yvh{\widehat{\Yv}}$
$\newcommand\Ah{\widehat{\Ac}}$
$\newcommand\uh{\widehat{u}}$
$\newcommand\vh{\widehat{v}}$
$\newcommand\fh{\widehat{f}}$
$\newcommand\hh{\widehat{h}}$
$\newcommand\Bh{\widehat{B}}$
$\newcommand\rhoh{\widehat{\rho}}$
$\newcommand\nuh{\widehat{\nu}}$
$\newcommand\varphih{\widehat{\varphi}}$
$\newcommand\alh{\widehat{\al}}$
$\newcommand\thetah{\widehat{\theta}}$
$\newcommand\betah{\widehat{\beta}}$
$\newcommand\betavh{\widehat{\boldsymbol\beta}}$
$\newcommand\kaph{\widehat{\kappa}}$
$\newcommand\sigh{\widehat{\sigma}}$
$\newcommand\epsh{\widehat{\eps}}$
$\newcommand\epsvh{\widehat{\epsv}}$
$\newcommand\epst{\widetilde{\eps}}$
$\newcommand\muh{\widehat{\mu}}$
$\newcommand\dd{\mathrm{d}}$
$\newcommand\ee{\mathrm{e}}$



Transform-both-sides (TBS)
=========

* TBS regression is a parametric nonlinear regression model. Its estimation and diagnostic is similar to other such models

* The TBS regression is mainly used as a remedy for shortcomings in regression models, e.g. non-constant variance or non-normality of residuals

* A function $h$ is said to be _monotonic_ if it is either increasing or decreasing but not both.  For example,
    + $\sin(x)$ is not monotoic.  
    + $h(x) = \exp(x)$ is monotoic 
    + $h(x) = \exp(-x)$ is monotic



Mathematics of TBS
====== 

* For any monotonic function $h(x)$, the following models are equivalent: 
$$
\begin{aligned}
Y_n & = f(\Xv_n;\betav)\\
h(Y_n) & = h\left(f(\Xv_n;\betav)\right)
\end{aligned}
$$

* In a TBS regression, one applies a monotonic function to both the response
variable and the regression function 
$$
\begin{align*}
Y_n & = f(\Xv_n;\betav) + \eps_n\\
h(Y_n) & = h\left(f(\Xv_n;\betav)\right) + \nu_n
\end{align*}
$$
Note, however, that the two models are not equivalent because of the noise term

Credit Default with NLS (first attempt)
=========
<font size='6'>































```
Error in file(file, "rt") : cannot open the connection
```
