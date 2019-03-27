use v6.c;

use NativeCall;

use SourceViewGTK::Raw::Types;

class SourceViewGTK::Utils {
  method new {
    die 'SourceViewGTK::Utils is not an instantiable class.';
  }
  
  method escape_search_text (SourceViewGTK::Utils:U: Str() $text) {
    gtk_source_utils_escape_search_text($text);
  }

  method unescape_search_text (SourceViewGTK::Utils:U: Str() $text) {
    gtk_source_utils_unescape_search_text($text);
  }
}

sub gtk_source_utils_escape_search_text (Str $text)
  returns Str
  is native(sourceview)
  is export
  { * }

sub gtk_source_utils_unescape_search_text (Str $text)
  returns Str
  is native(sourceview)
  is export
  { * }
