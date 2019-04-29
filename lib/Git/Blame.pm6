use v6.c;
unit class Git::Blame:ver<0.0.1>;


submethod new( $file ) {
    
    my @blame = qqx/git blame -e $file/;
    my @lines;
    for @blame -> $line {
        CATCH {
	    default {
	        say "Error in $file and $line";
	        say .backtrace;
	    }
        }
        $line ~~ /$<sha1>=[ \w+ ] \s+ "(<" $<email> = [ .+? ] ">" \s+ $<date>=[ \S+ \s+ \S+ \s+ \S+ ]/; 
        @lines.push: { sha1 => ~$<sha1>, email => ~$<email>, date => ~$<date> };
    }
    say @lines;
}

=begin pod

=head1 NAME

Git::Blame - Examine who's worked on a file

=head1 SYNOPSIS

=begin code :lang<perl6>

use Git::Blame;

=end code

=head1 DESCRIPTION

Git::Blame is ...

=head1 AUTHOR

JJ Merelo <jjmerelo@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright 2019 JJ Merelo

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
