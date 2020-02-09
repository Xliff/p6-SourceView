use v6.c;

use NativeCall;


use GTK::Raw::Types;
use SourceViewGTK::Raw::Types;

unit package SourceViewGTK::Raw::View;

sub gtk_source_view_get_completion (GtkSourceView $view)
  returns GtkSourceCompletion
  is native(sourceview)
  is export
  { * }

sub gtk_source_view_get_gutter (
  GtkSourceView $view, 
  guint $window_type              # GtkTextWindowType $window_type
)
  returns GtkSourceGutter
  is native(sourceview)
  is export
  { * }

sub gtk_source_view_get_mark_attributes (
  GtkSourceView $view, 
  gchar $category, 
  gint $priority
)
  returns GtkSourceMarkAttributes
  is native(sourceview)
  is export
  { * }

sub gtk_source_view_get_space_drawer (GtkSourceView $view)
  returns GtkSourceSpaceDrawer
  is native(sourceview)
  is export
  { * }

sub gtk_source_view_get_type ()
  returns GType
  is native(sourceview)
  is export
  { * }

sub gtk_source_view_get_visual_column (GtkSourceView $view, GtkTextIter $iter)
  returns guint
  is native(sourceview)
  is export
  { * }

sub gtk_source_view_indent_lines (
  GtkSourceView $view, 
  GtkTextIter $start, 
  GtkTextIter $end
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_view_new ()
  returns GtkWidget
  is native(sourceview)
  is export
  { * }

sub gtk_source_view_new_with_buffer (GtkSourceBuffer $buffer)
  returns GtkWidget
  is native(sourceview)
  is export
  { * }

sub gtk_source_view_set_mark_attributes (
  GtkSourceView $view, 
  gchar $category, 
  GtkSourceMarkAttributes $attributes, 
  gint $priority
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_view_unindent_lines (
  GtkSourceView $view, 
  GtkTextIter $start, 
  GtkTextIter $end
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_view_get_auto_indent (GtkSourceView $view)
  returns uint32
  is native(sourceview)
  is export
  { * }

sub gtk_source_view_get_background_pattern (GtkSourceView $view)
  returns guint # GtkSourceBackgroundPatternType
  is native(sourceview)
  is export
  { * }

sub gtk_source_view_get_highlight_current_line (GtkSourceView $view)
  returns uint32
  is native(sourceview)
  is export
  { * }

sub gtk_source_view_get_indent_on_tab (GtkSourceView $view)
  returns uint32
  is native(sourceview)
  is export
  { * }

sub gtk_source_view_get_indent_width (GtkSourceView $view)
  returns gint
  is native(sourceview)
  is export
  { * }

sub gtk_source_view_get_insert_spaces_instead_of_tabs (GtkSourceView $view)
  returns uint32
  is native(sourceview)
  is export
  { * }

sub gtk_source_view_get_right_margin_position (GtkSourceView $view)
  returns guint
  is native(sourceview)
  is export
  { * }

sub gtk_source_view_get_show_line_marks (GtkSourceView $view)
  returns uint32
  is native(sourceview)
  is export
  { * }

sub gtk_source_view_get_show_line_numbers (GtkSourceView $view)
  returns uint32
  is native(sourceview)
  is export
  { * }

sub gtk_source_view_get_show_right_margin (GtkSourceView $view)
  returns uint32
  is native(sourceview)
  is export
  { * }

sub gtk_source_view_get_smart_backspace (GtkSourceView $view)
  returns uint32
  is native(sourceview)
  is export
  { * }

sub gtk_source_view_get_smart_home_end (GtkSourceView $view)
  returns guint # GtkSourceSmartHomeEndType
  is native(sourceview)
  is export
  { * }

sub gtk_source_view_get_tab_width (GtkSourceView $view)
  returns guint
  is native(sourceview)
  is export
  { * }

sub gtk_source_view_set_auto_indent (GtkSourceView $view, gboolean $enable)
  is native(sourceview)
  is export
  { * }

sub gtk_source_view_set_background_pattern (
  GtkSourceView $view, 
  uint32 $background_pattern      # GtkSourceBackgroundPatternType
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_view_set_highlight_current_line (
  GtkSourceView $view, 
  gboolean $highlight
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_view_set_indent_on_tab (GtkSourceView $view, gboolean $enable)
  is native(sourceview)
  is export
  { * }

sub gtk_source_view_set_indent_width (GtkSourceView $view, gint $width)
  is native(sourceview)
  is export
  { * }

sub gtk_source_view_set_insert_spaces_instead_of_tabs (
  GtkSourceView $view, 
  gboolean $enable
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_view_set_right_margin_position (
  GtkSourceView $view, 
  guint $pos
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_view_set_show_line_marks (GtkSourceView $view, gboolean $show)
  is native(sourceview)
  is export
  { * }

sub gtk_source_view_set_show_line_numbers (
  GtkSourceView $view, 
  gboolean $show
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_view_set_show_right_margin (
  GtkSourceView $view, 
  gboolean $show
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_view_set_smart_backspace (
  GtkSourceView $view, 
  gboolean $smart_backspace
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_view_set_smart_home_end (
  GtkSourceView $view, 
  uint32 $smart_home_end          # GtkSourceSmartHomeEndType
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_view_set_tab_width (GtkSourceView $view, guint $width)
  is native(sourceview)
  is export
  { * }
