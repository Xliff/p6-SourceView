use v6.c;

use NativeCall;

use Cairo;

use GTK::Compat::RGBA;



use SourceViewGTK::Raw::Types;

unit package SourceViewGTK::Raw::GutterRenderer;

sub gtk_source_gutter_renderer_activate (
  GtkSourceGutterRenderer $renderer, 
  GtkTextIter $iter, 
  GdkRectangle $area, 
  GdkEvent $event
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_gutter_renderer_begin (
  GtkSourceGutterRenderer $renderer, 
  cairo_t $cr, 
  GdkRectangle $background_area, 
  GdkRectangle $cell_area, 
  GtkTextIter $start, 
  GtkTextIter $end
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_gutter_renderer_draw (
  GtkSourceGutterRenderer $renderer, 
  cairo_t $cr, 
  GdkRectangle $background_area, 
  GdkRectangle $cell_area, 
  GtkTextIter $start, 
  GtkTextIter $end, 
  guint $state                    # GtkSourceGutterRendererState $state
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_gutter_renderer_end (GtkSourceGutterRenderer $renderer)
  is native(sourceview)
  is export
  { * }

sub gtk_source_gutter_renderer_get_alignment (
  GtkSourceGutterRenderer $renderer, 
  gfloat $xalign, 
  gfloat $yalign
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_gutter_renderer_get_background (
  GtkSourceGutterRenderer $renderer, 
  GdkRGBA $color
)
  returns uint32
  is native(sourceview)
  is export
  { * }

sub gtk_source_gutter_renderer_get_padding (
  GtkSourceGutterRenderer $renderer, 
  gint $xpad, 
  gint $ypad
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_gutter_renderer_get_type ()
  returns GType
  is native(sourceview)
  is export
  { * }

sub gtk_source_gutter_renderer_get_view (GtkSourceGutterRenderer $renderer)
  returns GtkTextView
  is native(sourceview)
  is export
  { * }

sub gtk_source_gutter_renderer_get_window_type (GtkSourceGutterRenderer $renderer)
  returns uint32 # GtkTextWindowType
  is native(sourceview)
  is export
  { * }

sub gtk_source_gutter_renderer_query_activatable (
  GtkSourceGutterRenderer $renderer, 
  GtkTextIter $iter, 
  GdkRectangle $area, 
  GdkEvent $event
)
  returns uint32
  is native(sourceview)
  is export
  { * }

sub gtk_source_gutter_renderer_query_data (
  GtkSourceGutterRenderer $renderer, 
  GtkTextIter $start, 
  GtkTextIter $end, 
  uint32 $state                   # GtkSourceGutterRendererState $state
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_gutter_renderer_query_tooltip (
  GtkSourceGutterRenderer $renderer, 
  GtkTextIter $iter, 
  GdkRectangle $area, 
  gint $x, 
  gint $y, 
  GtkTooltip $tooltip
)
  returns uint32
  is native(sourceview)
  is export
  { * }

sub gtk_source_gutter_renderer_queue_draw (GtkSourceGutterRenderer $renderer)
  is native(sourceview)
  is export
  { * }

sub gtk_source_gutter_renderer_set_alignment (
  GtkSourceGutterRenderer $renderer, 
  gfloat $xalign, 
  gfloat $yalign
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_gutter_renderer_set_background (
  GtkSourceGutterRenderer $renderer, 
  GdkRGBA $color
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_gutter_renderer_set_padding (
  GtkSourceGutterRenderer $renderer, 
  gint $xpad, 
  gint $ypad
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_gutter_renderer_get_alignment_mode (
  GtkSourceGutterRenderer $renderer
)
  returns uint32 # GtkSourceGutterRendererAlignmentMode
  is native(sourceview)
  is export
  { * }

sub gtk_source_gutter_renderer_get_size (GtkSourceGutterRenderer $renderer)
  returns gint
  is native(sourceview)
  is export
  { * }

sub gtk_source_gutter_renderer_get_visible (GtkSourceGutterRenderer $renderer)
  returns uint32
  is native(sourceview)
  is export
  { * }

sub gtk_source_gutter_renderer_set_alignment_mode (
  GtkSourceGutterRenderer $renderer, 
  uint32                          # GtkSourceGutterRendererAlignmentMode $mode
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_gutter_renderer_set_size (
  GtkSourceGutterRenderer $renderer, 
  gint $size
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_gutter_renderer_set_visible (
  GtkSourceGutterRenderer $renderer, 
  gboolean $visible
)
  is native(sourceview)
  is export
  { * }
