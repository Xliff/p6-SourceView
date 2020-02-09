use v6.c;

use NativeCall;


use SourceViewGTK::Raw::Types;

unit package SourceViewGTK::Raw::Gutter;

sub gtk_source_gutter_get_renderer_at_pos (
  GtkSourceGutter $gutter, 
  gint $x, 
  gint $y
)
  returns GtkSourceGutterRenderer
  is native(sourceview)
  is export
  { * }

sub gtk_source_gutter_get_type ()
  returns GType
  is native(sourceview)
  is export
  { * }

sub gtk_source_gutter_get_view (GtkSourceGutter $gutter)
  returns GtkSourceView
  is native(sourceview)
  is export
  { * }

sub gtk_source_gutter_get_window_type (GtkSourceGutter $gutter)
  returns uint32 # GtkTextWindowType
  is native(sourceview)
  is export
  { * }

sub gtk_source_gutter_insert (
  GtkSourceGutter $gutter, 
  GtkSourceGutterRenderer $renderer, 
  gint $position
)
  returns uint32
  is native(sourceview)
  is export
  { * }

sub gtk_source_gutter_queue_draw (GtkSourceGutter $gutter)
  is native(sourceview)
  is export
  { * }

sub gtk_source_gutter_remove (
  GtkSourceGutter $gutter, 
  GtkSourceGutterRenderer $renderer
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_gutter_reorder (
  GtkSourceGutter $gutter, 
  GtkSourceGutterRenderer $renderer, 
  gint $position
)
  is native(sourceview)
  is export
  { * }
