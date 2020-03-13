use v6.c;

use NativeCall;
use Method::Also;

use SourceViewGTK::Raw::Types;
use SourceViewGTK::Raw::CompletionItem;

use GLib::Value;

use GLib::Roles::Object;
use GIO::Roles::Icon;
use SourceViewGTK::Roles::CompletionProposal;

class SourceViewGTK::CompletionItem {
  also does GLib::Roles::Object;
  also does SourceViewGTK::Roles::CompletionProposal;

  has GtkSourceCompletionItem $!sci;

  submethod BUILD (:$item) {
    # SourceViewGTK::Roles::CompletionProposal
    self!setObject(
      $!scp = nativecast(GtkSourceCompletionProposal, $!sci = $item)
    );
  }

  method SourceViewGTK::Raw::Definitions::GtkSourceCompletionItem
    is also<
      CompletionItem
      GtkSourceCompletionItem
    >
  { $!sci }

  multi method new (GtkSourceCompletionItem $item) {
    $item ?? self.bless( :$item ) !! Nil
  }
  multi method new {
    my $item = gtk_source_completion_item_new();

    $item ?? self.bless( :$item ) !! Nil
  }

  # Type: GIcon
  # method gicon is rw  {
  #   my GLib::Value $gv .= new( -type- );
  #   Proxy.new(
  #     FETCH => sub ($) {
  #       $gv = GLib::Value.new(
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


  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gtk_source_completion_item_get_type,
      $n,
      $t
    );
  }

  # Type: GIcon
  method gicon (:$raw = False) is rw  {
    my $gv;
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('gicon', $gv)
        );

        return Nil unless $gv.pointer;

        my $i = cast(GIcon, $gv.pointer);

        $raw ?? $i !! GIO::Roles::Icon.new-icon-obj($i);
      },
      STORE => -> $, GIcon() $val is copy {
        $gv = GLib::Value.new( G_TYPE_POINTER );
        $gv.pointer = $val;
        self.prop_set('gicon', $gv);
      }
    );
  }

  # Type: GdkPixbuf
  method icon (:$raw = False) is rw  {
    my $gv;
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('icon', $gv)
        );

        return Nil unless $gv.object;

        my $p = cast(GdkPixbuf, $gv.object);

        $raw ?? $p !! GDK::Pixbuf.new($p);
      },
      STORE => -> $, GdkPixbuf() $val is copy {
        $gv = GLib::Value.new( G_TYPE_OBJECT );
        $gv.object = $val;
        self.prop_set('icon', $gv);
      }
    );
  }

  # Type: gchar
  method icon-name is rw  is also<icon_name> {
    my $gv;
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('icon-name', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv = GLib::Value.new( G_TYPE_STRING );
        $gv.string = $val;
        self.prop_set('icon-name', $gv);
      }
    );
  }

  # Type: gchar
  method info is rw  {
    my $gv;
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('info', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv = GLib::Value.new( G_TYPE_STRING );
        $gv.string = $val;
        self.prop_set('info', $gv);
      }
    );
  }

  # Type: gchar
  method label is rw  {
    my $gv;
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('label', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv = GLib::Value.new( G_TYPE_STRING );
        $gv.string = $val;
        self.prop_set('label', $gv);
      }
    );
  }

  # Type: gchar
  method markup is rw  {
    my $gv;
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('markup', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv = GLib::Value.new( G_TYPE_STRING );
        $gv.string = $val;
        self.prop_set('markup', $gv);
      }
    );
  }

  # Type: gchar
  method text is rw  {
    my $gv;
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('text', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv = GLib::Value.new( G_TYPE_STRING );
        $gv.string = $val;
        self.prop_set('text', $gv);
      }
    );
  }


  # method set_gicon (GIcon $gicon) {
  #   gtk_source_completion_item_set_gicon($!sci, $gicon);
  # }

  method set_icon (GdkPixbuf() $icon) is also<set-icon> {
    gtk_source_completion_item_set_icon($!sci, $icon);
  }

  method set_icon_name (Str() $icon_name) is also<set-icon-name> {
    gtk_source_completion_item_set_icon_name($!sci, $icon_name);
  }

  method set_info (Str() $info) is also<set-info> {
    gtk_source_completion_item_set_info($!sci, $info);
  }

  method set_label (Str() $label) is also<set-label> {
    gtk_source_completion_item_set_label($!sci, $label);
  }

  method set_markup (Str() $markup) is also<set-markup> {
    gtk_source_completion_item_set_markup($!sci, $markup);
  }

  method set_text (Str() $text) is also<set-text> {
    gtk_source_completion_item_set_text($!sci, $text);
  }

}
