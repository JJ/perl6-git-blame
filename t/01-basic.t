use v6.c;
use Test;
use Git::Blame;

my $git-blame = Git::Blame.new( "t/01-basic.t" );
isa-ok $git-blame, Git::Blame, "Correct class";
ok( $git-blame.lines(), "Lines extracted" );
ok( $git-blame.chunks(), "Chunks extracted" );
is 1 ~~ $git-blame.chunks[0], True, "First line in first range";
isa-ok $git-blame.lines[0]<sha1>, Str, "There's a correct sha1 here";

done-testing;
