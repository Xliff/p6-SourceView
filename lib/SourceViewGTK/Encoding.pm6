use v6.c;

use Method::Also;

use GTK::Compat::Types;

use GLib::GSList;

use SourceViewGTK::Raw::Types;
use SourceViewGTK::Raw::Encoding;

use GTK::Compat::Roles::Object;

# Boxed!

class SourceViewGTK::Encoding {
  has GtkSourceEncoding $!se;

  submethod BUILD (:$encoding) {
    $!se = $encoding;
  }

  method SourceViewGTK::Raw::Types::GtkSourceEncoding
    is also<GtkSourceEncoding>
  { $!se }

  method new (GtkSourceEncoding $encoding) {
    $encoding ?? self.bless(:$encoding) !! Nil;
  }

  method get_current
    is also<
      get-current
      current
    >
  {
    my $e = gtk_source_encoding_get_current();

    $e ?? self.bless( encoding => $e ) !! Nil;
  }

  method get_from_charset (Str() $charset) is also<get-from-charset> {
    my $e = gtk_source_encoding_get_from_charset($charset);

    $e ?? self.bless( encoding => $e ) !! Nil;
  }

  method get_utf8
    is also<
      get-utf8
      utf8
    >
  {
    my $e = gtk_source_encoding_get_utf8();

    $e ?? self.bless( encoding => $e ) !! Nil;
  }

  # Static
  method copy (SourceViewGTK::Encoding:U: GtkSourceEncoding() $orig) {
    my $e = gtk_source_encoding_copy($orig);

    $e ?? self.bless( encoding => $e ) !! Nil;
  }

  method free {
    gtk_source_encoding_free($!se);
  }

  method get_all (SourceViewGTK::Encoding:U: :$glist = False, :$raw = False)
    is also<
      get-all
      all
    >
  {
    my $el = gtk_source_encoding_get_all();

    return Nil unless $el;
    return $el if     $glist;

    $el = GTK::Compat::GSList.new($el)
      but GTK::Compat::Roles::ListData[GtkSourceEncoding];

    $raw ?? $el.Array !! $el.Array.map({ SourceViewGTK::Encoding.new($el) });
  }

  method get_charset
    is also<
      get-charset
      charset
    >
  {
    gtk_source_encoding_get_charset($!se);
  }

  method get_default_candidates (
    SourceViewGTK::Encoding:U:
    :$glist = False,
    :$raw   = False
  )
    is also<
      get-default-candidates
      default_candidates
      default-candidates
    >
  {
    my $el = gtk_source_encoding_get_default_candidates();

    return Nil unless $el;
    return $el if     $glist;

    $el = GTK::Compat::GSList.new($el)
      but GTK::Compat::Roles::ListData[GtkSourceEncoding];

    $raw ?? $el.Array !! $el.Array.map({ SourceViewGTK::Encoding.new($el) });
  }

  method get_name (
    SourceViewGTK::Encoding:U:
    Str() $enc
  )
    is also<get-name>
  {
    gtk_source_encoding_get_name($enc);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_source_encoding_get_type, $n, $t );
  }

  method to_string
    is also<
      to-string
      Str
    >
  {
    gtk_source_encoding_to_string($!se);
  }

}
