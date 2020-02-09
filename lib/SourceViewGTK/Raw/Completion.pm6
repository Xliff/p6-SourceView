use v6.c;

use NativeCall;

use SourceViewGTK::Raw::Types;

unit package SourceViewGTK::Raw::Completion;

sub gtk_source_completion_add_provider (
  GtkSourceCompletion $completion,
  GtkSourceCompletionProvider $provider,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(sourceview)
  is export
  { * }

sub gtk_source_completion_block_interactive (GtkSourceCompletion $completion)
  is native(sourceview)
  is export
  { * }

sub gtk_source_completion_create_context (
  GtkSourceCompletion $completion,
  GtkTextIter $position
)
  returns GtkSourceCompletionContext
  is native(sourceview)
  is export
  { * }

sub gtk_source_completion_error_quark ()
  returns GQuark
  is native(sourceview)
  is export
  { * }

sub gtk_source_completion_get_info_window (GtkSourceCompletion $completion)
  returns GtkSourceCompletionInfo
  is native(sourceview)
  is export
  { * }

sub gtk_source_completion_get_providers (GtkSourceCompletion $completion)
  returns GList
  is native(sourceview)
  is export
  { * }

sub gtk_source_completion_get_type ()
  returns GType
  is native(sourceview)
  is export
  { * }

sub gtk_source_completion_get_view (GtkSourceCompletion $completion)
  returns GtkSourceView
  is native(sourceview)
  is export
  { * }

sub gtk_source_completion_hide (GtkSourceCompletion $completion)
  is native(sourceview)
  is export
  { * }

sub gtk_source_completion_remove_provider (
  GtkSourceCompletion $completion,
  GtkSourceCompletionProvider $provider,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(sourceview)
  is export
  { * }

sub gtk_source_completion_start (
  GtkSourceCompletion $completion,
  GList $providers,
  GtkSourceCompletionContext $context
)
  returns uint32
  is native(sourceview)
  is export
  { * }

sub gtk_source_completion_unblock_interactive (
  GtkSourceCompletion $completion
)
  is native(sourceview)
  is export
  { * }
