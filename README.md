# blog

this repo contains the code for my [blog][1], it uses jekyll for generating static pages.

## Build and preview locally

Install Ruby 4.0 and Bundler 4.0.16, then from the repository root run:

```sh
bundle install
bundle exec jekyll serve --future --disable-disk-cache
```

Open http://127.0.0.1:4000/ and press Ctrl+C to stop the server. The `--future` option includes future-dated posts. Math-enabled posts use `math: true` in front matter, `$...$` for inline math and `$$...$$` for display math, matching Obsidian. The remaining pages retain Kramdown.

To check the generated math and site compatibility, run:

```sh
bundle exec jekyll build --future --disable-disk-cache
bundle exec ruby scripts/check_math.rb
```

## Deploy

The GitHub Actions workflow builds and checks the site on pushes to `main`, and deploys the resulting `_site` artifact to GitHub Pages. The repository's Pages source must be set to **GitHub Actions**. Pull requests run the build and checks without deploying.

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
