use v6.c;

use NativeCall;

use GTK::Compat::Types;
use SourceViewGTK::Raw::Types;

unit package SourceViewGTK::Raw::SourceSchemeManager;

sub gtk_source_style_scheme_manager_append_search_path (
  GtkSourceStyleSchemeManager $manager, Str $path
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_style_scheme_manager_force_rescan (
  GtkSourceStyleSchemeManager $manager
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_style_scheme_manager_get_default ()
  returns GtkSourceStyleSchemeManager
  is native(sourceview)
  is export
  { * }

sub gtk_source_style_scheme_manager_get_scheme (
  GtkSourceStyleSchemeManager $manager, 
  Str $scheme_id
)
  returns GtkSourceStyleScheme
  is native(sourceview)
  is export
  { * }

sub gtk_source_style_scheme_manager_get_type ()
  returns GType
  is native(sourceview)
  is export
  { * }

sub gtk_source_style_scheme_manager_new ()
  returns GtkSourceStyleSchemeManager
  is native(sourceview)
  is export
  { * }

sub gtk_source_style_scheme_manager_prepend_search_path (
  GtkSourceStyleSchemeManager $manager, 
  Str $path
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_style_scheme_manager_set_search_path (
  GtkSourceStyleSchemeManager $manager, 
  CArray[Str] $path
)
  is native(sourceview)
  is export
  { * }
  
sub gtk_source_style_scheme_manager_get_search_path (
  GtkSourceStyleSchemeManager $manager
)
  returns CArray[Str]  
  is native(sourceview)
  is export
  { * }
  
sub gtk_source_style_scheme_manager_get_scheme_ids (
  GtkSourceStyleSchemeManager $manager
)
  returns CArray[Str]  
  is native(sourceview)
  is export
  { * }
