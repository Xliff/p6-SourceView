use v6.c;

use NativeCall;

use GTK::Compat::Types;
use SourceViewGTK::Raw::Types;

unit package SourceViewGTK::Raw::SearchSettings;

sub gtk_source_search_settings_get_type ()
  returns GType
  is native(sourceview)
  is export
  { * }

sub gtk_source_search_settings_new ()
  returns GtkSourceSearchSettings
  is native(sourceview)
  is export
  { * }

sub gtk_source_search_settings_get_at_word_boundaries (
  GtkSourceSearchSettings $settings
)
  returns uint32
  is native(sourceview)
  is export
  { * }

sub gtk_source_search_settings_get_case_sensitive (
  GtkSourceSearchSettings $settings
)
  returns uint32
  is native(sourceview)
  is export
  { * }

sub gtk_source_search_settings_get_regex_enabled (
  GtkSourceSearchSettings $settings
)
  returns uint32
  is native(sourceview)
  is export
  { * }

sub gtk_source_search_settings_get_search_text (
  GtkSourceSearchSettings $settings
)
  returns Str
  is native(sourceview)
  is export
  { * }

sub gtk_source_search_settings_get_wrap_around (
  GtkSourceSearchSettings $settings
)
  returns uint32
  is native(sourceview)
  is export
  { * }

sub gtk_source_search_settings_set_at_word_boundaries (
  GtkSourceSearchSettings $settings, 
  gboolean $at_word_boundaries
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_search_settings_set_case_sensitive (
  GtkSourceSearchSettings $settings, 
  gboolean $case_sensitive
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_search_settings_set_regex_enabled (
  GtkSourceSearchSettings $settings, 
  gboolean $regex_enabled
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_search_settings_set_search_text (
  GtkSourceSearchSettings $settings, 
  Str $search_text
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_search_settings_set_wrap_around (
  GtkSourceSearchSettings $settings, 
  gboolean $wrap_around
)
  is native(sourceview)
  is export
  { * }
