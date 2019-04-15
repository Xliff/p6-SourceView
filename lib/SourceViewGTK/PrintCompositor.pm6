use v6.c;

use Method::Also;

use GTK::Compat::Types;
use GTK::Raw::Types;
use SourceViewGTK::Raw::Types;

use SourceViewGTK::Raw::PrintCompositor;

use GTK::Compat::Roles::Object;
use GTK::Roles::Types;

use SourceViewGTK::Buffer;

class SourceViewGTK::PrintCompositor {
  also does GTK::Compat::Roles::Object;
  also does GTK::Roles::Types;

  has GtkSourcePrintCompositor $!spc;

  submethod BUILD (:$compositor) {
    self!setObject($!spc = $compositor);
  }

  method SourceViewGTK::Raw::Types::GtkSourcePrintCompositor
    is also<SourcePrintCompositor>
  { $!spc }

  method new (GtkSourceBuffer $buffer) {
    self.bless( compositor => gtk_source_print_compositor_new($buffer) );
  }

  method new_from_view (GtkSourceView() $view) is also<new-from-view> {
    self.bless(
      compositor =>gtk_source_print_compositor_new_from_view($view)
    );
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
        my gboolean $h = self.RESOLVE-BOOL($highlight);
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
        my gboolean $p = self.RESOLVE-BOOL($print);
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
        my gboolean $p = self.RESOLVE-BOOL($print);
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
        my guint $i = self.RESOLVE-UINT($interval);
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
        my guint $w = self.RESOLVE-UINT($width);
        gtk_source_print_compositor_set_tab_width($!spc, $w);
      }
    );
  }

  method wrap_mode is rw is also<wrap-mode> {
    Proxy.new(
      FETCH => sub ($) {
        GtkWrapMode( gtk_source_print_compositor_get_wrap_mode($!spc) );
      },
      STORE => sub ($, $wrap_mode is copy) {
        my gboolean $wm = self.RESOLVE-BOOL($wrap_mode);
        gtk_source_print_compositor_set_wrap_mode($!spc, $wm);
      }
    );
  }

  method draw_page (GtkPrintContext() $context, Int() $page_nr)
    is also<draw-page>
  {
    my gint $pnr = self.RESOLVE-INT($page_nr);
    gtk_source_print_compositor_draw_page($!spc, $context, $page_nr);
  }

  method get_bottom_margin (Int() $unit) is also<get-bottom-margin> {
    my guint $u = self.RESOLVE-UINT($unit);
    gtk_source_print_compositor_get_bottom_margin($!spc, $u);
  }

  method get_buffer
    is also<
      get-buffer
      buffer
    >
  {
    SourceViewGTK::Buffer.new(
      gtk_source_print_compositor_get_buffer($!spc)
    );
  }

  method get_left_margin (Int() $unit) is also<get-left-margin> {
    my guint $u = self.RESOLVE-UINT($unit);
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
    my guint $u = self.RESOLVE-UINT($unit);
    gtk_source_print_compositor_get_right_margin($!spc, $u);
  }

  method get_top_margin (Int() $unit) is also<get-top-margin> {
    my guint $u = self.RESOLVE-UINT($unit);
    gtk_source_print_compositor_get_top_margin($!spc, $u);
  }

  method get_type is also<get-type> {
    gtk_source_print_compositor_get_type();
  }

  method paginate (GtkPrintContext() $context) {
    gtk_source_print_compositor_paginate($!spc, $context);
  }

  method set_bottom_margin (Num() $margin, Int() $unit)
    is also<set-bottom-margin>
  {
    my guint $u = self.RESOLVE-UINT($unit);
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
    my gboolean $s = self.RESOLVE-BOOL($separator);
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
    my Int $s = self.RESOLVE-BOOL($separator);
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
    my guint $u = self.RESOLVE-UINT($unit);
    my gdouble $m = $margin;
    gtk_source_print_compositor_set_left_margin($!spc, $m, $u);
  }

  method set_right_margin (Num() $margin, Int() $unit)
    is also<set-right-margin>
  {
    my guint $u = self.RESOLVE-UINT($unit);
    my gdouble $m = $margin;
    gtk_source_print_compositor_set_right_margin($!spc, $m, $u);
  }

  method set_top_margin (Num() $margin, Int() $unit) is also<set-top-margin> {
    my guint $u = self.RESOLVE-UINT($unit);
    my gdouble $m = $margin;
    gtk_source_print_compositor_set_top_margin($!spc, $m, $u);
  }

}
