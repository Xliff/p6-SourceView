use v6.c;

use GTK::Compat::Types;
use SourceViewGTK::Raw::StyleSchemeChooserWidget;
use SourceViewGTK::Raw::Types;

use SourceViewGTK::Roles::StyleSchemeChooser;

use GTK::Widget;

our StyleSchemeChooserWidgetAncestry 
  where GtkStyleSchemeChooserWidget | WidgetAncestry;

class SourceViewGTK::StyleSChemeChooserWidget is GTK::Widget {
  has GtkSourceViewStyleSchemeChooserWidget $!sscw;
  
  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType(self.^name);
    $o;
  }
  
  submethod BUILD (:$widget) {
    given $widget {
      when StyleSchemeChooserWidgetAncestry {
        my $to-parent;    
        
        $!sscw = do {
          when GtkStyleSchemeChooserWidget {
            $to-parent = nativecast(GtkWidget, $widget);
            $widget;
          }
          default {
            $to-parent = $_;
            nativecast(GtkStyleSchemeChooserWidget, $widget);
          }
        }
        self.setWidget($to-parent);
      }
      when SourceViewGTK::StyleSchemeChooserWidget {
      }
      default {
      }
      
    }
  }
  
  method new {
    self.bless( widget => gtk_source_style_scheme_chooser_widget_new() );
  }
  
  method get_type {
    gtk_source_style_scheme_chooser_widget_get_type();
  }

}
  
