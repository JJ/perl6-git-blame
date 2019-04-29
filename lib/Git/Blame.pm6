use v6.c;
unit class Git::Blame:ver<0.0.1>;

has @.lines;
has @.chunks;

multi method new( $file ) {
    
    my $blame = qqx/git blame -e $file/;
    my @lines;
    my @chunks;
    my $previous-sha1 = "";
    my Int $l = 1;
    my $chunk-range=1..1;
    for $blame.split("\n") -> $line {
        $line ~~ /$<sha1>=[ \w+ ] \s+ "(<" $<email> = [ .+? ] ">" \s+ $<date>=[ \S+ \s+ \S+ \s+ \S+ ]/;

        my $sha1 = ~$<sha1>;
        @lines.push: { sha1 => $sha1, email => ~$<email>, date => ~$<date> };
        
        # Process chunks
        if $sha1 eq $previous-sha1 {
            $chunk-range = ($chunk-range.min..$chunk-range.max+1);
        } else {
            @chunks.push: $chunk-range;
            $chunk-range = $l..$l;
            $previous-sha1 = $sha1;
        }

        $l++;
    }
    self.bless( :@lines, :@chunks );
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
