---
layout: post
title: Trying to install Terminology on OSX
---

... and it's not going well.

I was trying to find a local terminal emulator to provide the [GateOne](http://liftoffsoftware.com/Products/GateOne)
functionality of being able to `cat` images and show them in the terminal. This led me to
[this StackOverflow answer](http://askubuntu.com/a/426843) where the person linked a fairly cool video of
[Terminology](https://www.enlightenment.org/about-terminology), a terminal emulator by the creators of
[Enlightenment](https://www.enlightenment.org/start), a very snazzy window manager. The problem I had is, it doesn't
seem to have binaries for OSX, and I really wanted to try it out. So I started trying stuff

Here's some pointers so you can skip a couple steps:

* As of Oct 2015, the versions of efl and elementary in homebrew are 1.14, but the terminology source code expects 1.15. You
  can either get older source code, or try building efl and elementary from scratch. I chose the latter to start with.
* I installed the homebrew versions of the software first to pull all dependencies. After this you can run
  `brew unlink efl`/`brew unlink elementary` to clean up.
* efl appears to reference a missing file, `src/lib/ecore_audio/ecore_audio_obj_out_core_audio.c`. It appears to be
  an optional extra? I removed all references to it in `src/Makefile_Ecore_Audio.am`
* You then have to install automake. Oh, and it has to be automake-1.14.1. To save some time digging through the git log, try this:
  * `wget https://github.com/Homebrew/homebrew/raw/bc1f9b2f4fe36a940f5628a9e5b02aa0f938bd6c/Library/Formula/automake.rb -O /usr/local/Library/Formula/automake.rb`
  * `brew unlink automake`
  * `brew install automake`
* The last error I encountered was a clang error for missing symbols for x86_64. I have no idea how to resolve this,
  so I'm leaving it here. The truncated error is below:

      CCLD     lib/eio/libeio.la    
    Undefined symbols for architecture x86_64:    
    ...    
    ld: symbol(s) not found for architecture x86_64    
    clang: error: linker command failed with exit code 1 (use -v to see invocation)

Now I'm going to just go ahead and use terminology 1.14. Hopefully that just works.
