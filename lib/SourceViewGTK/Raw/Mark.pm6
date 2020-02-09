use v6.c;

use NativeCall;

use SourceViewGTK::Raw::Types;

unit package SourceViewGTK::Raw::Mark;

sub gtk_source_mark_get_category (GtkSourceMark $mark)
  returns Str
  is native(sourceview)
  is export
  { * }

sub gtk_source_mark_get_type ()
  returns GType
  is native(sourceview)
  is export
  { * }

sub gtk_source_mark_new (Str $name, Str $category)
  returns GtkSourceMark
  is native(sourceview)
  is export
  { * }

sub gtk_source_mark_next (GtkSourceMark $mark, Str $category)
  returns GtkSourceMark
  is native(sourceview)
  is export
  { * }

sub gtk_source_mark_prev (GtkSourceMark $mark, Str $category)
  returns GtkSourceMark
  is native(sourceview)
  is export
  { * }
