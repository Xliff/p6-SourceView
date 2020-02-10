use v6.c;

use NativeCall;

use SourceViewGTK::Raw::Types;
use SourceViewGTK::Raw::StyleSchemeChooserWidget;

use GTK::Widget;

use SourceViewGTK::Roles::StyleSchemeChooser;

our subset StyleChooserWidgetAncestry
  where GtkSourceStyleChooserWidget | WidgetAncestry;

class SourceViewGTK::StyleChooserWidget is GTK::Widget {
  also does SourceViewGTK::Roles::StyleSchemeChooser;
  
  has GtkSourceStyleChooserWidget $!scw;
  
  submethod BUILD (:$widget) {
    given $widget {
      when StyleChooserWidgetAncestry {
        self.setWidget($!scw = $widget);
        # SourceViewGTK::Roles::StyleSchemeChooser
        $!ssc = nativecast(GtkSourceStyleSchemeChooser, $!scw);
      }
      when SourceViewGTK::StyleChooserWidget {
      }
      default {
      }
    }
  }
  
  method SourceViewGTK::Raw::Definitions::StyleChooserWidget { $!scw }
  
  method new {
    self.bless( widget => gtk_source_style_scheme_chooser_widget_new() );
  }
  
  method get_type {
    gtk_source_style_scheme_chooser_widget_get_type();
  }
  
}
