use v6.c;

use Method::Also;

use SourceViewGTK::Raw::Types;
use SourceViewGTK::Raw::Gutter;

use GLib::Roles::Object;

use SourceViewGTK::GutterRenderer;

class SourceViewGTK::Gutter {
  also does GLib::Roles::Object;

  has GtkSourceGutter $!sg;

  submethod BUILD (:$gutter) {
    self!setObject($!sg = $gutter);
  }

  method SourceViewGTK::Raw::Definitions::GtkSourceGutter
    is also<GtkSourceGutter>
  { $!sg }

  method new (GtkSourceGutter $gutter) {
    $gutter ?? self.bless(:$gutter) !! Nil;
  }

  method get_renderer_at_pos (Int() $x, Int() $y, :$raw = False)
    is also<get-renderer-at-pos>
  {
    my gint ($xx, $yy) = ($x, $y);

    my $r = gtk_source_gutter_get_renderer_at_pos($!sg, $xx, $yy);

    $r ??
      ( $raw ?? $r !! SourceViewGTK::GutterRenderer.new($r) )
      !!
      Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_source_gutter_get_type, $n, $t );
  }

  method get_view (:$raw = False)
    is also<
      get-view
      view
    >
  {
    my $v = gtk_source_gutter_get_view($!sg);

    $v ??
      ( $raw ?? $v !! ::('SourceViewGTK::View').new($v) )
      !!
      Nil;
  }

  method get_window_type
    is also<
      get-window-type
      window_type
      window-type
    >
  {
    GtkTextWindowTypeEnum( gtk_source_gutter_get_window_type($!sg) );
  }

  method insert (GtkSourceGutterRenderer() $renderer, Int() $position) {
    my gint $p = $position;

    so gtk_source_gutter_insert($!sg, $renderer, $p);
  }

  method queue_draw is also<queue-draw> {
    gtk_source_gutter_queue_draw($!sg);
  }

  method remove (GtkSourceGutterRenderer() $renderer) {
    gtk_source_gutter_remove($!sg, $renderer);
  }

  method reorder (GtkSourceGutterRenderer() $renderer, Int() $position) {
    my gint $p = $position;

    gtk_source_gutter_reorder($!sg, $renderer, $p);
  }

}
