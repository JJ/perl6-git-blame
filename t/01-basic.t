use v6.c;
use Test;
use Git::Blame;

my $git-blame = Git::Blame.new( "01-basic.t" );

done-testing;
