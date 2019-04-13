use v6.c;

unit package SourceViewTests;

sub process_ui($basename) is export {
  my $dir = 'ui';
  $dir = "t/{ $dir }" unless $dir.IO.d;
  
  die 'Cannot find UI directory!' unless $dir.IO.e && $dir.IO.d;
  die 'Cannot find UI file!' unless 
    (my $filename = "{ $dir }/{ $basename }").IO.e;
  my $contents = $filename.IO.slurp;
  
  my regex quoted { \" ~ \" (<-[\"]>+) }
  $contents ~~ s:g{ '<template class='<quoted>' parent='<quoted> } =
                  "<object class=$/<quoted>[1] id=$/<quoted>[0]";
  $contents ~~ s:g!'</template>'!</object>!;
  $contents;
}
