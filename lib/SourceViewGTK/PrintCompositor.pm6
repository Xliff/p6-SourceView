use v6.c;

use Method::Also;

use SourceViewGTK::Raw::Types;
use SourceViewGTK::Raw::PrintCompositor;

use SourceViewGTK::Buffer;

use GLib::Roles::Object;

class SourceViewGTK::PrintCompositor {
  also does GLib::Roles::Object;

  has GtkSourcePrintCompositor $!spc;

  submethod BUILD (:$compositor) {
    self!setObject($!spc = $compositor);
  }

  method SourceViewGTK::Raw::Definitions::GtkSourcePrintCompositor
    is also<SourcePrintCompositor>
  { $!spc }


  multi method new (GtkSourcePrintCompositor $compositor) {
    $compositor ?? self.bless(:$compositor) !! Nil;
  }
  multi method new (GtkSourceBuffer() $buffer) {
    my $compositor = gtk_source_print_compositor_new($buffer);

    $compositor ?? self.bless(:$compositor) !! Nil;
  }

  method new_from_view (GtkSourceView() $view) is also<new-from-view> {
    my $compositor = gtk_source_print_compositor_new_from_view($view);

    $compositor ?? self.bless(:$compositor) !! Nil;
  }

  method body_font_name is rw is also<body-font-name> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_source_print_compositor_get_body_font_name($!spc);
      },
      STORE => sub ($, Str() $font_name is copy) {
        gtk_source_print_compositor_set_body_font_name($!spc, $font_name);
      }
    );
  }

  method footer_font_name is rw is also<footer-font-name> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_source_print_compositor_get_footer_font_name($!spc);
      },
      STORE => sub ($, Str() $font_name is copy) {
        gtk_source_print_compositor_set_footer_font_name($!spc, $font_name);
      }
    );
  }

  method header_font_name is rw is also<header-font-name> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_source_print_compositor_get_header_font_name($!spc);
      },
      STORE => sub ($, Str() $font_name is copy) {
        gtk_source_print_compositor_set_header_font_name($!spc, $font_name);
      }
    );
  }

  method highlight_syntax is rw is also<highlight-syntax> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_source_print_compositor_get_highlight_syntax($!spc);
      },
      STORE => sub ($, Int() $highlight is copy) {
        my gboolean $h = $highlight.so.Int;

        gtk_source_print_compositor_set_highlight_syntax($!spc, $h);
      }
    );
  }

  method line_numbers_font_name is rw is also<line-numbers-font-name> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_source_print_compositor_get_line_numbers_font_name($!spc);
      },
      STORE => sub ($, Str() $font_name is copy) {
        gtk_source_print_compositor_set_line_numbers_font_name(
          $!spc,
          $font_name
        );
      }
    );
  }

  method print_footer is rw is also<print-footer> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_source_print_compositor_get_print_footer($!spc);
      },
      STORE => sub ($, Int() $print is copy) {
        my gboolean $p = $print.so.Int;

        gtk_source_print_compositor_set_print_footer($!spc, $p);
      }
    );
  }

  method print_header is rw is also<print-header> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_source_print_compositor_get_print_header($!spc);
      },
      STORE => sub ($, Int() $print is copy) {
        my gboolean $p = $print.so.Int;

        gtk_source_print_compositor_set_print_header($!spc, $p);
      }
    );
  }

  method print_line_numbers is rw is also<print-line-numbers> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_source_print_compositor_get_print_line_numbers($!spc);
      },
      STORE => sub ($, Int() $interval is copy) {
        my guint $i = $interval;

        gtk_source_print_compositor_set_print_line_numbers($!spc, $i);
      }
    );
  }

  method tab_width is rw is also<tab-width> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_source_print_compositor_get_tab_width($!spc);
      },
      STORE => sub ($, Int() $width is copy) {
        my guint $w = $width;

        gtk_source_print_compositor_set_tab_width($!spc, $w);
      }
    );
  }

  method wrap_mode is rw is also<wrap-mode> {
    Proxy.new(
      FETCH => sub ($) {
        GtkWrapModeEnum( gtk_source_print_compositor_get_wrap_mode($!spc) );
      },
      STORE => sub ($, Int() $wrap_mode is copy) {
        my GtkWrapMode $wm = $wrap_mode;

        gtk_source_print_compositor_set_wrap_mode($!spc, $wm);
      }
    );
  }

  method draw_page (GtkPrintContext() $context, Int() $page_nr)
    is also<draw-page>
  {
    my gint $pnr = $page_nr;

    gtk_source_print_compositor_draw_page($!spc, $context, $page_nr);
  }

  method get_bottom_margin (Int() $unit) is also<get-bottom-margin> {
    my guint $u = $unit;

    gtk_source_print_compositor_get_bottom_margin($!spc, $u);
  }

  method get_buffer (:$raw = False)
    is also<
      get-buffer
      buffer
    >
  {
    my $b = gtk_source_print_compositor_get_buffer($!spc);

    $b ??
      ( $raw ?? $b !! SourceViewGTK::Buffer.new($b) )
      !!
      Nil;
  }

  method get_left_margin (Int() $unit) is also<get-left-margin> {
    my guint $u = $unit;

    gtk_source_print_compositor_get_left_margin($!spc, $u);
  }

  method get_n_pages
    is also<
      get-n-pages
      n_pages
      n-pages
    >
  {
    gtk_source_print_compositor_get_n_pages($!spc);
  }

  method get_pagination_progress
    is also<
      get-pagination-progress
      pagination_progress
      pagination-progress
    >
  {
    gtk_source_print_compositor_get_pagination_progress($!spc);
  }

  method get_right_margin (Int() $unit) is also<get-right-margin> {
    my guint $u = $unit;

    gtk_source_print_compositor_get_right_margin($!spc, $u);
  }

  method get_top_margin (Int() $unit) is also<get-top-margin> {
    my guint $u = $unit;

    gtk_source_print_compositor_get_top_margin($!spc, $u);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gtk_source_print_compositor_get_type,
      $n,
      $t
    );
  }

  method paginate (GtkPrintContext() $context) {
    so gtk_source_print_compositor_paginate($!spc, $context);
  }

  method set_bottom_margin (Num() $margin, Int() $unit)
    is also<set-bottom-margin>
  {
    my guint $u = $unit;
    my gdouble $m = $margin;

    gtk_source_print_compositor_set_bottom_margin($!spc, $m, $u);
  }

  method set_footer_format (
    Int() $separator,
    Str() $left,
    Str() $center,
    Str() $right
  )
    is also<set-footer-format>
  {
    my gboolean $s = $separator.so.Int;

    gtk_source_print_compositor_set_footer_format(
      $!spc,
      $s,
      $left,
      $center,
      $right
    );
  }

  method set_header_format (
    Int() $separator,
    Str() $left,
    Str() $center,
    Str() $right
  )
    is also<set-header-format>
  {
    my Int $s = $separator;

    gtk_source_print_compositor_set_header_format(
      $!spc,
      $s,
      $left,
      $center,
      $right
    );
  }

  method set_left_margin (Num() $margin, Int() $unit)
    is also<set-left-margin>
  {
    my guint $u = $unit;
    my gdouble $m = $margin;

    gtk_source_print_compositor_set_left_margin($!spc, $m, $u);
  }

  method set_right_margin (Num() $margin, Int() $unit)
    is also<set-right-margin>
  {
    my guint $u = $unit;
    my gdouble $m = $margin;

    gtk_source_print_compositor_set_right_margin($!spc, $m, $u);
  }

  method set_top_margin (Num() $margin, Int() $unit) is also<set-top-margin> {
    my guint $u = $unit;
    my gdouble $m = $margin;

    gtk_source_print_compositor_set_top_margin($!spc, $m, $u);
  }

}
