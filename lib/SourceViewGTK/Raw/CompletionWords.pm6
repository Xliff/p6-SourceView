use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;
use SourceViewGTK::Raw::Types;

unit package SourceViewGTK::Raw::Completion::Words;

sub gtk_source_completion_words_get_type ()
  returns GType
  is native(sourceview)
  is export
  { * }

sub gtk_source_completion_words_new (Str $name, GdkPixbuf $icon)
  returns GtkSourceCompletionWords
  is native(sourceview)
  is export
  { * }

sub gtk_source_completion_words_register (
  GtkSourceCompletionWords $words, 
  GtkTextBuffer $buffer
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_completion_words_unregister (
  GtkSourceCompletionWords $words, 
  GtkTextBuffer $buffer
)
  is native(sourceview)
  is export
  { * }
