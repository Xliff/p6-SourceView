use v6.c;


use GTK::Raw::Types;
use SourceViewGTK::Raw::Types;
use SourceViewGTK::Raw::Gutter;

use GTK::Roles::Types;
use GLib::Roles::Object;

use SourceViewGTK::GutterRenderer;

class SourceViewGTK::Gutter {
  also does GTK::Roles::Types;
  also does GLib::Roles::Object;
  
  has GtkSourceGutter $!sg;
  
  submethod BUILD (:$gutter) {
    self!setObject($!sg = $gutter); 
  }
  
  method SourceViewGTK::Raw::Types::GtkSourceGutter { $!sg }
  
  method get_renderer_at_pos (Int() $x, Int() $y) {
    my gint ($xx, $yy) = self.RESOLVE-INT($x, $y);
    SourceViewGTK::GutterRenderer.new(
      gtk_source_gutter_get_renderer_at_pos($!sg, $xx, $yy)
    );
  }

  method get_type {
    gtk_source_gutter_get_type();
  }

  method get_view {
    ::('SourceViewGTK::View').new(
      gtk_source_gutter_get_view($!sg)
    );
  }

  method get_window_type {
    GtkTextWindowType( gtk_source_gutter_get_window_type($!sg) );
  }

  method insert (GtkSourceGutterRenderer() $renderer, Int() $position) {
    my gint $p = self.RESOLVE-INT($position);
    so gtk_source_gutter_insert($!sg, $renderer, $p);
  }

  method queue_draw {
    gtk_source_gutter_queue_draw($!sg);
  }

  method remove (GtkSourceGutterRenderer() $renderer) {
    gtk_source_gutter_remove($!sg, $renderer);
  }

  method reorder (GtkSourceGutterRenderer() $renderer, Int() $position) {
    my gint $p = self.RESOLVE-INT($position);
    gtk_source_gutter_reorder($!sg, $renderer, $position);
  }
  
}

  
