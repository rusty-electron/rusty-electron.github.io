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

As evident, they are identical,

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

### Achilles and the tortoise

One of Zeno's paradoxes, "Achilles and the tortoise" is a famous Greek paradox where the possibility of infinite but bounded sets is explored. We imagine the situation where Achilles and a tortoise are separated by a distance of 1 km. Achilles is able to move 10 times faster than the tortoise. Now the Greeks reasoned that by the time Achilles covers a distance of 1km, the tortoise would have moved 100m ahead. Similarly, by the time he moved 100m, the tortoise would get ahead by 10m. Achilles would then cover this 10m and but the tortoise was already ahead by 1m. Through this scenario, the Greeks came to the paradoxical conclusion that Achilles would never be able to catch up to the tortoise.

<div style="text-align: center;">
    <img style="height:380px" src="https://upload.wikimedia.org/wikipedia/commons/thumb/6/66/Zeno_Achilles_Paradox.png/768px-Zeno_Achilles_Paradox.png">
    <p class="caption">Fig: \(g(x) = e^{x\ln a}\)</p>
</div>


But of course this is not true, the Greeks had not yet grasped the idea of a bounded monotonic sequences and hence, came to this wrong conclusion.

We start with a similar assumption with a different scale, imagine that Achilles and the tortoise are 1 m apart and Achilles has a speed of 1m/s while the tortoise has a speed of 0.01m/s. With his speed, Achilles can cover the 1m in 1s, in the same 1 second the tortoise will move 0.01m which Achilles will cover in $$\frac{1}{100} s$$. Similarly, the next distance travelled by the tortoise can be covered by Achilles in $$\frac{1}{100}\cdot\frac{1}{100} = \frac{1}{100^2}s$$. This means that the time needed by Achilles to overtake the tortoise is given by the series:

$$
1+\frac{1}{100}+\frac{1}{100^{2}}+\cdots=\sum_{i=0}^{\infty} \frac{1}{100^{i}}
$$

As $$ r = \frac{1}{100} < 1 $$, by using the infinite sum formula we get:

$$
\sum_{i=0}^{\infty} \frac{1}{100^{i}}=\frac{1}{1-\frac{1}{100}}=\frac{100}{99}
$$

So Achilles would catch up to the tortoise in $$ \frac{100}{99} $$ seconds.

In the original scenario, if we assume that Achilles has a speed of 10m/s, he would catch up to the tortoise in $$ 100\cdot(1+\frac{1}{10}+\frac{1}{10^{2}}+\cdots)=100\cdot\sum_{i=0}^{\infty} \frac{1}{10^{i}} = 1000/9 = 111.11 s$$, which is less than 2 minutes.

### I can use $$(a+b)^2 = a^2 + 2ab + b^2$$

Now this is a quite common identity that we learn in early highschool and it is also the subject of many memes and posts state that they never found any use for it in their life. Yes, we don't often get to use algebra or calculus in our day to day life but it is obvious that they have their use in modern science and engineering. In a recent discussion, the usefulness of this algebraic identity was brought up again and beyond being used as a common expansion in mathematics, I could not think of any. I looked up the geometrical interpretation of the formula and decided to intelligently think of one so that the next time, this is brought up --- I can be prepared to point it out.

The one that I could think of is actually a lot contrived 🥲 but it works. I first started from the geometrical interpretation of the identity which is described below:

<div style="text-align: center;">
    <img style="width:480px" src="http://www.mathematische-basteleien.de/formel06.gif">
    <p class="caption">Fig: Visual illustration for \((a+b)^2\)</p>
</div>

The area covered by $$ (a+b)^2 $$ is a square plot that is made up of two smaller square plots of area, $$a^2$$ and $$b^2$$ and two rectangular plots of area, $$ab$$ and $$ba$$. The arrangement shown above is not the only one, we can swap the position of the pieces provided the combined shape of the square doesn't change.

> While looking it up, I also came across this amazing [website](http://www.mathematische-basteleien.de/formula.htm) that has geometrical illustrations for a lot of algebraic identities.