use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;
use SourceViewGTK::Raw::Types;

unit package SourceViewGTK::Raw::Style;

sub gtk_source_style_apply (GtkSourceStyle $style, GtkTextTag $tag)
  is native(sourceview)
  is export
  { * }

sub gtk_source_style_copy (GtkSourceStyle $style)
  returns GtkSourceStyle
  is native(sourceview)
  is export
  { * }

sub gtk_source_style_get_type ()
  returns GType
  is native(sourceview)
  is export
  { * }
