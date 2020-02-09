use v6.c;

use NativeCall;


use SourceViewGTK::Raw::Types;

unit package SourceViewGTK::Raw::GutterRendererPixbuf;

sub gtk_source_gutter_renderer_pixbuf_get_type ()
  returns GType
  is native(sourceview)
  is export
  { * }

sub gtk_source_gutter_renderer_pixbuf_new ()
  returns GtkSourceGutterRenderer
  is native(sourceview)
  is export
  { * }

sub gtk_source_gutter_renderer_pixbuf_get_gicon (
  GtkSourceGutterRendererPixbuf $renderer
)
  returns GIcon
  is native(sourceview)
  is export
  { * }

sub gtk_source_gutter_renderer_pixbuf_get_icon_name (
  GtkSourceGutterRendererPixbuf $renderer
)
  returns Str
  is native(sourceview)
  is export
  { * }

sub gtk_source_gutter_renderer_pixbuf_get_pixbuf (
  GtkSourceGutterRendererPixbuf $renderer
)
  returns GdkPixbuf
  is native(sourceview)
  is export
  { * }

# sub gtk_source_gutter_renderer_pixbuf_set_gicon (
#   GtkSourceGutterRendererPixbuf $renderer, 
#   GIcon $icon
# )
#   is native(sourceview)
#   is export
#   { * }

sub gtk_source_gutter_renderer_pixbuf_set_icon_name (
  GtkSourceGutterRendererPixbuf $renderer, 
  Str $icon_name
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_gutter_renderer_pixbuf_set_pixbuf (
  GtkSourceGutterRendererPixbuf $renderer, 
  GdkPixbuf $pixbuf
)
  is native(sourceview)
  is export
  { * }
