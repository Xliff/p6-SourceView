use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;
use SourceViewGTK::Raw::StyleSchemeChooserWidget;
use SourceViewGTK::Raw::Types;

use SourceViewGTK::Roles::StyleSchemeChooser;

use GTK::Widget;

our subset StyleSchemeChooserWidgetAncestry 
  where GtkSourceStyleSchemeChooserWidget | WidgetAncestry;

class SourceViewGTK::StyleSchemeChooserWidget is GTK::Widget {
  has GtkSourceStyleSchemeChooserWidget $!sscw;
  
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
          when GtkSourceStyleSchemeChooserWidget {
            $to-parent = nativecast(GtkWidget, $widget);
            $widget;
          }
          default {
            $to-parent = $_;
            nativecast(GtkSourceStyleSchemeChooserWidget, $widget);
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
  
  method SourceViewGTK::Raw::Types::StyleSchemeChooserWidget { $!sscw }
  
  method new {
    self.bless( widget => gtk_source_style_scheme_chooser_widget_new() );
  }
  
  method get_type {
    gtk_source_style_scheme_chooser_widget_get_type();
  }

}
  
