use v6.c;

use Method::Also;
use NativeCall;

use SourceViewGTK::Raw::Types;
use SourceViewGTK::Raw::StyleSchemeChooserWidget;

use GTK::Widget;

use SourceViewGTK::Roles::StyleSchemeChooser;

our subset StyleSchemeChooserWidgetAncestry
  where GtkSourceStyleSchemeChooserWidget | GtkSourceStyleSchemeChooser |
        WidgetAncestry;

class SourceViewGTK::StyleSchemeChooserWidget is GTK::Widget {
  also does SourceViewGTK::Roles::StyleSchemeChooser;

  has GtkSourceStyleSchemeChooserWidget $!sscw;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType(self.^name);
    $o;
  }

  submethod BUILD (:$style-chooser-widget) {
    given $style-chooser-widget {
      when StyleSchemeChooserWidgetAncestry {
        my $to-parent;

        $!sscw = do {
          when GtkSourceStyleSchemeChooserWidget {
            $to-parent = nativecast(GtkWidget, $_);
            $_;
          }

          when GtkSourceStyleSchemeChooser {
            $to-parent = nativecast(GtkWidget, $!ssc = $_);
            nativecast(GtkSourceStyleSchemeChooserWidget, $_);
          }

          default {
            $to-parent = $_;
            nativecast(GtkSourceStyleSchemeChooserWidget, $_);
          }
        }

        self.setWidget($to-parent);
        self.roleInit-StyleChemeChooser unless $!ssc;
      }

      when SourceViewGTK::StyleSchemeChooserWidget {
      }

      default {
      }
    }
  }

  method SourceViewGTK::Raw::Definitions::StyleSchemeChooserWidget
    is also<SourceStyleSchemeChooserWidget>
  { $!sscw }

  multi method new (GtkSourceStyleSchemeChooserWidget $style-chooser-widget) {
    $style-chooser-widget ?? self.bless(:$style-chooser-widget) !! Nil;
  }
  multi method new {
    my $style-chooser-widget = gtk_source_style_scheme_chooser_widget_new();

    $style-chooser-widget ?? self.bless(:$style-chooser-widget) !! Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type(
      &gtk_source_style_scheme_chooser_widget_get_type,
      $n,
      $t
    );
  }

}
