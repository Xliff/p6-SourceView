use v6.c;

use NativeCall;

use GTK::Compat::Types;
use SourceViewGTK::Raw::Types;

unit package SourceViewGTK::Raw::StyleChooserWidget;

sub gtk_source_style_scheme_chooser_widget_get_type ()
  returns GType
  is native(sourceview)
  is export
  { * }

sub gtk_source_style_scheme_chooser_widget_new ()
  returns GtkSourceStyleSchemeChooserWidget
  is native(sourceview)
  is export
  { * }
