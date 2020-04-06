use v6.c;

use Method::Also;

use SourceViewGTK::Raw::Types;
use SourceViewGTK::Raw::GutterRendererText;

our subset GutterRendererTextAncestry
  where GtkSourceGutterRendererText | GtkSourceGutterRenderer;

class SourceViewGTK::GutterRenderer::Text {
  has GtkSourceGutterRendererText $!sgrt;

  submethod BUILD (:$text-renderer) {
    given $text-renderer {
      when GutterRendererTextAncestry {
        my $to-parent;
        $!sgrt = do {
          when GtkSourceGutterRendererText {
            $to-parent = cast(GtkSourceGutterRenderer, $_);
            $_
          }

          default {
            $to-parent = $_;
            cast(GtkSourceGutterRendererText, $_);
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

  method SourceViewGTK::Raw::Definitions::GtkSourceGutterRendererText
    is also<
      GutterRendererText
      GtkSourceGutterRendererText
    >
  { $!sgrt }

  multi method new (GtkSourceGutterRendererText $text-renderer) {
    $text-renderer ?? self.bless($text-renderer) !! Nil;
  }
  multi method new {
    my $text-renderer = gtk_source_gutter_renderer_text_new();

    $text-renderer ?? self.bless($text-renderer) !! Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gtk_source_gutter_renderer_text_get_type,
      $n,
      $t
    );
  }

  method measure (Str $text, Int() $width, Int() $height) {
    my gint ($w, $h) = ($width, $height);

    gtk_source_gutter_renderer_text_measure($!sgrt, $text, $w, $h);
  }

  method measure_markup (Str() $markup, Int() $width, Int() $height)
    is also<measure-markup>
  {
    my gint ($w, $h) = ($width, $height);

    gtk_source_gutter_renderer_text_measure_markup($!sgrt, $markup, $w, $h);
  }

  method set_markup (Str() $markup, Int() $length) is also<set-markup> {
    my gint $l = $length;

    gtk_source_gutter_renderer_text_set_markup($!sgrt, $markup, $length);
  }

  method set_text (Str() $text, Int() $length) is also<set-text> {
    my gint $l = $length;

    gtk_source_gutter_renderer_text_set_text($!sgrt, $text, $l);
  }

}
