# blog

this repo contains the code for my [blog][1], it uses jekyll for generating static pages.

## build locally

* install ruby, you may follow instructions from [jekyll docs][2].
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

[1]: https://rustyelectron.live
[2]: https://jekyllrb.com/docs/installation/#requirements
[3]: https://wiki.archlinux.org/title/ruby#Setup
[4]: https://jekyllrb.com/docs/github-pages/