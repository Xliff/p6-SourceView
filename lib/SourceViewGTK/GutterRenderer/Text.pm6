use v6.c;

use NativeCall;

use GTK::Compat::Types;

use SourceViewGTK::Raw::Types;
use SourceViewGTK::Raw::GutterRendererText;

our subset GutterRendererTextAncestry 
  where GtkSourceGutterRendererText | GtkSourceGutterRenderer;

class SourceViewGTK::GutterRenderer::Text {
  has GtkSourceGutterRendererText $!sgrt;
  
  submethod BUILD (:$renderer) {
    given $renderer {
      when GutterRendererTextAncestry {
        my $to-parent;
        $!sgrt = do {
          when GtkSourceGutterRendererText {
            $to-parent = nativecast(GtkSourceGutterRenderer, $renderer);
            $renderer
          }
          default {
            $to-parent = $_;
            nativecast(GtkSourceGutterRendererText, $renderer);
          }
        }
        self.setGutterRenderer($to-parent);
      }
      when SourceViewGTK::GutterRenderer::Text {
      }
      default {
      }
    }
  }
  
  method SourceViewGTK::Raw::Types::GtkSourceGutterRendererText { $!sgrt }
  
  method new {
    self.bless( renderer => gtk_source_gutter_renderer_text_new() );
  }
  
  method get_type {
    gtk_source_gutter_renderer_text_get_type();
  }

  method measure (Str $text, Int() $width, Int() $height) {
    my gint ($w, $h) = self.RESOLVE-INT($width, $height);
    gtk_source_gutter_renderer_text_measure($!sgrt, $text, $w, $h);
  }

  method measure_markup (Str() $markup, Int() $width, Int() $height) {
    my gint ($w, $h) = self.RESOLVE-INT($width, $height);
    gtk_source_gutter_renderer_text_measure_markup($!sgrt, $markup, $w, $h);
  }

  method set_markup (Str() $markup, gint $length) {
    gtk_source_gutter_renderer_text_set_markup($!sgrt, $markup, $length);
  }

  method set_text (Str() $text, Int() $length) {
    my gint $l = self.RESOLVE-INT($length);
    gtk_source_gutter_renderer_text_set_text($!sgrt, $text, $l);
  }

}
  
  
  
  
  
