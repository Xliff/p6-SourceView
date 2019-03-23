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
        my $ee;
        $ee.push: $e[0].Str.trim;
        $ee.push: $n if $n.chars;
        @e.push: $ee;
      }
      %enums{$l<enum><rn>} = @e;
    }
  }
  
  for %enums.keys -> $k {
    #say %enums{$k}.gist;
    my $m = %enums{$k}.map( *.map( *.elems ) ).max;
    say "  our enum {$k} { $m == 2 ?? '(' !! '<' }";
    for %enums{$k} -> $ek {
      for $ek -> $el {
        for $el.List -> $eel {
          given $m {
            when 1 {
              say "      { $eel[0] } ";
            }
            when 2 {
              say "      { $eel[0] } => { $eel[1] }"; 
            }
          }
        }
      }
    }
    say "  { $m == 2 ?? ')' !! '>' };\n";
  }
}
