use v6.c;

use Method::Also;
use NativeCall;


use SourceViewGTK::Raw::Types;

use SourceViewGTK::Raw::Language;

use GLib::Roles::Object;

class SourceViewGTK::Language {
  also does GLib::Roles::Object;

  has GtkSourceLanguage $!sl;

  submethod BUILD (:$language) {
    self!setObject($!sl = $language);
  }

  method SourceViewGTK::Raw::Types::GtkSourceLanguage
    is also<SourceLanguage>
  { $!sl }

  method new (GtkSourceLanguage $language) {
    my $o = self.bless(:$language);
    #$o.upref;
    $o;
  }

  method get_globs
    is also<
      get-globs
      globs
    >
  {
    my CArray[Str] $g = gtk_source_language_get_globs($!sl);
    my ($i, @g) = (0);
    @g[$i] = $g[$i++] while $g[$i];
    # g_strfreev($g);
    @g;
  }

  method get_hidden
    is also<
      get-hidden
      hidden
    >
  {
    gtk_source_language_get_hidden($!sl);
  }

  method get_id
    is also<
      get-id
      id
    >
  {
    gtk_source_language_get_id($!sl);
  }

  method get_metadata (Str() $name) is also<get-metadata> {
    gtk_source_language_get_metadata($!sl, $name);
  }

  method get_mime_types is also<get-mime-types> {
    my CArray[Str] $mt = gtk_source_language_get_mime_types($!sl);
    my ($i, @mt) = (0);
    @mt[$i] = $mt[$i++] while $mt[$i];
    # g_strfreev($sids);
    @mt;
  }

  method get_name
    is also<
      get-name
      name
    >
  {
    gtk_source_language_get_name($!sl);
  }

  method get_section
    is also<
      get-section
      section
    >
  {
    gtk_source_language_get_section($!sl);
  }

  method get_style_fallback (Str() $style_id) {
    gtk_source_language_get_style_fallback($!sl, $style_id);
  }

  method get_style_ids
    is also<
      get-style-ids
      style_ids
      style-ids
    >
  {
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
    state ($n, $t);
    unstable_get_type( self.^name, &gtk_source_language_get_type, $n, $t );
  }

}
