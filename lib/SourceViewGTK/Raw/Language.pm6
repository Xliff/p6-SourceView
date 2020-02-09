use v6.c;

use NativeCall;


use SourceViewGTK::Raw::Types;

unit package SourceViewGTK::Raw::Language;

sub gtk_source_language_get_globs (GtkSourceLanguage $language)
  returns CArray[Str]
  is native(sourceview)
  is export
  { * }

sub gtk_source_language_get_hidden (GtkSourceLanguage $language)
  returns uint32
  is native(sourceview)
  is export
  { * }

sub gtk_source_language_get_id (GtkSourceLanguage $language)
  returns Str
  is native(sourceview)
  is export
  { * }

sub gtk_source_language_get_metadata (GtkSourceLanguage $language, Str $name)
  returns Str
  is native(sourceview)
  is export
  { * }

sub gtk_source_language_get_mime_types (GtkSourceLanguage $language)
  returns CArray[Str]
  is native(sourceview)
  is export
  { * }

sub gtk_source_language_get_name (GtkSourceLanguage $language)
  returns Str
  is native(sourceview)
  is export
  { * }

sub gtk_source_language_get_section (GtkSourceLanguage $language)
  returns Str
  is native(sourceview)
  is export
  { * }

sub gtk_source_language_get_style_fallback (
  GtkSourceLanguage $language, 
  Str $style_id
)
  returns Str
  is native(sourceview)
  is export
  { * }

sub gtk_source_language_get_style_ids (GtkSourceLanguage $language)
  returns CArray[Str]
  is native(sourceview)
  is export
  { * }

sub gtk_source_language_get_style_name (
  GtkSourceLanguage $language, 
  Str $style_id
)
  returns Str
  is native(sourceview)
  is export
  { * }

sub gtk_source_language_get_type ()
  returns GType
  is native(sourceview)
  is export
  { * }
