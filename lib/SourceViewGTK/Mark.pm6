use v6.c;

use Method::Also;

use SourceViewGTK::Raw::Types;
use SourceViewGTK::Raw::Mark;

use GLib::Roles::Object;

class SourceViewGTK::Mark {
  also does GLib::Roles::Object;

  has GtkSourceMark $!sm;

  submethod BUILD (:$mark) {
    self!setObject($!sm = $mark);
  }

  method SourceViewGTK::Raw::Definitions::GtkSourceMark
    is also<
      GtkSourceMark
      SourceMark
    >
  { $!sm }

  multi method new (GtkSourceMark $mark, :$ref = True) {
    return unless $mark;

    my $o = self.bless(:$mark);
    $o.ref if $ref;
    $o;
  }
  multi method new (Str() $name, Str() $category) {
    my $m = gtk_source_mark_new($name, $category);

    $m ?? self.bless( mark => $m ) !! Nil;
  }

  method get_category is also<get-category> {
    gtk_source_mark_get_category($!sm);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_source_mark_get_type, $n, $t );
  }

  method next (Str() $category, :$raw = False) {
    my $m = gtk_source_mark_next($!sm, $category);

    $m ??
      ( $raw ?? $m !! SourceViewGTK::Mark.new($m) )
      !!
      Nil;
  }

  method prev (Str() $category, :$raw = False) {
    my $m = gtk_source_mark_prev($!sm, $category);

    $m ??
      ( $raw ?? $m !! SourceViewGTK::Mark.new($m) )
      !!
      Nil;
  }

}
