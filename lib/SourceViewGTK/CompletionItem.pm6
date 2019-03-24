use v6.c;

use SourceViewGTK::Raw::Types;
use SourceViewGTK::Raw::CompletionItem;

use SourceViewGTK::Roles::GtkSourceCompletionProposal;

class SourceViewGTK::CompletionItem {
  also does SourceViewGTK::Roles::GtkSourceCompletionProposal;
  
  has GtkSourceCompletionItem $!sci;
  
  submethod BUILD (:$item) {
    # SourceViewGTK::Roles::CompletionProposal
    $!scp = nativecast(GtkSourceCompletionProposal, $!sci = $item); 
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
    Proxy.new:
      FETCH => -> $                   { self.get_icon        },
      STORE => -> $ GdkPixbuf() $icon { self.set_icon($icon) };
  }

  # Type: gchar
  method icon-name is rw  {
    Proxy.new:
      FECTH => -> $              { self.get_icon_name       },
      STORE => -> $, Str() $name { self.set_con_name($name) };
  }

  # Type: gchar
  method info is rw  {
    Proxy.new:
      FETCH => -> $              { self.get_info        }
      STORE => -> $, Str() $info { self.set_info($info) };,
  }

  # Type: gchar
  method label is rw  {
    Proxy.new:
      FETCH => -> $               { self.get_label         },
      STORE => -> $, Str() $label { self.set_label($label) };
  }

  # Type: gchar
  method markup is rw  {
    Proxy.new:
      FETCH => -> $                { self.get_markup          },
      STORE => -> $, Str() $markup { self.set_markup($markup) };
  }

  # Type: gchar
  method text is rw  {
    Proxy.new:
      FETCH => -> $              { self.get_text        },
      STORE => -> $, Str() $text { self.set_text($text) };
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
