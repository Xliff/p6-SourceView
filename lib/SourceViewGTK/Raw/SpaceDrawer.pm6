use v6.c;

use NativeCall;

use GTK::Compat::Types;
use SourceViewGTK::Raw::Types;

unit package SourceViewGTK::Raw::SpaceDrawer;

sub gtk_source_space_drawer_bind_matrix_setting (
  GtkSourceSpaceDrawer $drawer, 
  GSettings $settings, 
  Str $key, 
  uint32 $flags                   # GSettingsBindFlags $flags
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_space_drawer_get_type ()
  returns GType
  is native(sourceview)
  is export
  { * }

sub gtk_source_space_drawer_get_types_for_locations (
  GtkSourceSpaceDrawer $drawer, 
  uint32 $flags                   # GtkSourceSpaceLocationFlags $locations
)
  returns uint32 # GtkSourceSpaceTypeFlags
  is native(sourceview)
  is export
  { * }

sub gtk_source_space_drawer_new ()
  returns GtkSourceSpaceDrawer
  is native(sourceview)
  is export
  { * }

sub gtk_source_space_drawer_set_types_for_locations (
  GtkSourceSpaceDrawer $drawer, 
  uint32 $locations,              # GtkSourceSpaceLocationFlags $locations, 
  uint32 $types                   # GtkSourceSpaceTypeFlags $types
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_space_drawer_get_enable_matrix (GtkSourceSpaceDrawer $drawer)
  returns uint32
  is native(sourceview)
  is export
  { * }

sub gtk_source_space_drawer_get_matrix (GtkSourceSpaceDrawer $drawer)
  returns GVariant
  is native(sourceview)
  is export
  { * }

sub gtk_source_space_drawer_set_enable_matrix (
  GtkSourceSpaceDrawer $drawer, 
  gboolean $enable_matrix
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_space_drawer_set_matrix (
  GtkSourceSpaceDrawer $drawer, 
  GVariant $matrix
)
  is native(sourceview)
  is export
  { * }
