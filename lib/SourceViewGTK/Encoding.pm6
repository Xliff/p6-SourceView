use v6.c;

use Method::Also;

use GTK::Compat::GSList;

use SourceViewGTK::Raw::Types;
use SourceViewGTK::Raw::Encoding;

use GTK::Compat::Roles::Object;

class SourceViewGTK::Encoding {
  also does GTK::Compat::Roles::Object;

  has GtkSourceEncoding $!se;

  submethod BUILD (:$encoding) {
    self!setObject($!se = $encoding);
  }

  method SourceViewGTK::Raw::Types::GtkSourceEncoding
    is also<GtkSourceEncoding>
  { $!se }

  method new (GtkSourceEncoding $encoding) {
    self.bless(:$encoding);
  }

  method get_current
    is also<
      get-current
      current
    >
  {
    self.bless( encoding => gtk_source_encoding_get_current() );
  }

  method get_from_charset (Str() $charset) is also<get-from-charset> {
    self.bless( encoding => gtk_source_encoding_get_from_charset($charset) );
  }

  method get_utf8
    is also<
      get-utf8
      utf8
    >
  {
    self.bless( encoding => gtk_source_encoding_get_utf8() );
  }

  # Static
  method copy (SourceViewGTK::Encoding:U: GtkSourceEncoding() $orig) {
    self.bless( encoding => gtk_source_encoding_copy($orig) );
  }

  method free {
    gtk_source_encoding_free($!se);
  }

  method get_all (SourceViewGTK::Encoding:U: )
    is also<
      get-all
      all
    >
  {
    GTK::Compat::GSList.new( gtk_source_encoding_get_all() );
  }

  method get_charset
    is also<
      get-charset
      charset
    >
  {
    gtk_source_encoding_get_charset($!se);
  }

  method get_default_candidates ( SourceViewGTK::Encoding:U: )
    is also<
      get-default-candidates
      default_candidates
      default-candidates
    >
  {
    GTK::Compat::GSList.new(
      gtk_source_encoding_get_default_candidates()
    );
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
