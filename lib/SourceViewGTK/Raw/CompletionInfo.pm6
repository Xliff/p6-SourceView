use v6.c;

use GTK::Compat::Types;
use SourceViewGTK::Raw::Types;

unit package SourceViewGTK::Raw::CompletionInfo;

sub gtk_source_completion_info_get_type ()
  returns GType
  is native(sourceview)
  is export
  { * }

sub gtk_source_completion_info_move_to_iter (
  GtkSourceCompletionInfo $info, 
  GtkTextView $view, 
  GtkTextIter $iter
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_completion_info_new ()
  returns GtkSourceCompletionInfo
  is native(sourceview)
  is export
  { * }
