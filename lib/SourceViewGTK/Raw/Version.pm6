use v6.c;

use NativeCall;

use SourceViewGTK::Raw::Types;

unit package SourceViewGTK::Raw::Version;

sub gtk_source_check_version (uint32 $major, uint32 $minor, uint32 $micro)
  returns uint32
  is native(sourceview)
  is export
  { * }

sub gtk_source_get_major_version ()
  returns uint32
  is native(sourceview)
  is export
  { * }

sub gtk_source_get_micro_version ()
  returns uint32
  is native(sourceview)
  is export
  { * }

sub gtk_source_get_minor_version ()
  returns uint32
  is native(sourceview)
  is export
  { * }
