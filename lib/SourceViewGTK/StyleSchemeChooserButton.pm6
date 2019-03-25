use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use SourceViewGTK::Raw::Types;
use SourceViewGTK::Raw::StyleSchemeChooserButton;

use GTK::Button;

use SourceViewGTK::Roles::StyleSchemeChooser;

our subset StyleSchemeChooserButtonAncestry 
  where GtkSourceStyleSchemeChooserButton | ButtonAncestry;

class SourceViewGTK::StyleSchemeChooserButton is GTK::Button {
  also does SourceViewGTK::Roles::StyleSchemeChooser;
  
  has GtkSourceStyleSchemeChooserButton $!sscb;
  
  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType(self.^name);
    $o;
  }
  
  submethod BUILD (:$button) {
    given $button {
      when StyleSchemeChooserButtonAncestry {
        self.setButton($!sscb = $button);
        # SourceViewGTK::Roles::StyleSchemeChooser
        $!ssc = nativecast(GtkSourceStyleSchemeChooser, $!sscb);
      }
      when SourceViewGTK::StyleSchemeChooserButton {
      }
      default {
      }
    }
  }

  method new {
    self.bless( button => gtk_source_style_scheme_chooser_button_new() );
  }
  
  method get_type is also<get-type> {
    gtk_source_style_scheme_chooser_button_get_type();
  }
  
}
