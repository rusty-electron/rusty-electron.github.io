# blog

this repo contains the code for my [blog][1], it uses jekyll for generating static pages.

## build locally

* install `ruby`, you may follow instructions from [jekyll docs][2].
> note to arch users, i had issues with PATH when I followed the official docs -- the instructions at [archwiki][3] worked (as always).

* install the rubygems, `jekyll` and `bundler`

`gem install jekyll bundler`

* clone this repo and `cd` inside

`git clone https://github.com/rusty-electron/blog.git`

* use bundler to install other requirements listed in `./Gemfile`
`bundle`

* run `bundle exec jekyll serve --livereload` to run the live server locally. At this step, jekyll generates the static pages and saves inside the folder `./_site`.

## deploy

You can easily deploy a jekyll site such as this one at github pages by following [these instructions][4]. Another way is to push this folder to a github repo and then use services such as [netlify](https://netlify.com) that allows concurrent building i.e., everytime you push changes to the github repo, netlify rebuilds your site by following your build instructions and then hosts your subsequently generated static pages.

## resume

I host a resume page at [`rusty-electron.github.io/resume`](https://rusty-electron.github.io/resume/). It is a single, self-contained page that Jekyll renders from a data file — no external tooling required.

* content lives in `_data/resume.yml` (plain YAML; the fields marked `(markdown ok)` accept simple markdown such as links and inline `code`)
* the layout and styling live in `resume/index.html`, which loops over `site.data.resume`
* **to update the resume, edit `_data/resume.yml` only** — you rarely need to touch the template

The page is print-friendly: a `@media print` block switches it to a light theme, so you can export it to PDF straight from the browser.

## Change log:
* as of Jul 2026, the resume page was rewritten from `jemdoc` to a Jekyll data-driven page (see `_data/resume.yml`).
* as of Nov 2021, the blog post page theme is based on [this blog](https://snarky.ca/).

[1]: https://rusty-electron.github.io
[2]: https://jekyllrb.com/docs/installation/#requirements
[3]: https://wiki.archlinux.org/title/ruby#Setup
[4]: https://jekyllrb.com/docs/github-pages/
