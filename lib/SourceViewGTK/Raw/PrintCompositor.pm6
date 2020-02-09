use v6.c;

use NativeCall;



use SourceViewGTK::Raw::Types;

unit package SourceViewGTK::Raw::PrintCompositor;

sub gtk_source_print_compositor_draw_page (
  GtkSourcePrintCompositor $compositor, 
  GtkPrintContext $context, 
  gint $page_nr
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_print_compositor_get_bottom_margin (
  GtkSourcePrintCompositor $compositor, 
  uint32 $unit                    # GtkUnit $unit
)
  returns gdouble
  is native(sourceview)
  is export
  { * }

sub gtk_source_print_compositor_get_buffer (
  GtkSourcePrintCompositor $compositor
)
  returns GtkSourceBuffer
  is native(sourceview)
  is export
  { * }

sub gtk_source_print_compositor_get_left_margin (
  GtkSourcePrintCompositor $compositor, 
  uint32 $unit                    # GtkUnit $unit
)
  returns gdouble
  is native(sourceview)
  is export
  { * }

sub gtk_source_print_compositor_get_n_pages (
  GtkSourcePrintCompositor $compositor
)
  returns gint
  is native(sourceview)
  is export
  { * }

sub gtk_source_print_compositor_get_pagination_progress (
  GtkSourcePrintCompositor $compositor
)
  returns gdouble
  is native(sourceview)
  is export
  { * }

sub gtk_source_print_compositor_get_right_margin (
  GtkSourcePrintCompositor $compositor, 
  uint32 $unit                    # GtkUnit $unit
)
  returns gdouble
  is native(sourceview)
  is export
  { * }

sub gtk_source_print_compositor_get_top_margin (
  GtkSourcePrintCompositor $compositor, 
  uint32 $unit                    # GtkUnit $unit
)
  returns gdouble
  is native(sourceview)
  is export
  { * }

sub gtk_source_print_compositor_get_type ()
  returns GType
  is native(sourceview)
  is export
  { * }

sub gtk_source_print_compositor_new (GtkSourceBuffer $buffer)
  returns GtkSourcePrintCompositor
  is native(sourceview)
  is export
  { * }

sub gtk_source_print_compositor_new_from_view (GtkSourceView $view)
  returns GtkSourcePrintCompositor
  is native(sourceview)
  is export
  { * }

sub gtk_source_print_compositor_paginate (
  GtkSourcePrintCompositor $compositor, 
  GtkPrintContext $context
)
  returns uint32
  is native(sourceview)
  is export
  { * }

sub gtk_source_print_compositor_set_bottom_margin (
  GtkSourcePrintCompositor $compositor, 
  gdouble $margin, 
  uint32 $unit                    # GtkUnit $unit
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_print_compositor_set_footer_format (
  GtkSourcePrintCompositor $compositor, 
  gboolean $separator, 
  Str $left, 
  Str $center, 
  Str $right
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_print_compositor_set_header_format (
  GtkSourcePrintCompositor $compositor, 
  gboolean $separator, 
  Str $left, 
  Str $center, 
  Str $right
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_print_compositor_set_left_margin (
  GtkSourcePrintCompositor $compositor, 
  gdouble $margin, 
  uint32 $unit                    # GtkUnit $unit
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_print_compositor_set_right_margin (
  GtkSourcePrintCompositor $compositor, 
  gdouble $margin, 
  uint32 $unit                    # GtkUnit $unit
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_print_compositor_set_top_margin (
  GtkSourcePrintCompositor $compositor, 
  gdouble $margin, 
  uint32 $unit                    # GtkUnit $unit
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_print_compositor_get_body_font_name (
  GtkSourcePrintCompositor $compositor
)
  returns Str
  is native(sourceview)
  is export
  { * }

sub gtk_source_print_compositor_get_footer_font_name (
  GtkSourcePrintCompositor $compositor
)
  returns Str
  is native(sourceview)
  is export
  { * }

sub gtk_source_print_compositor_get_header_font_name (
  GtkSourcePrintCompositor $compositor
)
  returns Str
  is native(sourceview)
  is export
  { * }

sub gtk_source_print_compositor_get_highlight_syntax (
  GtkSourcePrintCompositor $compositor
)
  returns uint32
  is native(sourceview)
  is export
  { * }

sub gtk_source_print_compositor_get_line_numbers_font_name (
  GtkSourcePrintCompositor $compositor
)
  returns Str
  is native(sourceview)
  is export
  { * }

sub gtk_source_print_compositor_get_print_footer (
  GtkSourcePrintCompositor $compositor
)
  returns uint32
  is native(sourceview)
  is export
  { * }

sub gtk_source_print_compositor_get_print_header (
  GtkSourcePrintCompositor $compositor
)
  returns uint32
  is native(sourceview)
  is export
  { * }

sub gtk_source_print_compositor_get_print_line_numbers (
  GtkSourcePrintCompositor $compositor
)
  returns guint
  is native(sourceview)
  is export
  { * }

sub gtk_source_print_compositor_get_tab_width (
  GtkSourcePrintCompositor $compositor
)
  returns guint
  is native(sourceview)
  is export
  { * }

sub gtk_source_print_compositor_get_wrap_mode (
  GtkSourcePrintCompositor $compositor
)
  returns uint32 # GtkWrapMode
  is native(sourceview)
  is export
  { * }

sub gtk_source_print_compositor_set_body_font_name (
  GtkSourcePrintCompositor $compositor, 
  Str $font_name
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_print_compositor_set_footer_font_name (
  GtkSourcePrintCompositor $compositor, 
  Str $font_name
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_print_compositor_set_header_font_name (
  GtkSourcePrintCompositor $compositor, 
  Str $font_name
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_print_compositor_set_highlight_syntax (
  GtkSourcePrintCompositor $compositor, 
  gboolean $highlight
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_print_compositor_set_line_numbers_font_name (
  GtkSourcePrintCompositor $compositor, 
  Str $font_name
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_print_compositor_set_print_footer (
  GtkSourcePrintCompositor $compositor, 
  gboolean $print
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_print_compositor_set_print_header (
  GtkSourcePrintCompositor $compositor, 
  gboolean $print
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_print_compositor_set_print_line_numbers (
  GtkSourcePrintCompositor $compositor, 
  guint $interval
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_print_compositor_set_tab_width (
  GtkSourcePrintCompositor $compositor, 
  guint $width
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_print_compositor_set_wrap_mode (
  GtkSourcePrintCompositor $compositor, 
  uint32 $wrap_mode               # GtkWrapMode $wrap_mode
)
  is native(sourceview)
  is export
  { * }
