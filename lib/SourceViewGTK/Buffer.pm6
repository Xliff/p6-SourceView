use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;
use SourceViewGTK::Raw::Buffer;
use SourceViewGTK::Raw::Types;

use GTK::Roles::Types;
use GTK::Roles::References;
use SourceViewGTK::Roles::Signals::Buffer;

use GTK::TextBuffer;

use SourceViewGTK::Language;
use SourceViewGTK::Tag;

our subset SourceBufferAncestry is export
  where GtkSourceBuffer | GtkTextBuffer;

class SourceViewGTK::Buffer is GTK::TextBuffer {
  also does GTK::Roles::Types;
  
  has GtkSourceBuffer $!sb;
  
  submethod BUILD (:$buffer) {
    my $to-parent;
    given $buffer {
      when SourceBufferAncestry {
        $!sb = do {
          when GtkSourceBuffer {
            $to-parent = nativecast(GtkTextBuffer, $_);
            $_;
          } 
          default {
            $to-parent = $_;
            nativecast(GtkSourceBuffer, $_);
          }
        }
        self.setTextBuffer($to-parent);
      }
      when SourceViewGTK::Buffer {
      }
      default {
      }
    }
  }
  
  method SourceViewGTK::Raw::Types::GtkSourceBuffer 
    #is also<SourceBuffer>
    { $!sb }
  
  proto method new (|) { * }
  
  multi method new (SourceBufferAncestry $buffer) {
    self.bless(:$buffer);
  }
  multi method new (GtkTextTagTable() $table) {
    self.bless( buffer => gtk_source_buffer_new($table) );
  }
  
  method new_with_language (GtkSourceViewLanguage() $language) {
    gtk_source_buffer_new_with_language($language);
  }
  
  # Is originally:
  # GtkSourceBuffer, GtkTextIter, GtkSourceBracketMatchType, gpointer --> void
  method bracket-matched {
    self.connect-bracket-matched($!sb);
  }

  # Is originally:
  # GtkSourceBuffer, GtkTextIter, GtkTextIter, gpointer --> void
  method highlight-updated {
    self.connect-highlight-updated($!sb);
  }

  # Is originally:
  # GtkSourceBuffer, gpointer --> void
  method redo {
    self.connect($!sb, 'redo');
  }

  # Is originally:
  # GtkSourceBuffer, GtkTextMark, gpointer --> void
  method source-mark-updated {
    self.connect-source-mark-updated($!sb);
  }

  # Is originally:
  # GtkSourceBuffer, gpointer --> void
  method undo {
    self.connect($!sb, 'undo');
  }
  
  method highlight_matching_brackets is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_source_buffer_get_highlight_matching_brackets($!sb);
      },
      STORE => sub ($, Int() $highlight is copy) {
        my gboolean $h = self.RESOLVE-BOOL($highlight);
        gtk_source_buffer_set_highlight_matching_brackets($!sb, $h);
      }
    );
  }

  method highlight_syntax is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_source_buffer_get_highlight_syntax($!sb);
      },
      STORE => sub ($, Int() $highlight is copy) {
        my gboolean $h = self.RESOLVE-BOOL($highlight);
        gtk_source_buffer_set_highlight_syntax($!sb, $h);
      }
    );
  }

  method implicit_trailing_newline is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_source_buffer_get_implicit_trailing_newline($!sb);
      },
      STORE => sub ($, Int() $implicit_trailing_newline is copy) {
        my gboolean $itn = self.RESOLVE-BOOL($implicit_trailing_newline);
        gtk_source_buffer_set_implicit_trailing_newline($!sb, $itn);
      }
    );
  }

  method language is rw {
    Proxy.new(
      FETCH => sub ($) {
        SourceViewGTK::Language.new( gtk_source_buffer_get_language($!sb) );
      },
      STORE => sub ($, GtkSourceLanguage() $language is copy) {
        gtk_source_buffer_set_language($!sb, $language);
      }
    );
  }

  method max_undo_levels is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_source_buffer_get_max_undo_levels($!sb);
      },
      STORE => sub ($, Int() $max_undo_levels is copy) {
        my gint $mul = self.RESOLVE-INT($max_undo_levels);
        gtk_source_buffer_set_max_undo_levels($!sb, $mul);
      }
    );
  }

  method style_scheme is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_source_buffer_get_style_scheme($!sb);
      },
      STORE => sub ($, $scheme is copy) {
        gtk_source_buffer_set_style_scheme($!sb, $scheme);
      }
    );
  }

  method undo_manager is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkSourceStyleScheme( gtk_source_buffer_get_undo_manager($!sb) );
      },
      STORE => sub ($, GtkSourceViewUndoManager() $manager is copy) {
        gtk_source_buffer_set_undo_manager($!sb, $manager);
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
  
  method create_source_tag ( 
    Str() $tag_name,
    Str() $prop_name,
    Int() $prop_val,
  ) {
    my guint $pv = self.RESOLVE-UINT($prop_val);
    SourceViewGTK::Tag.new(
      gtk_source_buffer_create_source_tag(
        $!sb, 
        $tag_name, 
        $prop_name, 
        $pv, 
        Str
      )
    );
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

  method emit-redo {
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
    my gint $c = self.RESOLVE-INT($column);
    gtk_source_buffer_sort_lines($!sb, $start, $end, $f, $c);
  }

  method emit-undo {
    gtk_source_buffer_undo($!sb);
  }
  
}
