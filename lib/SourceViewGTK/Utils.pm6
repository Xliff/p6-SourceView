use v6.c;

use NativeCall;

use SourceViewGTK::Raw::Types;

use GLib::Roles::StaticClass;

class SourceViewGTK::Utils {
  also does GLib::Roles::StaticClass;

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
