use v6.c;

use NativeCall;


use SourceViewGTK::Raw::Types;
use SourceViewGTK::Raw::GutterRendererPixbuf;

use SourceViewGTK::GutterRenderer;

our subset SourceGutterRendererPixbufAncestry is export
  where GtkSourceGutterRendererPixbuf | GtkSourceGutterRenderer;
  
class SourceViewGTK::GutterRendererPixbuf is SourceViewGTK::GutterRenderer {
  has GtkSourceGutterRendererPixbuf $!sgrp;
  
  submethod BUILD (:$renderer) {
    given $renderer {
      when SourceGutterRendererPixbufAncestry {
        self.setGutterRenderer($!sgrp = $renderer);
      }
      when SourceViewGTK::GutterRendererPixbuf {
      }
      default {
      }
    }
  }
  
  method SourceViewGTK::Raw::Types::GtkSourceGutterRendererPixbuf { $!sgrp }
  
  method new {
    self.bless( renderer => gtk_source_gutter_renderer_pixbuf_new() );
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

  method pixbuf is rw {
    Proxy.new(
      FETCH => sub ($) {
        GTK::Compat::Pixbuf.new(
          gtk_source_gutter_renderer_pixbuf_get_pixbuf($!sgrp)
        );
      },
      STORE => sub ($, GdkPixbuf() $pixbuf is copy) {
        gtk_source_gutter_renderer_pixbuf_set_pixbuf($!sgrp, $pixbuf);
      }
    );
  }
  
  method get_type {
    gtk_source_gutter_renderer_pixbuf_get_type();
  }
    
}
