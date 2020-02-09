use v6.c;

use NativeCall;

use SourceViewGTK::Raw::Types;

unit package SourceViewGTK::Raw::GutterRendererText;

sub gtk_source_gutter_renderer_text_get_type ()
  returns GType
  is native(sourceview)
  is export
  { * }

sub gtk_source_gutter_renderer_text_measure (
  GtkSourceGutterRendererText $renderer,
  Str $text,
  gint $width,
  gint $height
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_gutter_renderer_text_measure_markup (
  GtkSourceGutterRendererText $renderer,
  Str $markup,
  gint $width,
  gint $height
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_gutter_renderer_text_new ()
  returns GtkSourceGutterRenderer
  is native(sourceview)
  is export
  { * }

sub gtk_source_gutter_renderer_text_set_markup (
  GtkSourceGutterRendererText $renderer,
  Str $markup,
  gint $length
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_gutter_renderer_text_set_text (
  GtkSourceGutterRendererText $renderer,
  Str $text,
  gint $length
)
  is native(sourceview)
  is export
  { * }
