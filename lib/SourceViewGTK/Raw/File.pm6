use v6.c;

use NativeCall;

use SourceViewGTK::Raw::Types;

unit package SourceViewGTK::Raw::File;

sub gtk_source_file_check_file_on_disk (GtkSourceFile $file)
  is native(sourceview)
  is export
  { * }

sub gtk_source_file_get_compression_type (GtkSourceFile $file)
  returns guint # GtkSourceCompressionType
  is native(sourceview)
  is export
  { * }

sub gtk_source_file_get_encoding (GtkSourceFile $file)
  returns GtkSourceEncoding
  is native(sourceview)
  is export
  { * }

sub gtk_source_file_get_newline_type (GtkSourceFile $file)
  returns uint32 # GtkSourceNewlineType
  is native(sourceview)
  is export
  { * }

sub gtk_source_file_get_type ()
  returns GType
  is native(sourceview)
  is export
  { * }

sub gtk_source_file_is_deleted (GtkSourceFile $file)
  returns uint32
  is native(sourceview)
  is export
  { * }

sub gtk_source_file_is_externally_modified (GtkSourceFile $file)
  returns uint32
  is native(sourceview)
  is export
  { * }

sub gtk_source_file_is_local (GtkSourceFile $file)
  returns uint32
  is native(sourceview)
  is export
  { * }

sub gtk_source_file_is_readonly (GtkSourceFile $file)
  returns uint32
  is native(sourceview)
  is export
  { * }

sub gtk_source_file_new ()
  returns GtkSourceFile
  is native(sourceview)
  is export
  { * }

sub gtk_source_file_set_mount_operation_factory (
  GtkSourceFile $file,
  &callback (Pointer, Pointer --> GMountOperation),
  gpointer $user_data,
  GDestroyNotify $notify
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_file_get_location (GtkSourceFile $file)
  returns GFile
  is native(sourceview)
  is export
  { * }

sub gtk_source_file_set_location (GtkSourceFile $file, GFile $location)
  is native(sourceview)
  is export
  { * }
