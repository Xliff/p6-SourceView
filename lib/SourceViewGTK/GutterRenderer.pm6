use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;
use SourceViewGTK::Raw::Types;
use SourceViewGTK::Raw::GutterRenderer;

use GTK::Compat::RGBA;
use GTK::Compat::Value;

use GTK::Roles::Properties;
use GTK::Roles::Types;
use SourceViewGTK::Roles::Signals::GutterRenderer;

use GTK::Compat::Value;

class SourceViewGTK::GutterRenderer {
  also does GTK::Roles::Properties;
  also does GTK::Roles::Types;
  also does SourceViewGTK::Roles::Signals::GutterRenderer;
  
  has GtkSourceGutterRenderer $!sgr;
  
  submethod BUILD (:$renderer) {
    self.setGutterRenderer($renderer);
  }
   
  submethod DESTROY {
    #self.disconnect-all($_) for %!signals-sgr;
  }
  
  method SourceViewGTK::Raw::Types::GtkSourceGutterRenderer { $!sgr }
  
  method new (GtkSourceGutterRenderer $renderer) {
    self.bless(:$renderer);
  }
  
  method setGutterRenderer($renderer) {
    self!setObject($!sgr = $renderer);
  }
  
  # Is originally:
  # GtkSourceGutterRenderer, GtkTextIter, GdkRectangle, GdkEvent, gpointer --> void
  # Made multi so as to not conflict with the method activate(), below.
  multi method activate {
    self.connect-activate($!sgr);
  }

  # Is originally:
  # GtkSourceGutterRenderer, GtkTextIter, GdkRectangle, GdkEvent, gpointer --> gboolean
  method query-activatable {
    self.connect-query-activatable($!sgr);
  }

  # Is originally:
  # GtkSourceGutterRenderer, GtkTextIter, GtkTextIter, GtkSourceGutterRendererState, gpointer --> void
  method query-data {
    self.connect-query-data($!sgr);
  }

  # Is originally:
  # GtkSourceGutterRenderer, GtkTextIter, GdkRectangle, gint, gint, GtkTooltip, gpointer --> gboolean
  method query-tooltip {
    self.connect-query-tooltip($!sgr);
  }

  # Is originally:
  # GtkSourceGutterRenderer, gpointer --> void
  method queue-draw {
    self.connect($!sgr, 'queue-draw');
  }
  
