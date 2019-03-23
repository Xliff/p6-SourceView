use v6.c;

my regex name {
  <[_ A..Z a..z]>+
}

# my rule enum_entry {
#   <[A..Z]>+ [ '=' [ \d+ | \d+ '<<' \d+ ] ]? ','
# }

my rule enum_entry {
  \s* ( <[_ A..Z]>+ ) ( [ '=' \d+ [ '<<' \d+ ]? ]? ) ','? \v*
}

my rule enum {
  'typedef enum' <n=name>? \v* '{' \v* <enum_entry>+ \v* '}' <rn=name>?
}

sub MAIN ($filename) {
  my $contents = $filename.IO.slurp;
  my %enums;
  
  my $m = $contents ~~ m:g/<enum>/;
  for $m.Array -> $l {
    my @e;
    for $l<enum><enum_entry> -> $el {
      for $el -> $e {
        ((my $n = $e[1].Str) ~~ s/'='//).trim;
        $n ~~ s/'<<'/+</;
        @e.push: $e[0].Str.trim;
        @e.push: $n with $n.chars;
      }
      %enums{$l<enum><rn>} = @e;
    }
  }
  %enums.gist.say;
}
