use v6.c;

use Method::Also;

use SourceViewGTK::Raw::Types;
use SourceViewGTK::Raw::MarkAttributes;

use GDK::RGBA;
use GDK::Pixbuf;

use GLib::Roles::Object;
use SourceViewGTK::Roles::Signals::MarkAttributes;

class SourceViewGTK::MarkAttributes {
  also does GLib::Roles::Object;
  also does SourceViewGTK::Roles::Signals::MarkAttributes;

  has GtkSourceMarkAttributes $!sma;

  submethod BUILD (:$attr) {
    $!sma = $attr;
  }

  method SourceViewGTK::Raw::Definitions::GtkSourceMarkAttributes
    is also<GtkSourceMarkAttributes>
  { $!sma }

  multi method new (GtkSourceMarkAttributes $attr) {
    $attr ?? self.bless(:$attr) !! Nil;
  }
  multi method new {
    my $attr = gtk_source_mark_attributes_new();

    $attr ?? self.bless(:$attr) !! Nil;
  }

  # Is originally:
  # GtkSourceMarkAttributes, GtkSourceMark, gpointer --> gchar
  method query-tooltip-markup is also<query_tooltip_markup> {
    self.connect-query-tooltip-markup($!sma);
  }

  # Is originally:
  # GtkSourceMarkAttributes, GtkSourceMark, gpointer --> gchar
  method query-tooltip-text is also<query_tooltip_text> {
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

  method icon_name is rw is also<icon-name> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_source_mark_attributes_get_icon_name($!sma);
      },
      STORE => sub ($, Str() $icon_name is copy) {
        gtk_source_mark_attributes_set_icon_name($!sma, $icon_name);
      }
    );
  }

  method pixbuf (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $p = gtk_source_mark_attributes_get_pixbuf($!sma);

        $p ??
          ( $raw ?? $p !! GDK::Pixbuf.new($p) )
          !!
          Nil;
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
        my $c = GDK::RGBA.new;

        self.get_background($c);
        $c;
      },
      STORE => -> $, GdkRGBA $c {
        self.set_background($c);
      }
  }

  proto method get_background (|)
    is also<get-background>
  { * }

  multi method get_background {
    my $b = GdkRGBA.new;
    my $r = samewith($b);

    $r ?? $b !! Nil;
  }
  multi method get_background (GdkRGBA $background) {
    so gtk_source_mark_attributes_get_background($!sma, $background);
  }

  method get_tooltip_markup (GtkSourceMark() $mark)
    is also<get-tooltip-markup>
  {
    gtk_source_mark_attributes_get_tooltip_markup($!sma, $mark);
  }

  method get_tooltip_text (GtkSourceMark() $mark) is also<get-tooltip-text> {
    gtk_source_mark_attributes_get_tooltip_text($!sma, $mark);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gtk_source_mark_attributes_get_type,
      $n,
      $t
    );
  }

  method render_icon (GtkWidget() $widget, Int() $size, :$raw = False)
    is also<render-icon>
  {
    my gint $s = $size;

    my $p = gtk_source_mark_attributes_render_icon($!sma, $widget, $s);

    $p ??
      ( $raw ?? $p !! GDK::Pixbuf.new($p) )
      !!
      Nil;
  }

  method set_background (GdkRGBA $background) is also<set-background> {
    gtk_source_mark_attributes_set_background($!sma, $background);
  }

}
