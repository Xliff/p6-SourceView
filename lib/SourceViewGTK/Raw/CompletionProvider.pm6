use v6.c;

use NativeCall;



use SourceViewGTK::Raw::Types;

unit package SourceViewGTK::Raw::CompletionProvider;

sub gtk_source_completion_provider_activate_proposal (
  GtkSourceCompletionProvider $provider, 
  GtkSourceCompletionProposal $proposal, 
  GtkTextIter $iter
)
  returns uint32
  is native(sourceview)
  is export
  { * }

sub gtk_source_completion_provider_get_activation (
  GtkSourceCompletionProvider $provider
)
  returns uint32 # GtkSourceCompletionActivation
  is native(sourceview)
  is export
  { * }

# sub gtk_source_completion_provider_get_gicon (
#   GtkSourceCompletionProvider $provider
# )
#   returns GIcon
#   is native(sourceview)
#   is export
#   { * }

sub gtk_source_completion_provider_get_icon (
  GtkSourceCompletionProvider $provider
)
  returns GdkPixbuf
  is native(sourceview)
  is export
  { * }

sub gtk_source_completion_provider_get_icon_name (
  GtkSourceCompletionProvider $provider
)
  returns Str
  is native(sourceview)
  is export
  { * }

sub gtk_source_completion_provider_get_info_widget (
  GtkSourceCompletionProvider $provider, 
  GtkSourceCompletionProposal $proposal
)
  returns GtkWidget
  is native(sourceview)
  is export
  { * }

sub gtk_source_completion_provider_get_interactive_delay (
  GtkSourceCompletionProvider $provider
)
  returns gint
  is native(sourceview)
  is export
  { * }

sub gtk_source_completion_provider_get_name (
  GtkSourceCompletionProvider $provider
)
  returns Str
  is native(sourceview)
  is export
  { * }

sub gtk_source_completion_provider_get_priority (
  GtkSourceCompletionProvider $provider
)
  returns gint
  is native(sourceview)
  is export
  { * }

sub gtk_source_completion_provider_get_start_iter (
  GtkSourceCompletionProvider $provider, 
  GtkSourceCompletionContext $context, 
  GtkSourceCompletionProposal $proposal, 
  GtkTextIter $iter
)
  returns uint32
  is native(sourceview)
  is export
  { * }

sub gtk_source_completion_provider_get_type ()
  returns GType
  is native(sourceview)
  is export
  { * }

sub gtk_source_completion_provider_match (
  GtkSourceCompletionProvider $provider, 
  GtkSourceCompletionContext $context
)
  returns uint32
  is native(sourceview)
  is export
  { * }

sub gtk_source_completion_provider_populate (
  GtkSourceCompletionProvider $provider, 
  GtkSourceCompletionContext $context
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_completion_provider_update_info (
  GtkSourceCompletionProvider $provider, 
  GtkSourceCompletionProposal $proposal, 
  GtkSourceCompletionInfo $info
)
  is native(sourceview)
  is export
  { * }
