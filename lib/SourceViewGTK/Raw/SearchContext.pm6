use v6.c;

use NativeCall;

use SourceViewGTK::Raw::Types;

unit package SourceViewGTK::Raw::SearchContext;

sub gtk_source_search_context_backward (
  GtkSourceSearchContext $search,
  GtkTextIter $iter,
  GtkTextIter $match_start,
  GtkTextIter $match_end,
  gboolean $has_wrapped_around
)
  returns uint32
  is native(sourceview)
  is export
  { * }

sub gtk_source_search_context_backward_async (
  GtkSourceSearchContext $search,
  GtkTextIter $iter,
  GCancellable $cancellable,
  &callback (Pointer, GAsyncResult, CArray[Pointer[GError]]),
  gpointer $user_data
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_search_context_backward_finish (
  GtkSourceSearchContext $search,
  GAsyncResult $result,
  GtkTextIter $match_start,
  GtkTextIter $match_end,
  gboolean $has_wrapped_around,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(sourceview)
  is export
  { * }

sub gtk_source_search_context_forward (
  GtkSourceSearchContext $search,
  GtkTextIter $iter,
  GtkTextIter $match_start,
  GtkTextIter $match_end,
  gboolean $has_wrapped_around
)
  returns uint32
  is native(sourceview)
  is export
  { * }

sub gtk_source_search_context_forward_async (
  GtkSourceSearchContext $search,
  GtkTextIter $iter,
  GCancellable $cancellable,
  &callback (Pointer, GAsyncResult, CArray[Pointer[GError]]),
  gpointer $user_data
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_search_context_forward_finish (
  GtkSourceSearchContext $search,
  GAsyncResult $result,
  GtkTextIter $match_start,
  GtkTextIter $match_end,
  gboolean $has_wrapped_around,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(sourceview)
  is export
  { * }

sub gtk_source_search_context_get_buffer (GtkSourceSearchContext $search)
  returns GtkSourceBuffer
  is native(sourceview)
  is export
  { * }

sub gtk_source_search_context_get_occurrence_position (
  GtkSourceSearchContext $search,
  GtkTextIter $match_start,
  GtkTextIter $match_end
)
  returns gint
  is native(sourceview)
  is export
  { * }

sub gtk_source_search_context_get_occurrences_count (
  GtkSourceSearchContext $search
)
  returns gint
  is native(sourceview)
  is export
  { * }

sub gtk_source_search_context_get_regex_error (
  GtkSourceSearchContext $search
)
  returns GError
  is native(sourceview)
  is export
  { * }

sub gtk_source_search_context_get_settings (
  GtkSourceSearchContext $search
)
  returns GtkSourceSearchSettings
  is native(sourceview)
  is export
  { * }

sub gtk_source_search_context_get_type ()
  returns GType
  is native(sourceview)
  is export
  { * }

sub gtk_source_search_context_new (
  GtkSourceBuffer $buffer,
  GtkSourceSearchSettings $settings
)
  returns GtkSourceSearchContext
  is native(sourceview)
  is export
  { * }

sub gtk_source_search_context_replace (
  GtkSourceSearchContext $search,
  GtkTextIter $match_start,
  GtkTextIter $match_end,
  Str $replace,
  gint $replace_length,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(sourceview)
  is export
  { * }

sub gtk_source_search_context_replace_all (
  GtkSourceSearchContext $search,
  Str $replace,
  gint $replace_length,
  CArray[Pointer[GError]] $error
)
  returns guint
  is native(sourceview)
  is export
  { * }

sub gtk_source_search_context_get_highlight (GtkSourceSearchContext $search)
  returns uint32
  is native(sourceview)
  is export
  { * }

sub gtk_source_search_context_get_match_style (
  GtkSourceSearchContext $search
)
  returns uint32 # GtkSourceStyle
  is native(sourceview)
  is export
  { * }

sub gtk_source_search_context_set_highlight (
  GtkSourceSearchContext $search,
  gboolean $highlight
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_search_context_set_match_style (
  GtkSourceSearchContext $search,
  uint32 $match_style             # GtkSourceStyle $match_style
)
  is native(sourceview)
  is export
  { * }
