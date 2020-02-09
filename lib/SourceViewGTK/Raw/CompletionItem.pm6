use v6.c;

use NativeCall;


use SourceViewGTK::Raw::Types;

unit package SourceViewGTK::Raw::CompletionInfo;

sub gtk_source_completion_item_get_type ()
  returns GType
  is native(sourceview)
  is export
  { * }

sub gtk_source_completion_item_new ()
  returns GtkSourceCompletionItem
  is native(sourceview)
  is export
  { * }

sub gtk_source_completion_item_set_gicon (
  GtkSourceCompletionItem $item, 
  GIcon $gicon
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_completion_item_set_icon (
  GtkSourceCompletionItem $item, 
  GdkPixbuf $icon
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_completion_item_set_icon_name (
  GtkSourceCompletionItem $item, 
  Str $icon_name
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_completion_item_set_info (
  GtkSourceCompletionItem $item, 
  Str $info
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_completion_item_set_label (
  GtkSourceCompletionItem $item, 
  Str $label
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_completion_item_set_markup (
  GtkSourceCompletionItem $item, 
  Str $markup
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_completion_item_set_text (
  GtkSourceCompletionItem $item, 
  Str $text
)
  is native(sourceview)
  is export
  { * }
