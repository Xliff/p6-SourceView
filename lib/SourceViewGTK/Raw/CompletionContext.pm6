use v6.c;

use NativeCall;


use GTK::Raw::Types;
use SourceViewGTK::Raw::Types;

unit package SourceViewGTK::Raw::CompletionContext;

sub gtk_source_completion_context_add_proposals (
  GtkSourceCompletionContext $context, 
  GtkSourceCompletionProvider $provider, 
  GList $proposals, 
  gboolean $finished
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_completion_context_get_activation (
  GtkSourceCompletionContext $context
)
  returns uint32 # GtkSourceCompletionActivation
  is native(sourceview)
  is export
  { * }

sub gtk_source_completion_context_get_iter (
  GtkSourceCompletionContext $context, 
  GtkTextIter $iter
)
  returns uint32
  is native(sourceview)
  is export
  { * }

sub gtk_source_completion_context_get_type ()
  returns GType
  is native(sourceview)
  is export
  { * }
