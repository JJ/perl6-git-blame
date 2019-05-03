use v6.c;
use Test;
use Git::Blame;

my $git-blame = Git::Blame.new( "t/01-basic.t" );
isa-ok $git-blame, Git::Blame, "Correct class";
ok( $git-blame.lines(), "Lines extracted" );
ok( $git-blame.chunks(), "Chunks extracted" );
is 1 ~~ $git-blame.chunks[0]<range>, True, "First line in first range";
my $lines = $git-blame.lines.elems;

my $ranged-lines = 0;
for $git-blame.chunks -> $c {
    say $c<range>;
    $ranged-lines += $c<range>.elems;
}
is( $lines, $ranged-lines, "All lines accounted for");
isa-ok $git-blame.lines[0]<sha1>, Str, "There's a correct sha1 here";
ok( $git-blame.SHAs(), "SHAs categorized" );
cmp-ok $git-blame.SHAs.keys.elems, ">=", 1, "More than 1 commit";

done-testing;
