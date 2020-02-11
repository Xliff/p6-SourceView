use v6.c;

use Method::Also;

use SourceViewGTK::Raw::Types;
use SourceViewGTK::Raw::GutterRendererPixbuf;

use GDK::Pixbuf;
use SourceViewGTK::GutterRenderer;

our subset SourceGutterRendererPixbufAncestry is export
  where GtkSourceGutterRendererPixbuf | GtkSourceGutterRenderer;

class SourceViewGTK::GutterRendererPixbuf is SourceViewGTK::GutterRenderer {
  has GtkSourceGutterRendererPixbuf $!sgrp;

  submethod BUILD (:$pixbuf-renderer) {
    given $pixbuf-renderer {
      when    SourceGutterRendererPixbufAncestry  { self.setGRPixbuf($_) }
      when    SourceViewGTK::GutterRendererPixbuf { }
      default                                     { }
    }
  }

  method setGutterRendererPixbuf(SourceGutterRendererPixbufAncestry $_)
    is also<setGRPixbuf>
  {
    my $to-parent;
    $!sgrp = do {
      when GtkSourceGutterRendererPixbuf {
        $to-parent = cast(GtkSourceGutterRenderer, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkSourceGutterRendererPixbuf, $_);
      }
    }
    self.setGutterRenderer($to-parent);
  }

  method SourceViewGTK::Raw::Definitions::GtkSourceGutterRendererPixbuf
    is also<GtkSourceGutterRendererPixbuf>
  { $!sgrp }

  multi method new (GtkSourceGutterRendererPixbuf $pixbuf-renderer) {
    $pixbuf-renderer ?? self.bless($pixbuf-renderer) !! Nil;
  }
  multi method new {
    my $pixbuf-renderer = gtk_source_gutter_renderer_pixbuf_new();

    $pixbuf-renderer ?? self.bless($pixbuf-renderer) !! Nil;
  }

  # method gicon is rw {
  #   Proxy.new(
  #     FETCH => sub ($) {
  #       gtk_source_gutter_renderer_pixbuf_get_gicon($!sgrp);
  #     },
  #     STORE => sub ($, $icon is copy) {
  #       gtk_source_gutter_renderer_pixbuf_set_gicon($!sgrp, $icon);
  #     }
  #   );
  # }

  method icon_name is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_source_gutter_renderer_pixbuf_get_icon_name($!sgrp);
      },
      STORE => sub ($, Str() $icon_name is copy) {
        gtk_source_gutter_renderer_pixbuf_set_icon_name($!sgrp, $icon_name);
      }
    );
  }

  method pixbuf ($raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $p = gtk_source_gutter_renderer_pixbuf_get_pixbuf($!sgrp);

        $p ??
          ( $raw ?? $p !! GDK::Pixbuf.new($p) )
          !!
          Nil;
      },
      STORE => sub ($, GdkPixbuf() $pixbuf is copy) {
        gtk_source_gutter_renderer_pixbuf_set_pixbuf($!sgrp, $pixbuf);
      }
    );
  }

  method get_type {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gtk_source_gutter_renderer_pixbuf_get_type,
      $n,
      $t
    );
  }

}
