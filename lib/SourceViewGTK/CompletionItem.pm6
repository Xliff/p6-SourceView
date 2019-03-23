use v6.c;

use SourceViewGTK::Raw::Types;
use SourceViewGTK::Raw::CompletionItem;

class SourceViewGTK::CompletionItem {
  has GtkSourceCompletionItem $!sci;
  
  submethod BUILD (:$item) {
    $!sci = $item; 
  }
  
  method new {
    self.bless( item => gtk_source_completion_item_new() );
  }
  
  # Type: GIcon
  # method gicon is rw  {
  #   my GTK::Compat::Value $gv .= new( -type- );
  #   Proxy.new(
  #     FETCH => -> $ {
  #       $gv = GTK::Compat::Value.new(
  #         self.prop_get('gicon', $gv)
  #       );
  #       #$gv.TYPE
  #     },
  #     STORE => -> $,  $val is copy {
  #       #$gv.TYPE = $val;
  #       self.prop_set('gicon', $gv);
  #     }
  #   );
  # }

  # Type: GdkPixbuf
  method icon is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('icon', $gv)
        );
        GTK::Compat::Pixbuf.new( nativecast(GtkPixbuf, $gv.object) );
      },
      STORE => -> $, GtkPixbuf() $val is copy {
        $gv.object = $val;
        self.prop_set('icon', $gv);
      }
    );
  }

  # Type: gchar
  method icon-name is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('icon-name', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('icon-name', $gv);
      }
    );
  }

  # Type: gchar
  method info is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('info', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('info', $gv);
      }
    );
  }

  # Type: gchar
  method label is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('label', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('label', $gv);
      }
    );
  }

  # Type: gchar
  method markup is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('markup', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('markup', $gv);
      }
    );
  }

  # Type: gchar
  method text is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('text', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('text', $gv);
      }
    );
  }
  
  method get_type {
    gtk_source_completion_item_get_type();
  }

  # method set_gicon (GIcon $gicon) {
  #   gtk_source_completion_item_set_gicon($!sci, $gicon);
  # }

  method set_icon (GdkPixbuf() $icon) {
    gtk_source_completion_item_set_icon($!sci, $icon);
  }

  method set_icon_name (Str() $icon_name) {
    gtk_source_completion_item_set_icon_name($!sci, $icon_name);
  }

  method set_info (Str() $info) {
    gtk_source_completion_item_set_info($!sci, $info);
  }

  method set_label (Str() $label) {
    gtk_source_completion_item_set_label($!sci, $label);
  }

  method set_markup (Str() $markup) {
    gtk_source_completion_item_set_markup($!sci, $markup);
  }

  method set_text (Str() $text) {
    gtk_source_completion_item_set_text($!sci, $text);
  }

}
