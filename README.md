[![Build Status](https://travis-ci.org/JJ/perl6-git-blame.svg?branch=master)](https://travis-ci.org/JJ/perl6-git-blame)

NAME
====

Git::Blame - Examine who's worked on a file

SYNOPSIS
========

```perl6
use Git::Blame;

my $blamer = Git::Blame.new( "t/01-basic.t" );
say "Lines ",  $git-blame.lines();
say "Chunks ", $git-blame.chunks();
for $git-blame.SHAs.keys -> $k {
    say $git-blame.SHAs{$k}<email>, " → ",  $git-blame.SHAs{$k}<range>;
}
```

DESCRIPTION
===========

Git::Blame is a module that uses `git blame` to extract information from a single file in a repository and process it in a number of ways. It's mainly geared to tally contributions via lines changed, but it can also be modified and used to do some repository mining.

    It works, for the time being, with single files.

METHODS
=======

lines()
-------

Returns an Array with all the lines in the file

chunks()
--------

Returns an array of hashes, every one of them with a chunk with range, author email and sha1 of the commit involved.

SHAs() 
-------

Returns a hash that uses as keys the sha1 of the commit, and as values arrays of all chunks changed in that commit

author-lines()
--------------

Returns a hash that uses the author emails as keys and the number of lines done in the current version as value.

AUTHOR
======

JJ Merelo <jjmerelo@gmail.com>

COPYRIGHT AND LICENSE
=====================

Copyright 2019 JJ Merelo

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

