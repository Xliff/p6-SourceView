use v6.c;

use Method::Also;
use NativeCall;



use SourceViewGTK::Raw::Types;

use SourceViewGTK::Raw::StyleSchemeChooserButton;

use GTK::Button;

use SourceViewGTK::Roles::StyleSchemeChooser;

our subset StyleSchemeChooserButtonAncestry is export
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
        my $to-parent;
        $!sscb = do {
          when GtkSourceStyleSchemeChooserButton {
            $to-parent = nativecast(GtkButton, $_);
            $_;
          }
          default {
            $to-parent = $_;
            nativecast(GtkSourceStyleSchemeChooserButton, $_);
          }
        };
        # SourceViewGTK::Roles::StyleSchemeChooser
        self.setButton($to-parent);
        $!ssc = nativecast(GtkSourceStyleSchemeChooser, $!sscb);
      }
      when SourceViewGTK::StyleSchemeChooserButton {
      }
      default {
      }
    }
  }
  
  method SourceViewGTK::Raw::Definitions::GtkSourceStyleSchemeChooserButton 
    is also<StyleSchemeChooserButton>
  { $!sscb }

  multi method new (StyleSchemeChooserButtonAncestry $button) {
    my $o = self.bless(:$button);
    $o.upref;
  }
  multi method new {
    self.bless( button => gtk_source_style_scheme_chooser_button_new() );
  }
  
  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( 
      self.^name,
      &gtk_source_style_scheme_chooser_button_get_type,
      $n,
      $t
    );
  }
  
}
