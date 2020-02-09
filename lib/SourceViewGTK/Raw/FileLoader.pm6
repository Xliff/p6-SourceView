use v6.c;
use NativeCall;



use SourceViewGTK::Raw::Types;

unit package SourceViewGTK::Raw::FileLoader;

sub gtk_source_file_loader_error_quark ()
  returns GQuark
  is native(sourceview)
  is export
  { * }

sub gtk_source_file_loader_get_buffer (GtkSourceFileLoader $loader)
  returns GtkSourceBuffer
  is native(sourceview)
  is export
  { * }

sub gtk_source_file_loader_get_compression_type (GtkSourceFileLoader $loader)
  returns uint32 # GtkSourceCompressionType
  is native(sourceview)
  is export
  { * }

sub gtk_source_file_loader_get_encoding (GtkSourceFileLoader $loader)
  returns GtkSourceEncoding
  is native(sourceview)
  is export
  { * }

sub gtk_source_file_loader_get_file (GtkSourceFileLoader $loader)
  returns GtkSourceFile
  is native(sourceview)
  is export
  { * }

sub gtk_source_file_loader_get_input_stream (GtkSourceFileLoader $loader)
  returns GInputStream
  is native(sourceview)
  is export
  { * }

sub gtk_source_file_loader_get_location (GtkSourceFileLoader $loader)
  returns GFile
  is native(sourceview)
  is export
  { * }

sub gtk_source_file_loader_get_newline_type (GtkSourceFileLoader $loader)
  returns uint32 # GtkSourceNewlineType
  is native(sourceview)
  is export
  { * }

sub gtk_source_file_loader_get_type ()
  returns GType
  is native(sourceview)
  is export
  { * }

sub gtk_source_file_loader_load_async (
  GtkSourceFileLoader $loader, 
  gint $io_priority, 
  GCancellable $cancellable, 
  &progress_callback (int64, int64, Pointer), 
  gpointer $progress_callback_data, 
  GDestroyNotify $progress_callback_notify, 
  &async_callback (GObject, GAsyncResult, Pointer), 
  gpointer $user_data
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_file_loader_load_finish (
  GtkSourceFileLoader $loader, 
  GAsyncResult $result, 
  CArray[Pointer[GError]] $error
)
  returns uint32
  is native(sourceview)
  is export
  { * }

sub gtk_source_file_loader_new (
  GtkSourceBuffer $buffer, 
  GtkSourceFile $file
)
  returns GtkSourceFileLoader
  is native(sourceview)
  is export
  { * }

sub gtk_source_file_loader_new_from_stream (
  GtkSourceBuffer $buffer, 
  GtkSourceFile $file, 
  GInputStream $stream
)
  returns GtkSourceFileLoader
  is native(sourceview)
  is export
  { * }

sub gtk_source_file_loader_set_candidate_encodings (
  GtkSourceFileLoader $loader, 
  GSList $candidate_encodings
)
  is native(sourceview)
  is export
  { * }
