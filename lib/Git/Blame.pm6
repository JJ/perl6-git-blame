use v6.c;
unit class Git::Blame:ver<0.0.1>;

has @.lines;
has @.chunks;
has %.SHAs;

multi method new( $file ) {
    
    my $blame = qqx/git blame -e $file/;
    my @lines;
    my @chunks;
    my %SHAs;
    my $previous-sha1 = "";
    my $chunk-range=1..1;
    my @blame-lines = $blame.split("\n");
    @blame-lines.pop; # Last line off
    loop ( my $l = 0; $l <  @blame-lines.elems; $l++ ) {
	my $line = @blame-lines[$l];
	say "$l, $line";
        $line ~~ /$<sha1>=[ \w+ ] \s+ "(<" $<email> = [ .+? ] ">" \s+ $<date>=[ \S+ \s+ \S+ \s+ \S+ ]/;

        my $sha1 = ~$<sha1>;
        @lines.push: { sha1 => $sha1, email => ~$<email>, date => ~$<date> };
        
        # Process chunks
        if  $sha1 eq $previous-sha1  {
            $chunk-range = ($chunk-range.min..$chunk-range.max+1);
        } elsif $previous-sha1 ne "" {
            @chunks.push: { range => $chunk-range, sha1 => $sha1, email =>  ~$<email>};
	    %SHAs{$sha1}.push: { range => $chunk-range, email =>  ~$<email>};
            $chunk-range = ($l+1)..($l+1);
        }
	$previous-sha1 = $sha1;
	if ( $l == @blame-lines.elems -1 ) {
	    @chunks.push: { range => $chunk-range, sha1 => $sha1, email =>  ~$<email>};
	}
    }
    self.bless( :@lines, :@chunks, :%SHAs );
}

=begin pod

=head1 NAME

Git::Blame - Examine who's worked on a file

=head1 SYNOPSIS

=begin code :lang<perl6>

use Git::Blame;

my $blamer = Git::Blame.new( "t/01-basic.t" );
say "Lines ",  $git-blame.lines();
say "Chunks ", $git-blame.chunks();
for $git-blame.SHAs.keys -> $k {
    say $git-blame.SHAs{$k}<email>, " → ",  $git-blame.SHAs{$k}<range>;
}



=end code

=head1 DESCRIPTION

Git::Blame is ...

=head1 AUTHOR

JJ Merelo <jjmerelo@gmail.com>

=head1 COPYRIGHT AND LICENSE

Copyright 2019 JJ Merelo

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
