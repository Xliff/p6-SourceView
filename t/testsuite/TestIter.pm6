use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;

constant sourceview_core = "{ $?FILE.IO.dirname }/lib/libgtksourceview-core.so";

unit package TestIter;

sub gtk_source_tag_new ()
  returns Pointer
  is native(sourceview_core)
  is export
  { * }

sub _gtk_source_iter_backward_extra_natural_word_start (GtkTextIter $iter)
  is native(sourceview_core)
  is export
  { * }

sub _gtk_source_iter_backward_full_word_start (GtkTextIter $iter)
  is native(sourceview_core)
  is export
  { * }

sub _gtk_source_iter_backward_visible_word_start (GtkTextIter $iter)
  returns uint32
  is native(sourceview_core)
  is export
  { * }

sub _gtk_source_iter_backward_visible_word_starts (
  GtkTextIter $iter,
  gint $count
)
  returns uint32
  is native(sourceview_core)
  is export
  { * }

sub _gtk_source_iter_ends_extra_natural_word (
  GtkTextIter $iter,
  gboolean $visible
)
  returns uint32
  is native(sourceview_core)
  is export
  { * }

sub _gtk_source_iter_ends_full_word (GtkTextIter $iter)
  returns uint32
  is native(sourceview_core)
  is export
  { * }

sub _gtk_source_iter_ends_word (GtkTextIter $iter)
  returns uint32
  is native(sourceview_core)
  is export
  { * }

sub _gtk_source_iter_extend_selection_word (
  GtkTextIter $location,
  GtkTextIter $start,
  GtkTextIter $end
)
  is native(sourceview_core)
  is export
  { * }

sub _gtk_source_iter_forward_extra_natural_word_end (GtkTextIter $iter)
  is native(sourceview_core)
  is export
  { * }

sub _gtk_source_iter_forward_full_word_end (GtkTextIter $iter)
  is native(sourceview_core)
  is export
  { * }

sub _gtk_source_iter_forward_visible_word_end (GtkTextIter $iter)
  returns uint32
  is native(sourceview_core)
  is export
  { * }

sub _gtk_source_iter_forward_visible_word_ends (
  GtkTextIter $iter,
  gint $count
)
  returns uint32
  is native(sourceview_core)
  is export
  { * }

sub _gtk_source_iter_get_leading_spaces_end_boundary (
  GtkTextIter $iter,
  GtkTextIter $leading_end
)
  is native(sourceview_core)
  is export
  { * }

sub _gtk_source_iter_get_trailing_spaces_start_boundary (
  GtkTextIter $iter,
  GtkTextIter $trailing_start
)
  is native(sourceview_core)
  is export
  { * }

sub _gtk_source_iter_inside_word (GtkTextIter $iter)
  returns uint32
  is native(sourceview_core)
  is export
  { * }

sub _gtk_source_iter_starts_extra_natural_word (
  GtkTextIter $iter,
  gboolean $visible
)
  returns uint32
  is native(sourceview_core)
  is export
  { * }

sub _gtk_source_iter_starts_full_word (GtkTextIter $iter)
  returns uint32
  is native(sourceview_core)
  is export
  { * }

sub _gtk_source_iter_starts_word (GtkTextIter $iter)
  returns uint32
  is native(sourceview_core)
  is export
  { * }
