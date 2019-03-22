use v6.c;

use NativeCall;

use GTK::Compat::Types;
use SourceViewGTK::Raw::Types;

unit package SourceViewGTK::Raw::StyleSchemeChooserButton;

sub gtk_source_style_scheme_chooser_button_get_type ()
  returns GType
  is native(sourceview)
  is export
  { * }

sub gtk_source_style_scheme_chooser_button_new ()
  returns GtkSourceSyleSchemeChooserButton
  is native(sourceview)
  is export
  { * }
