use v6.c;

use Method::Also;

use SourceViewGTK::Raw::Types;
use SourceViewGTK::Raw::StyleSchemeChooser;

use SourceViewGTK::StyleScheme;

role SourceViewGTK::Roles::StyleSchemeChooser {
  has GtkSourceStyleSchemeChooser $!ssc;

  method roleInit-StyleSchemeChooser {
    my \i = findProperImplementor(self.^attributes);

    $!ssc = cast( GtkSourceStyleSchemeChooser, i.get_value(self) );
  }

  method gtk_source_style_scheme_chooser_style_scheme (:$raw = False)
    is rw
    is also<gtk-source-style-scheme-chooser-style-scheme>
  {
    Proxy.new(
      FETCH => sub ($) {
        my $sc = gtk_source_style_scheme_chooser_get_style_scheme($!ssc);

        $sc ??
          ( $raw ?? $sc !! SourceViewGTK::StyleScheme.new($sc) )
          !!
          Nil;
      },
      STORE => sub ($, GtkSourceStyleScheme() $scheme is copy) {
        gtk_source_style_scheme_chooser_set_style_scheme($!ssc, $scheme);
      }
    );
  }

  method get_style_scheme_chooser_role_type
    is also<get-style-scheme-chooser-role-type>
  {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gtk_source_style_scheme_chooser_get_type,
      $n,
      $t
    );
  }

}
