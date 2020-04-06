use v6.c;

use NativeCall;

use SourceViewGTK::Raw::Types;

unit package SourceViewGTK::Raw::CompletionProposal;

sub gtk_source_completion_proposal_changed (
  GtkSourceCompletionProposal $proposal
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_completion_proposal_equal (
  GtkSourceCompletionProposal $proposal,
  GtkSourceCompletionProposal $other
)
  returns uint32
  is native(sourceview)
  is export
  { * }

sub gtk_source_completion_proposal_get_gicon (
  GtkSourceCompletionProposal $proposal
)
  returns GIcon
  is native(sourceview)
  is export
  { * }

sub gtk_source_completion_proposal_get_icon (
  GtkSourceCompletionProposal $proposal
)
  returns GdkPixbuf
  is native(sourceview)
  is export
  { * }

sub gtk_source_completion_proposal_get_icon_name (
  GtkSourceCompletionProposal $proposal
)
  returns Str
  is native(sourceview)
  is export
  { * }

sub gtk_source_completion_proposal_get_info (
  GtkSourceCompletionProposal $proposal
)
  returns Str
  is native(sourceview)
  is export
  { * }

sub gtk_source_completion_proposal_get_label (
  GtkSourceCompletionProposal $proposal
)
  returns Str
  is native(sourceview)
  is export
  { * }

sub gtk_source_completion_proposal_get_markup (
  GtkSourceCompletionProposal $proposal
)
  returns Str
  is native(sourceview)
  is export
  { * }

sub gtk_source_completion_proposal_get_text (
  GtkSourceCompletionProposal $proposal
)
  returns Str
  is native(sourceview)
  is export
  { * }

sub gtk_source_completion_proposal_get_type ()
  returns GType
  is native(sourceview)
  is export
  { * }

sub gtk_source_completion_proposal_hash (
  GtkSourceCompletionProposal $proposal
)
  returns guint
  is native(sourceview)
  is export
  { * }
