use v6.c;
use Test;
use Git::Blame;

my $git-blame = Git::Blame.new( "t/01-basic.t" );
isa-ok $git-blame, Git::Blame, "Correct class";

done-testing;
