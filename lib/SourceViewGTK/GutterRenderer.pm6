use v6.c;

use Method::Also;

use SourceViewGTK::Raw::Types;
use SourceViewGTK::Raw::GutterRenderer;

use GDK::RGBA;
use GLib::Value;

use GLib::Roles::Object;
use SourceViewGTK::Roles::Signals::GutterRenderer;

class SourceViewGTK::GutterRenderer {
  also does GLib::Roles::Object;
  also does SourceViewGTK::Roles::Signals::GutterRenderer;

  has GtkSourceGutterRenderer $!sgr;

  submethod BUILD (:$renderer) {
    self.setGutterRenderer($renderer);
  }

  submethod DESTROY {
    #self.disconnect-all($_) for %!signals-sgr;
  }

  method setGutterRenderer($renderer) {
    self!setObject($!sgr = $renderer);
  }

  method SourceViewGTK::Raw::Definitions::GtkSourceGutterRenderer
    is also<SourceGutterRenderer>
  { $!sgr }

  method new (GtkSourceGutterRenderer $renderer) {
    $renderer ?? self.bless(:$renderer) !! Nil;
  }

  # Is originally:
  # GtkSourceGutterRenderer, GtkTextIter, GdkRectangle, GdkEvent, gpointer --> void
  # Made multi so as to not conflict with the method activate(), below.
  multi method activate {
    self.connect-activate($!sgr);
  }

  # Is originally:
  # GtkSourceGutterRenderer, GtkTextIter, GdkRectangle, GdkEvent, gpointer --> gboolean
  method query-activatable is also<query_activatable> {
    self.connect-query-activatable($!sgr);
  }

  # Is originally:
  # GtkSourceGutterRenderer, GtkTextIter, GtkTextIter, GtkSourceGutterRendererState, gpointer --> void
  method query-data is also<query_data> {
    self.connect-query-data($!sgr);
  }

  # Is originally:
  # GtkSourceGutterRenderer, GtkTextIter, GdkRectangle, gint, gint, GtkTooltip, gpointer --> gboolean
  method query-tooltip is also<query_tooltip> {
    self.connect-query-tooltip($!sgr);
  }

  # Is originally:
  # GtkSourceGutterRenderer, gpointer --> void
  method queue-draw is also<queue_draw> {
    self.connect($!sgr, 'queue-draw');
  }

  method alignment_mode is rw is also<alignment-mode> {
    Proxy.new(
      FETCH => sub ($) {
        GtkSourceGutterRendererAlignmentModeEnum(
          gtk_source_gutter_renderer_get_alignment_mode($!sgr)
        );
      },
      STORE => sub ($, Int() $mode is copy) {
        my guint $m = $mode;

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
        my gint $s = $size;

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
        my gboolean $v = $visible.so.Int;

        gtk_source_gutter_renderer_set_visible($!sgr, $v);
      }
    );
  }

  # Type: GdkRGBA
  method background-rgba is rw  is also<background_rgba> {
    my GLib::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('background-rgba', $gv)
        );
        cast(GDK::RGBA, $gv.object);
      },
      STORE => -> $, GdkRGBA $val is copy {
        $gv.object = $val;
        self.prop_set('background-rgba', $gv);
      }
    );
  }

  # Type: gboolean
  method background-set is rw  is also<background_set> {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
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
  method window-type is rw  is also<window_type> {
    my GLib::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('window-type', $gv)
        );
        GtkTextWindowTypeEnum( $gv.uint );
      },
      STORE => -> $,  $val is copy {
        warn "window-type does not allow writing"
      }
    );
  }

  # Type: gfloat
  method xalign is rw  {
    my GLib::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
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
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
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
    my GLib::Value $gv .= new( G_TYPE_FLOAT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
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
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
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
    GdkRectangle() $area,
    GdkEvent() $event
  ) {
    gtk_source_gutter_renderer_activate($!sgr, $iter, $area, $event);
  }

  method begin (
    cairo_t $cr,
    GdkRectangle() $background_area,
    GdkRectangle() $cell_area,
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
    GdkRectangle() $background_area,
    GdkRectangle() $cell_area,
    GtkTextIter() $start,
    GtkTextIter() $end,
    Int() $state                  # GtkSourceGutterRendererState $state
  ) {
    my guint $s = $state;

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

  method get_alignment (Num() $xalign, Num() $yalign) is also<get-alignment> {
    my gfloat ($xa, $ya) = ($xalign, $yalign);

    gtk_source_gutter_renderer_get_alignment($!sgr, $xa, $ya);
  }

  method get_background (GdkRGBA $color) is also<get-background> {
    gtk_source_gutter_renderer_get_background($!sgr, $color);
  }

  method get_padding (gint $xpad, gint $ypad) is also<get-padding> {
    my gint ($xp, $yp) = $xpad, $ypad;

    gtk_source_gutter_renderer_get_padding($!sgr, $xp, $yp);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gtk_source_gutter_renderer_get_type,
      $n,
      $t
    );
  }

  method get_view ($raw = False) is also<get-view> {
    my $v = gtk_source_gutter_renderer_get_view($!sgr);

    $v ??
      ( $raw ?? $v !! ::('SourceViewGTK::View').new($v) )
      !!
      Nil;
  }

  method get_window_type is also<get-window-type> {
    GtkTextWindowTypeEnum( gtk_source_gutter_renderer_get_window_type($!sgr) );
  }

  method render_query_activatable (
    GtkTextIter() $iter,
    GdkRectangle() $area,
    GdkEvent() $event
  )
    is also<render-query-activatable>
  {
    so gtk_source_gutter_renderer_query_activatable(
      $!sgr,
      $iter,
      $area,
      $event
    );
  }

  method render_query_data (
    GtkTextIter() $start,
    GtkTextIter() $end,
    Int() $state                  # GtkSourceGutterRendererState $state
  )
    is also<render-query-data>
  {
    my guint $s = $state;

    so gtk_source_gutter_renderer_query_data($!sgr, $start, $end, $s);
  }

  method render_query_tooltip (
    GtkTextIter() $iter,
    GdkRectangle() $area,
    Int() $x,
    Int() $y,
    GtkTooltip() $tooltip
  )
    is also<render-query-tooltip>
  {
    my gint ($xx, $yy) = ($x, $y);

    so gtk_source_gutter_renderer_query_tooltip(
      $!sgr,
      $iter,
      $area,
      $xx,
      $yy,
      $tooltip
    );
  }

  method render_queue_draw is also<render-queue-draw> {
    so gtk_source_gutter_renderer_queue_draw($!sgr);
  }

  method set_alignment (Num() $xalign, Num() $yalign) is also<set-alignment> {
    my gfloat ($xa, $ya) = ($xalign, $yalign);

    gtk_source_gutter_renderer_set_alignment($!sgr, $xalign, $yalign);
  }

  method set_background (GdkRGBA $color) is also<set-background> {
    gtk_source_gutter_renderer_set_background($!sgr, $color);
  }

  method set_padding (Int() $xpad, Int() $ypad) is also<set-padding> {
    my gint ($xp, $yp) = $xpad, $ypad;

    gtk_source_gutter_renderer_set_padding($!sgr, $xp, $yp);
  }

}
