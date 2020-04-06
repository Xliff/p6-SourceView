use v6.c;

use Method::Also;
use NativeCall;

use SourceViewGTK::Raw::Types;
use SourceViewGTK::Raw::StyleScheme;

use SourceViewGTK::Style;

use GLib::Roles::Object;

class SourceViewGTK::StyleScheme {
  also does GLib::Roles::Object;

  has GtkSourceStyleScheme $!ss is implementor;

  submethod BUILD (:$scheme) {
    $!ss = $scheme;

    self.roleInit-Object;
  }

  method new (GtkSourceStyleScheme $scheme) {
    $scheme ?? self.bless(:$scheme) !! Nil;
  }

  method SourceViewGTK::Raw::Definitions::GtkSourceStyleScheme
    is also<GtkSourceStyleScheme>
  { $!ss }

  method get_authors
    is also<
      get-authors
      authors
    >
  {
    CStringArrayToArray( gtk_source_style_scheme_get_authors($!ss) );
  }

  method get_description
    is also<
      get-description
      description
    >
  {
    gtk_source_style_scheme_get_description($!ss);
  }

  method get_filename
    is also<
      get-filename
      filename
    >
  {
    gtk_source_style_scheme_get_filename($!ss);
  }

  method get_id
    is also<
      get-id
      id
    >
  {
    gtk_source_style_scheme_get_id($!ss);
  }

  method get_name
    is also<
      get-name
      name
    >
  {
    gtk_source_style_scheme_get_name($!ss);
  }

  method get_style (Str() $style_id, :$raw = False)
    is also<
      get-style
      style
    >
  {
    my $s = gtk_source_style_scheme_get_style($!ss, $style_id);

    $s ??
      ( $raw ?? $s !! SourceViewGTK::Style.new($s) )
      !!
      Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_source_style_scheme_get_type, $n, $t );
  }

}
