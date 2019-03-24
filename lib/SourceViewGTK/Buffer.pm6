use v6.c;

use GTK::Compat::Types;
use GTK::Raw::Types;
use SourceViewGTK::Raw::Types;

use GTK::Roles::Types;

use SourceViewGTK::Roles::Signals::Buffer;

use GTK::TextView;

class SourceViewGTK::Buffer is GTK::TextBuffer {
  also does GTK::Roles::Types;
  also does GTK::SourceView::Roles::Buffer;
  
  has GtkSourceBuffer $!sb
  
  submethod BUILD (:$buffer) {
    self.setTextBuffer( $!sb = $buffer );
  }
  
  method new {
    self.bless( buffer => gtk_source_buffer_new() );
  }
  
  # Is originally:
  # GtkSourceBuffer, GtkTextIter, GtkSourceBracketMatchType, gpointer --> void
  method bracket-matched {
    self.connect-bracket-matched($!w);
  }

  # Is originally:
  # GtkSourceBuffer, GtkTextIter, GtkTextIter, gpointer --> void
  method highlight-updated {
    self.connect-highlight-updated($!w);
  }

  # Is originally:
  # GtkSourceBuffer, gpointer --> void
  method redo {
    self.connect($!w, 'redo');
  }

  # Is originally:
  # GtkSourceBuffer, GtkTextMark, gpointer --> void
  method source-mark-updated {
    self.connect-source-mark-updated($!w);
  }

  # Is originally:
  # GtkSourceBuffer, gpointer --> void
  method undo {
    self.connect($!w, 'undo');
  }
  
  method highlight_matching_brackets is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_source_buffer_get_highlight_matching_brackets($!sv);
      },
      STORE => sub ($, Int() $highlight is copy) {
        my gboolean $h = self.RESOLVE-BOOL($highlight);
        gtk_source_buffer_set_highlight_matching_brackets($!sv, $h);
      }
    );
  }

  method highlight_syntax is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_source_buffer_get_highlight_syntax($!sv);
      },
      STORE => sub ($, Int() $highlight is copy) {
        my gboolean $h = self.RESOLVE-BOOL($highlight);
        gtk_source_buffer_set_highlight_syntax($!sv, $h);
      }
    );
  }

  method implicit_trailing_newline is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_source_buffer_get_implicit_trailing_newline($!sv);
      },
      STORE => sub ($, Int() $implicit_trailing_newline is copy) {
        my gboolean $itn = self.RESOLVE-BOOL($implicit_trailing_newline);
        gtk_source_buffer_set_implicit_trailing_newline($!sv, $itn);
      }
    );
  }

  method language is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkSourceLanguage( gtk_source_buffer_get_language($!sv) );
      },
      STORE => sub ($, Int() $language is copy) {
        my guint $l = self.RESOLVE-UINT($language);
        gtk_source_buffer_set_language($!sv, $l);
      }
    );
  }

  method max_undo_levels is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_source_buffer_get_max_undo_levels($!sv);
      },
      STORE => sub ($, Int() $max_undo_levels is copy) {
        my gint $mul = self.RESOLVE-INT($mul);
        gtk_source_buffer_set_max_undo_levels($!sv, $mul);
      }
    );
  }

  method style_scheme is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_source_buffer_get_style_scheme($!sv);
      },
      STORE => sub ($, $scheme is copy) {
        gtk_source_buffer_set_style_scheme($!sv, $scheme);
      }
    );
  }

  method undo_manager is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkSourceStyleScheme( gtk_source_buffer_get_undo_manager($!sv) );
      },
      STORE => sub ($, Int() $manager is copy) {
        my guint $m = self.RESOLVE-UINT($manager);
        gtk_source_buffer_set_undo_manager($!sv, $m);
      }
    );
  }
  
  method backward_iter_to_source_mark (
    GtkTextIter() $iter, 
    Str() $category
  ) {
    gtk_source_buffer_backward_iter_to_source_mark($!sb, $iter, $category);
  }

  method begin_not_undoable_action {
    gtk_source_buffer_begin_not_undoable_action($!sb);
  }

  method can_redo {
    gtk_source_buffer_can_redo($!sb);
  }

  method can_undo {
    gtk_source_buffer_can_undo($!sb);
  }

  method change_case (
    GtkSourceChangeCaseType $case_type, 
    GtkTextIter() $start, 
    GtkTextIter() $end
  ) {
    gtk_source_buffer_change_case($!sb, $case_type, $start, $end);
  }

  method create_source_mark (
    Str() $name, 
    Str() $category, 
    GtkTextIter() $where
  ) {
    gtk_source_buffer_create_source_mark($!sb, $name, $category, $where);
  }

  method end_not_undoable_action {
    gtk_source_buffer_end_not_undoable_action($!sb);
  }

  method ensure_highlight (GtkTextIter() $start, GtkTextIter() $end) {
    gtk_source_buffer_ensure_highlight($!sb, $start, $end);
  }

  method forward_iter_to_source_mark (GtkTextIter() $iter, Str() $category) {
    gtk_source_buffer_forward_iter_to_source_mark($!sb, $iter, $category);
  }

  method get_context_classes_at_iter (GtkTextIter() $iter) {
    gtk_source_buffer_get_context_classes_at_iter($!sb, $iter);
  }

  method get_source_marks_at_iter (GtkTextIter() $iter, Str() $category) {
    gtk_source_buffer_get_source_marks_at_iter($!sb, $iter, $category);
  }

  method get_source_marks_at_line (Int() $line, Str() $category) {
    my gint $l = self.RESOLVE-INT($line);
    gtk_source_buffer_get_source_marks_at_line($!sb, $l, $category);
  }

  method get_type {
    gtk_source_buffer_get_type();
  }

  method iter_backward_to_context_class_toggle (
    GtkTextIter() $iter, 
    Str() $context_class
  ) {
    gtk_source_buffer_iter_backward_to_context_class_toggle(
      $!sb, 
      $iter, 
      $context_class
    );
  }

  method iter_forward_to_context_class_toggle (
    GtkTextIter() $iter, 
    Str() $context_class
  ) {
    gtk_source_buffer_iter_forward_to_context_class_toggle(
      $!sb, 
      $iter, 
      $context_class
    );
  }

  method iter_has_context_class (
    GtkTextIter() $iter, 
    Str() $context_class
  ) {
    gtk_source_buffer_iter_has_context_class(
      $!sb, 
      $iter, 
      $context_class
    );
  }

  method join_lines (GtkTextIter() $start, GtkTextIter() $end) {
    gtk_source_buffer_join_lines($!sb, $start, $end);
  }

  method new_with_language {
    gtk_source_buffer_new_with_language($!sb);
  }

  method redo {
    gtk_source_buffer_redo($!sb);
  }

  method remove_source_marks (
    GtkTextIter() $start, 
    GtkTextIter() $end, 
    Str() $category
  ) {
    gtk_source_buffer_remove_source_marks($!sb, $start, $end, $category);
  }

  method sort_lines (
    GtkTextIter() $start, 
    GtkTextIter() $end, 
    Int() $flags,               # GtkSourceSortFlags
    Int() $column
  ) {
    my guint $f = self.RESOLVE-UINT($flags);
    my gint $c = self.RESOLVE-INT($column)l
    gtk_source_buffer_sort_lines($!sb, $start, $end, $f, $c);
  }

  method undo {
    gtk_source_buffer_undo($!sb);
  }
  
}
