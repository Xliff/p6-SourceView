use v6.c;

use NativeCall;

use GTK::Compat::RGBA;


use GTK::Raw::Types;
use SourceViewGTK::Raw::Types;

unit package SourceViewGTK::Raw::MarkAttributes;

sub gtk_source_mark_attributes_get_background (
  GtkSourceMarkAttributes $attributes, 
  GdkRGBA $background
)
  returns uint32
  is native(sourceview)
  is export
  { * }

sub gtk_source_mark_attributes_get_tooltip_markup (
  GtkSourceMarkAttributes $attributes, 
  GtkSourceMark $mark
)
  returns Str
  is native(sourceview)
  is export
  { * }

sub gtk_source_mark_attributes_get_tooltip_text (
  GtkSourceMarkAttributes $attributes, 
  GtkSourceMark $mark
)
  returns Str
  is native(sourceview)
  is export
  { * }

sub gtk_source_mark_attributes_get_type ()
  returns GType
  is native(sourceview)
  is export
  { * }

sub gtk_source_mark_attributes_new ()
  returns GtkSourceMarkAttributes
  is native(sourceview)
  is export
  { * }

sub gtk_source_mark_attributes_render_icon (
  GtkSourceMarkAttributes $attributes, 
  GtkWidget $widget, 
  gint $size
)
  returns GdkPixbuf
  is native(sourceview)
  is export
  { * }

sub gtk_source_mark_attributes_set_background (
  GtkSourceMarkAttributes $attributes, 
  GdkRGBA $background
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_mark_attributes_get_gicon (
  GtkSourceMarkAttributes $attributes
)
  returns GIcon
  is native(sourceview)
  is export
  { * }

sub gtk_source_mark_attributes_get_icon_name (
  GtkSourceMarkAttributes $attributes
)
  returns Str
  is native(sourceview)
  is export
  { * }

sub gtk_source_mark_attributes_get_pixbuf (
  GtkSourceMarkAttributes $attributes
)
  returns GdkPixbuf
  is native(sourceview)
  is export
  { * }

# sub gtk_source_mark_attributes_set_gicon (
#   GtkSourceMarkAttributes $attributes, 
#   GIcon $gicon
# )
#   is native(sourceview)
#   is export
#   { * }

sub gtk_source_mark_attributes_set_icon_name (
  GtkSourceMarkAttributes $attributes, 
  Str $icon_name
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_mark_attributes_set_pixbuf (
  GtkSourceMarkAttributes $attributes, 
  GdkPixbuf $pixbuf
)
  is native(sourceview)
  is export
  { * }
