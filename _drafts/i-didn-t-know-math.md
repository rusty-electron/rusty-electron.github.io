---
layout: post
title: I didn't know math
tags: math
katex: true
---
For the past few weeks, I have been studying a book on calculus with the aim of relearning it with better foundations. The book that I am following is an old but classic book written by L. V. Tarasov which is targeted towards high school students. I am hopeful that I shall be able to finish it by the end of this month. I do plan on making either a video or a blog post summarizing its contents. I am also studying an MOOC on Calculus parallelly, this course has alotted two weeks on precalculus and this is where I got to learn a lot of basic mathematics that I didn't learn in my high school curriculum (probably because I wasn't paying attention 🙂). 

### exponential function and $$e$$

I always found the exponential function very mysterious. I mean how is the slope of this function at every point the same value, the *Euler's number*, $$ e $$. And the same goes for the second derivative. And how can this number, $$e$$ with an imaginary power be equal to the sum of two sinosoids. 

Just amazing! 

I first became interested in it after watching this video by [numberphile](https://www.youtube.com/watch?v=AuA2EAgAegE). But unfortunately, right now we are not going explore that. We are going to understand how any exponential function of the form $$ f(x) = a^x, a > 0 $$ is basically a scaled version of the function $$f(y) = e^y$$. In order to prove this, we need the help of the inverse function of $$f(x) = e^x$$, which is the *logarithmic* function, $$f^{-1}(x)=\log_e(x)$$ or $$ln(x)$$.

**Proof:**

$$  \begin{align}
y &= a^x \\
\end{align} $$

we apply natural logarithm on both sides,

$$ \begin{align}
\ln y &= \ln a^x  \\

\ln y &= x \ln a
\end{align} $$

and now apply the exponential function, $$e$$

$$ \begin{align}
e^{\ln y} = e^{x \ln a} \\
y = e^{x \ln a} \\
\end{align} $$

As evident, they are graphically identical,

<div class="two-col">
    <div>
        <img src="/assets/images/math-know/plot-log.png">
        <p class="caption">Fig: \(f(x)=a^x\)</p>
    </div>

    <div>
        <img src="/assets/images/math-know/plot-log-2.png">
        <p class="caption">Fig: \(g(x) = e^{x\ln a}\)</p>
    </div>
</div>
