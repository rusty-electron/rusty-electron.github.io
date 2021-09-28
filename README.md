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

## Optional: `jemdoc` resume

I also host a jemdoc resume page at [`rustyelectron.live/resume`](https://rustyelectron.live/resume/). See [jemdoc][5]'s page for instructions to learn to prepare a jemdoc site.

### steps to host

Follow these instructions to host your jemdoc page at `yourblog.com/<path>`.
1. create `<path>` directory in your jekyll site folder
2. generate html files using `jemdoc` or use my `makefile` (see below)
3. place them in your `<path>` directory

> Note that you must have an `index.html` file in your <path> directory

Jekyll will copy your `<path>` directory to the `_site` directory and your jekyll build will contain the jemdoc generated html files. If all goes well, your jemdoc pages will be hosted at `yourblog.com/<path>`.

#### makefile for jemdoc

```makefile
DOCS=index extra education # replace with the name(s) of jemdoc page(s) you created

# index -> index.html -> html/index.html
HDOCS=$(addsuffix .html, $(DOCS))
PHDOCS=$(addprefix html/, $(HDOCS))

.PHONY : docs
docs : $(PHDOCS)

.PHONY : update
update : $(PHDOCS)
	@echo -n 'Copying to server...'
	cp $(PHDOCS) <path directory>
	@echo ' done.'

html/%.html : %.jemdoc MENU
	jemdoc -o $@ $<

.PHONY : clean
clean :
	-rm -f html/*.html

```

> `jemdoc` is quite old and in modern web, it has its shortcomings. I have future plans to rewrite jemdoc in python 3 and update it to use html5.

[1]: https://rustyelectron.live
[2]: https://jekyllrb.com/docs/installation/#requirements
[3]: https://wiki.archlinux.org/title/ruby#Setup
[4]: https://jekyllrb.com/docs/github-pages/
[5]: http://jemdoc.jaboc.net/
