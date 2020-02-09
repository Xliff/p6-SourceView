use v6.c;

use NativeCall;

use SourceViewGTK::Raw::Types;

unit package SourceViewGTK::Raw::StyleSchemeChooser;

sub gtk_source_style_scheme_chooser_get_type ()
  returns GType
  is native(sourceview)
  is export
  { * }

sub gtk_source_style_scheme_chooser_get_style_scheme (
  GtkSourceStyleSchemeChooser $chooser
)
  returns GtkSourceStyleScheme
  is native(sourceview)
  is export
  { * }

sub gtk_source_style_scheme_chooser_set_style_scheme (
  GtkSourceStyleSchemeChooser $chooser,
  GtkSourceStyleScheme $scheme
)
  is native(sourceview)
  is export
  { * }
