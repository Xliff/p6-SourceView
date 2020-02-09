use v6.c;

use NativeCall;


use SourceViewGTK::Raw::Types;

unit package SourceViewGTK::Raw::Encoding;

sub gtk_source_encoding_copy (GtkSourceEncoding $enc)
  returns GtkSourceEncoding
  is native(sourceview)
  is export
  { * }

sub gtk_source_encoding_free (GtkSourceEncoding $enc)
  is native(sourceview)
  is export
  { * }

sub gtk_source_encoding_get_all ()
  returns GSList
  is native(sourceview)
  is export
  { * }

sub gtk_source_encoding_get_charset (GtkSourceEncoding $enc)
  returns Str
  is native(sourceview)
  is export
  { * }

sub gtk_source_encoding_get_current ()
  returns GtkSourceEncoding
  is native(sourceview)
  is export
  { * }

sub gtk_source_encoding_get_default_candidates ()
  returns GSList
  is native(sourceview)
  is export
  { * }

sub gtk_source_encoding_get_from_charset (Str $charset)
  returns GtkSourceEncoding
  is native(sourceview)
  is export
  { * }

sub gtk_source_encoding_get_name (GtkSourceEncoding $enc)
  returns Str
  is native(sourceview)
  is export
  { * }

sub gtk_source_encoding_get_type ()
  returns GType
  is native(sourceview)
  is export
  { * }

sub gtk_source_encoding_get_utf8 ()
  returns GtkSourceEncoding
  is native(sourceview)
  is export
  { * }

sub gtk_source_encoding_to_string (GtkSourceEncoding $enc)
  returns Str
  is native(sourceview)
  is export
  { * }
