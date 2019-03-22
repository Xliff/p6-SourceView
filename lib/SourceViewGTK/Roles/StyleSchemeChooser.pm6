use v6.c;

use GTK::Compat::Types;
use SourceViewGTK::Raw::Types;

use SourceViewGTK::Raw::StyleSchemeChooser;

use SourceViewGTK::StyleScheme;

role SourceViewGTK::Roles::StyleSchemeChooser {
  has GtkSourceStyleSchemeChooser $!ssc;
  
  method gtk_source_style_scheme_chooser_style_scheme 
    is rw 
    is also<gtk-source-style-scheme-chooser-style-scheme> 
  {
    Proxy.new(
      FETCH => sub ($) {
        SourceViewGTK::StyleScheme.new( 
          gtk_source_style_scheme_chooser_get_style_scheme($!ssc)
        );
      },
      STORE => sub ($, GtkSourceStyleScheme() $scheme is copy) {
        gtk_source_style_scheme_chooser_set_style_scheme($!ssc, $scheme);
      }
    );
  }
 
  method get_style_scheme_chooser_role_type 
    is also<get-style-scheme-chooser-role-type> 
  {
    gtk_source_style_scheme_chooser_get_type();
  }
  
}
