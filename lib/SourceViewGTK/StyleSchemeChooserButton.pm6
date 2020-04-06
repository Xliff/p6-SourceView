use v6.c;

use Method::Also;
use NativeCall;

use SourceViewGTK::Raw::Types;
use SourceViewGTK::Raw::StyleSchemeChooserButton;

use GTK::Button;

use SourceViewGTK::Roles::StyleSchemeChooser;

our subset StyleSchemeChooserButtonAncestry is export
  where GtkSourceStyleSchemeChooserButton | GtkSourceStyleSchemeChooser |
        ButtonAncestry;

class SourceViewGTK::StyleSchemeChooserButton is GTK::Button {
  also does SourceViewGTK::Roles::StyleSchemeChooser;

  has GtkSourceStyleSchemeChooserButton $!sscb is implementor;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType(self.^name);
    $o;
  }

  submethod BUILD (:$style-scheme-button) {
    given $style-scheme-button {
      when StyleSchemeChooserButtonAncestry {
        my $to-parent;
        $!sscb = do {
          when GtkSourceStyleSchemeChooserButton {
            $to-parent = nativecast(GtkButton, $_);
            $_;
          }

          when GtkSourceStyleSchemeChooser {
            $to-parent = nativecast(GtkButton, $!ssc = $_);
            nativecast(GtkSourceStyleSchemeChooserButton, $_);
          }

          default {
            $to-parent = $_;
            nativecast(GtkSourceStyleSchemeChooserButton, $_);
          }
        };
        self.setButton($to-parent);
        self.roleInit-SourceStyleSchemeChooser unless $!ssc;
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

  multi method new (
    StyleSchemeChooserButtonAncestry $style-scheme-button,
    :$ref = True
  ) {
    return Nil unless $style-scheme-button;

    my $o = self.bless(:$style-scheme-button);
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $style-scheme-button = gtk_source_style_scheme_chooser_button_new();

    $style-scheme-button ?? self.bless(:$style-scheme-button) !! Nil;
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
