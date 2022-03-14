---
layout: post
title: my note-making journey and vimwiki
date: 2021-05-30 21:00 +0530
tags: productivity
---

I like to make digital notes.

#### context and evernote rant
I first started creating organized notes on `evernote` but this goes back to when I still used `windows` as my os. The experience with evernote was fine but like most freemium software it came with restrictions like - use limited to only a few devices, I also did not like the UI much but the nail in the coffin was the unavailability of `markdown` support because of which I stopped using it. I read several posts on the evernote forums where users repeatedly requested for this feature but in my two years of using evernote it was not added and still has not been added at the time of writing. 

#### enter joplin
When I switched to linux, I came across `joplin` and when I found out that it has `markdown` support I instantly installed and started using it. It is a good tool for maintaining notes and it is at par with evernote at doing so. During this time I was a linux noob and found the sync setup quite strange but now I realize that the self-hosting feature is actually quite essential and it provides users, the freedom of choice. One can setup the `joplin` database at their server using tools like `nextcloud` or `webDAV` or one can go the easy way and setup sync with cloud storage providers like dropbox. 

An important feature that `evernote` has and is a must for all "serious" note taking software is the availability of an android app as it is highly likely that you would be reading or making minor edits away from your computer, like when you are reviewing your notes before an interview or outside your exam hall. `joplin` has one too and it works great although I must point out that the UI of the mobile app really needs a lot of work or at least a theming system would be nice. Talking about UI, `joplin`'s pc client has two types of UI and for linux they come in separate packages, the first is `joplin-desktop` which is an electron-based app that offers highly customizability using user-defined css files. The other is the TUI `joplin` package which offers the same core functionality on the terminal. It is obvious that the TUI does not display images or any kind of rich graphics (although displaying images on the terminal is possible and maybe added later) and therefore, in my workflow I use the TUI when I need to write text-based notes while I use the desktop app when I need to work with images and LaTeX math.

#### vimwiki
I am satisfied with `joplin` when my goal is to create long notes like that of a course or a book. But in the event that I need to note down something quick like some commands or a small note for later, I generally use `vim` to create a `markdown` file in my working or `~` directory. But this practice has lead to such files being cluttered all over my drive. So here I am met with two choices:

1. create an organized folder for "quick notes" by taking some time to `cd` into this directory
2. create note at current directory or `~` directory and create a mess that is hard to retrieve or query even with `find` and `fzf` combination.

Here [`vimwiki`][1] is one choice that provides a balance between the two issues. It provides a centralized *Index* page which is the starting point for all wiki pages, much like what we find in sites like *wikipedia*. Each of the entries on this page lead to another wiki page that may contain any text content similar to what is found generally in `markdown` files, although `vimwiki` by default uses its own kind of syntax but it is possible to easily switch to `markdown` if desired. Yes, it does require one to use a terminal and open `vim` but it can be turned into a breeze by using bash aliases like `vim -c ':VimwikiIndex'` which will put us right into the main *Index* page of our wiki. Moreover, using `vimwiki` it is much easier to navigate from one note to the next. The second issue is easily addressed as all the notes of our wiki are stored in a single directory (although it is possible to create multiple wikis with their own *Index* page) and therefore, it is also possible to search the contents of individual notes easily by using tools like `find` or `ripgrep`.

In my current workflow, I use both `joplin` and `vimwiki` for digital notes while for digital handwritten notes I prefer [`xournal++`][2]. As mentioned earlier I mainly use `joplin` for course or book notes that can grow upto several pages and typically contain figures and images. `vimwiki` fulfills my need for a place to store short notes and todo lists that have a short lifespan like grocery or shopping lists.

[1]: https://github.com/cristianpb/vimwiki
[2]: https://xournalpp.github.io/