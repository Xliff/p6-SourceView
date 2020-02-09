use v6.c;

use NativeCall;


use SourceViewGTK::Raw::Types;

unit package SourceViewGTK::Raw::LanguageManager;

sub gtk_source_language_manager_get_default ()
  returns GtkSourceLanguageManager
  is native(sourceview)
  is export
  { * }

sub gtk_source_language_manager_get_language (
  GtkSourceLanguageManager $lm, 
  Str $id
)
  returns GtkSourceLanguage
  is native(sourceview)
  is export
  { * }

sub gtk_source_language_manager_get_type ()
  returns GType
  is native(sourceview)
  is export
  { * }

sub gtk_source_language_manager_guess_language (
  GtkSourceLanguageManager $lm, 
  Str $filename, 
  Str $content_type
)
  returns GtkSourceLanguage
  is native(sourceview)
  is export
  { * }

sub gtk_source_language_manager_new ()
  returns GtkSourceLanguageManager
  is native(sourceview)
  is export
  { * }

sub gtk_source_language_manager_set_search_path (
  GtkSourceLanguageManager $lm, 
  CArray[Str] $dirs
)
  is native(sourceview)
  is export
  { * }
  
sub gtk_source_language_manager_get_search_path (
  GtkSourceLanguageManager $lm
) 
  returns CArray[Str]
  is native(sourceview)
  is export
  { * }
  
sub gtk_source_language_manager_get_language_ids (
  GtkSourceLanguageManager $lm
) 
  returns CArray[Str]
  is native(sourceview)
  is export
  { * }
