use v6.c;

use GTK::Compat::RGBA;



use SourceViewGTK::Raw::Types;

use SourceViewGTK::Raw::MarkAttributes;

use GLib::Roles::Object;
use GTK::Roles::Types;
use SourceViewGTK::Roles::Signals::MarkAttributes;

class SourceViewGTK::MarkAttributes {
  also does GLib::Roles::Object;
  also does GTK::Roles::Types;
  also does SourceViewGTK::Roles::Signals::MarkAttributes;
  
  has GtkSourceMarkAttributes $!sma;
  
  submethod BUILD (:$attr) {
    $!sma = $attr;
  }
  
  method SourceViewGTK::Raw::Types::GtkSourceMarkAttributes { $!sma }
  
  method new {
    self.bless( attr => gtk_source_mark_attributes_new() );
  }
  
  # Is originally:
  # GtkSourceMarkAttributes, GtkSourceMark, gpointer --> gchar
  method query-tooltip-markup {
    self.connect-query-tooltip-markup($!sma);
  }

  # Is originally:
  # GtkSourceMarkAttributes, GtkSourceMark, gpointer --> gchar
  method query-tooltip-text {
    self.connect-query-tooltip-text($!sma);
  }
  
  # method gicon is rw {
  #   Proxy.new(
  #     FETCH => sub ($) {
  #       gtk_source_mark_attributes_get_gicon($!sma);
  #     },
  #     STORE => sub ($, $gicon is copy) {
  #       gtk_source_mark_attributes_set_gicon($!sma, $gicon);
  #     }
  #   );
  # }

  method icon_name is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_source_mark_attributes_get_icon_name($!sma);
      },
      STORE => sub ($, $icon_name is copy) {
        gtk_source_mark_attributes_set_icon_name($!sma, $icon_name);
      }
    );
  }

  method pixbuf is rw {
    Proxy.new(
      FETCH => sub ($) {
        GTK::Compat::Pixbuf.new(
          gtk_source_mark_attributes_get_pixbuf($!sma)
        );
      },
      STORE => sub ($, GdkPixbuf() $pixbuf is copy) {
        gtk_source_mark_attributes_set_pixbuf($!sma, $pixbuf);
      }
    );
  }
  
  # Wrapper attribute
  method background is rw {
    Proxy.new:
      FETCH => -> $, { 
        my GTK::Compat::RGBA $c .= new;
        self.get_background($c);
        $c;
      },
      STORE => -> $, GdkRGBA $c {
        self.set_background($c);
      }
  }
  
  method get_background (GdkRGBA $background) {
    gtk_source_mark_attributes_get_background($!sma, $background);
  }

  method get_tooltip_markup (GtkSourceMark() $mark) {
    gtk_source_mark_attributes_get_tooltip_markup($!sma, $mark);
  }

  method get_tooltip_text (GtkSourceMark() $mark) {
    gtk_source_mark_attributes_get_tooltip_text($!sma, $mark);
  }

  method get_type {
    gtk_source_mark_attributes_get_type();
  }

  method render_icon (GtkWidget() $widget, Int() $size) {
    my gint $s = self.RESOLVE-INT($size);
    gtk_source_mark_attributes_render_icon($!sma, $widget, $s);
  }

  method set_background (GdkRGBA $background) {
    gtk_source_mark_attributes_set_background($!sma, $background);
  }
  
}