  method alignment_mode is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkSourceGutterRendererAlignmentMode(
          gtk_source_gutter_renderer_get_alignment_mode($!sgr)
        );
      },
      STORE => sub ($, Int() $mode is copy) {
        my guint $m = self.RESOLVE-UINT($mode);
        gtk_source_gutter_renderer_set_alignment_mode($!sgr, $m);
      }
    );
  }

  method size is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_source_gutter_renderer_get_size($!sgr);
      },
      STORE => sub ($, Int() $size is copy) {
        my gint $s = self.RESOLVE-UINT($size);
        gtk_source_gutter_renderer_set_size($!sgr, $s);
      }
    );
  }

  method visible is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_source_gutter_renderer_get_visible($!sgr);
      },
      STORE => sub ($, Int() $visible is copy) {
        my gboolean $v = self.RESOLVE-BOOL($visible);
        gtk_source_gutter_renderer_set_visible($!sgr, $v);
      }
    );
  }

  # Type: GdkRGBA
  method background-rgba is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('background-rgba', $gv)
        );
        nativecast(GTK::Compat::RGBA, $gv.object);
      },
      STORE => -> $, GdkRGBA $val is copy {
        $gv.object = $val;
        self.prop_set('background-rgba', $gv);
      }
    );
  }

  # Type: gboolean
  method background-set is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('background-set', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('background-set', $gv);
      }
    );
  }

  # Type: uint32 (GtkTextWindowType)
  method window-type is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('window-type', $gv)
        );
        GtkTextWindowType( $gv.uint );
      },
      STORE => -> $,  $val is copy {
        warn "window-type does not allow writing"
      }
    );
  }

  # Type: gfloat
  method xalign is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('xalign', $gv)
        );
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('xalign', $gv);
      }
    );
  }

  # Type: gint
  method xpad is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('xpad', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('xpad', $gv);
      }
    );
  }

  # Type: gfloat
  method yalign is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('yalign', $gv)
        );
        $gv.float;
      },
      STORE => -> $, Num() $val is copy {
        $gv.float = $val;
        self.prop_set('yalign', $gv);
      }
    );
  }

  # Type: gint
  method ypad is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('ypad', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('ypad', $gv);
      }
    );
  }
  
  multi method activate (
    GtkTextIter() $iter, 
    GdkRectangle $area, 
    GdkEvent $event
  ) {
    gtk_source_gutter_renderer_activate($!sgr, $iter, $area, $event);
  }

  method begin (
    cairo_t $cr, 
    GdkRectangle $background_area, 
    GdkRectangle $cell_area, 
    GtkTextIter() $start, 
    GtkTextIter() $end
  ) {
    gtk_source_gutter_renderer_begin(
      $!sgr, 
      $cr, 
      $background_area, 
      $cell_area, 
      $start, $end
    );
  }

  method draw (
    cairo_t $cr, 
    GdkRectangle $background_area, 
    GdkRectangle $cell_area, 
    GtkTextIter() $start, 
    GtkTextIter() $end, 
    Int() $state                  # GtkSourceGutterRendererState $state
  ) {
    my guint $s = self.RESOLVE-UINT($state);
    gtk_source_gutter_renderer_draw(
      $!sgr, 
      $cr, 
      $background_area, 
      $cell_area, 
      $start, 
      $end, 
      $s
    );
  }

  method end {
    gtk_source_gutter_renderer_end($!sgr);
  }

  method get_alignment (Num() $xalign, Num() $yalign) {
    my gfloat ($xa, $ya) = ($xalign, $yalign);
    gtk_source_gutter_renderer_get_alignment($!sgr, $xa, $ya);
  }

  method get_background (GdkRGBA $color) {
    gtk_source_gutter_renderer_get_background($!sgr, $color);
  }

  method get_padding (gint $xpad, gint $ypad) {
    my gint ($xp, $yp) = self.RESOLVE-INT($xpad, $ypad);
    gtk_source_gutter_renderer_get_padding($!sgr, $xp, $yp);
  }

  method get_type {
    gtk_source_gutter_renderer_get_type();
  }

  method get_view {
    ::('SourceViewGTK::View').new(
      gtk_source_gutter_renderer_get_view($!sgr)
    );
  }

  method get_window_type {
    GtkTextWindowType( gtk_source_gutter_renderer_get_window_type($!sgr) );
  }

  method query_activatable (
    GtkTextIter() $iter, 
    GdkRectangle $area, 
    GdkEvent $event
  ) {
    gtk_source_gutter_renderer_query_activatable($!sgr, $iter, $area, $event);
  }

  method query_data (
    GtkTextIter() $start, 
    GtkTextIter() $end, 
    guint $state                  # GtkSourceGutterRendererState $state
  ) {
    gtk_source_gutter_renderer_query_data($!sgr, $start, $end, $state);
  }

  method query_tooltip (
    GtkTextIter() $iter, 
    GdkRectangle $area, 
    Int() $x, 
    Int() $y, 
    GtkTooltip() $tooltip
  ) {
    my gint ($xx, $yy) = self.RESOLVE-INT($x, $y);
    gtk_source_gutter_renderer_query_tooltip(
      $!sgr, 
      $iter, 
      $area, 
      $xx, 
      $yy, 
      $tooltip
    );
  }

  method queue_draw {
    gtk_source_gutter_renderer_queue_draw($!sgr);
  }

  method set_alignment (Num() $xalign, Num() $yalign) {
    my gfloat ($xa, $ya) = ($xalign, $yalign);
    gtk_source_gutter_renderer_set_alignment($!sgr, $xalign, $yalign);
  }

  method set_background (GdkRGBA $color) {
    gtk_source_gutter_renderer_set_background($!sgr, $color);
  }

  method set_padding (gint $xpad, gint $ypad) {
    my gint ($xp, $yp) = self.RESOLVE-INT($xpad, $ypad);
    gtk_source_gutter_renderer_set_padding($!sgr, $xp, $yp);
  }

}
