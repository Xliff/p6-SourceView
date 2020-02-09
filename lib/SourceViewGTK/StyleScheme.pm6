use v6.c;

use Method::Also;
use NativeCall;


use SourceViewGTK::Raw::Types;

use SourceViewGTK::Raw::StyleScheme;

class SourceViewGTK::StyleScheme {
  has GtkSourceStyleScheme $!ss;
  
  submethod BUILD (:$scheme) {
    $!ss = $scheme;
  }
  
  method SourceViewGTK::Raw::Types::GtkSourceStyleScheme { $!ss }
  
  method get_authors 
    is also<
      get-authors
      authors
    > 
  {  
    my CArray[Str] $a = gtk_source_style_scheme_get_authors($!ss);
    my ($i, @a) = (0);
    @a[$i] = $a[$i++] while $a[$i];
    @a;
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

  method get_style (Str() $style_id) 
    is also<
      get-style
      style
    > 
  {
    gtk_source_style_scheme_get_style($!ss, $style_id);
  }

  method get_type is also<get-type> {
    gtk_source_style_scheme_get_type();
  }
   
}
