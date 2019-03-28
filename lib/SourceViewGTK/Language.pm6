use v6.c;

use NativeCall;

use GTK::Compat::Types;
use SourceViewGTK::Raw::Types;

use SourceViewGTK::Raw::Language;

use GTK::Compat::Roles::Object;

class SourceViewGTK::Language {
  also does GTK::Compat::Roles::Object;
  
  has GtkSourceLanguage $!sl;
  
  submethod BUILD (:$language) {
    self!setObject($!sl = $language);
  }
  
  method SourceViewGTK::Raw::Types::GtkSourceLanguage 
    #is also<Language>
    { $!sl }
  
  method new (GtkSourceLanguage $language) {
    my $o = self.bless(:$language);
    $o.upref;
    $o;
  }
  
  method get_globs {
    my CArray[Str] $g = gtk_source_language_get_globs($!sl);
    my ($i, @g) = (0);
    @g[$i] = $g[$i++] while $g[$i];
    # g_strfreev($g);
    @g;
  }

  method get_hidden {
    gtk_source_language_get_hidden($!sl);
  }

  method get_id {
    gtk_source_language_get_id($!sl);
  }

  method get_metadata (Str() $name) {
    gtk_source_language_get_metadata($!sl, $name);
  }

  method get_mime_types {
    my CArray[Str] $mt = gtk_source_language_get_mime_types($!sl);
    my ($i, @mt) = (0);
    @mt[$i] = $mt[$i++] while $mt[$i];
    # g_strfreev($sids);
    @mt;
  }

  method get_name {
    gtk_source_language_get_name($!sl);
  }

  method get_section {
    gtk_source_language_get_section($!sl);
  }

  method get_style_fallback (Str() $style_id) {
    gtk_source_language_get_style_fallback($!sl, $style_id);
  }

  method get_style_ids {
    my CArray[Str] $sids = gtk_source_language_get_style_ids($!sl);
    my ($i, @ids) = (0);
    @ids[$i] = $sids[$i++] while $sids[$i];
    # g_strfreev($sids);
    @ids;
  }

  method get_style_name (Str() $style_id) {
    gtk_source_language_get_style_name($!sl, $style_id);
  }

  method get_type {
    gtk_source_language_get_type();
  }
  
}
