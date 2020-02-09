use v6.c;

use NativeCall;


use SourceViewGTK::Raw::Types;

unit package SourceViewGTK::Raw::Map;

sub gtk_source_map_get_type ()
  returns GType
  is native(sourceview)
  is export
  { * }

sub gtk_source_map_new ()
  returns GtkSourceMap
  is native(sourceview)
  is export
  { * }

sub gtk_source_map_get_view (GtkSourceMap $map)
  returns GtkSourceView
  is native(sourceview)
  is export
  { * }

sub gtk_source_map_set_view (GtkSourceMap $map, GtkSourceView $view)
  is native(sourceview)
  is export
  { * }
