use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;
use GTK::Raw::TextView;
use SourceViewGTK::Raw::Types;
use SourceViewGTK::Raw::View;

use GTK::Roles::Types;
use SourceViewGTK::Roles::Signals::View;

use GTK::TextView;
use SourceViewGTK::Buffer;

our subset SourceViewAncestry is export 
  where GtkSourceView | TextViewAncestry;

class SourceViewGTK::View is GTK::TextView {
  also does GTK::Roles::Types;
  also does SourceViewGTK::Roles::Signals::View;
  
  has GtkSourceView $!sv;
  
  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType(self.^name);
    $o;
  }
  
  submethod BUILD (:$view) {
    given $view {
      when SourceViewAncestry {
        self.setSourceView($view);
      }
      when SourceViewGTK::View {
      }
      default {
      }
    }
  }
  
  method setSourceView(SourceViewAncestry $view) {
    my $to-parent;
    given $view {
      $!sv = do {
        when GtkSourceView {
          $to-parent = nativecast(GtkTextView, $_);
          $_;
        }
        default {
          $to-parent = $_;
          nativecast(GtkSourceView, $_);
        }
      }
    }
    self.setTextView($to-parent);
  }
  
  submethod DESTROY {
    #self.disconnect-all($_) for %!signals-sv;
  }
  
  method SourceViewGTK::Raw::Types::GtkSourceView { $!sv }
  
  multi method new (GtkSourceView $view) {
    my $o = self.bless(:$view);
    $o.upref;
    $o;
  }
  
  multi method new {
    self.bless( view => gtk_source_view_new() );
  }

  method new_with_buffer(GtkSourceBuffer $buffer) is also<new-with-buffer> {
    self.bless( view => gtk_source_view_new_with_buffer($buffer) );
  }
  
  # Is originally:
  # GtkSourceView, GtkSourceChangeCaseType, gpointer --> void
  method change-case is also<change_case> {
    self.connect-change-case($!sv);
  }

  # Is originally:
  # GtkSourceView, gint, gpointer --> void
  method change-number is also<change_number> {
    self.connect-int($!sv, 'change-number');
  }

  # Is originally:
  # GtkSourceView, gpointer --> void
  method join-lines is also<join_lines> {
    self.connect($!sv, 'join-lines');
  }

  # Is originally:
  # GtkSourceView, GtkTextIter, GdkEvent, gpointer --> void
  method line-mark-activated is also<line_mark_activated> {
    self.connect-line-mark-activated($!sv);
  }

  # Is originally:
  # GtkSourceView, gboolean, gpointer --> void
  method move-lines is also<move_lines> {
    self.connect-uint($!sv, 'move-lines');
  }

  # Is originally:
  # GtkSourceView, gboolean, gpointer --> void
  method move-to-matching-bracket is also<move_to_matching_bracket> {
    self.connect-uint($!sv, 'move-to-matching-bracket');
  }

  # Is originally:
  # GtkSourceView, gint, gpointer --> void
  method move-words is also<move_words> {
    self.connect-int($!sv, 'move-words');
  }

  # Is originally:
  # GtkSourceView, gpointer --> void
  method redo {
    self.connect($!sv, 'redo');
  }

  # Is originally:
  # GtkSourceView, gpointer --> void
  method show-completion is also<show_completion> {
    self.connect($!sv, 'show-completion');
  }

  # Is originally:
  # GtkSourceView, GtkTextIter, gint, gpointer --> void
  #
  # Postfixed with "-signal" so as to not conflict with the "attribute"
  method smart-home-end-signal is also<smart_home_end_signal> {
    self.connect-smart-home-end($!sv);
  }

  # Is originally:
  # GtkSourceView, gpointer --> void
  method undo {
    self.connect($!sv, 'undo');
  }
  
  method auto_indent is rw is also<auto-indent> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_source_view_get_auto_indent($!sv);
      },
      STORE => sub ($, Int() $enable is copy) {
        my guint $e = self.RESOLVE-UINT($enable);
        gtk_source_view_set_auto_indent($!sv, $e);
      }
    );
  }
  
  method buffer is rw {
    Proxy.new: 
      FETCH => -> $ { 
        SourceViewGTK::Buffer.new( 
          gtk_text_view_get_buffer(self.TextView)
        );
      },
      # The lack of type coercion here is correct. That should be handled 
      # by the parent.
      STORE => -> $, $val {
        # callsame shold return the Proxy.
        callsame() = $val;
      }
  }

  method background_pattern is rw is also<background-pattern> {
    Proxy.new(
      FETCH => sub ($) {
        GtkSourceBackgroundPatternType(
          gtk_source_view_get_background_pattern($!sv)
        );
      },
      STORE => sub ($, Int() $background_pattern is copy) {
        my guint $bp = self.RESOLVE-UINT($background_pattern);
        gtk_source_view_set_background_pattern($!sv, $bp);
      }
    );
  }

  method highlight_current_line is rw is also<highlight-current-line> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_source_view_get_highlight_current_line($!sv);
      },
      STORE => sub ($, Int() $highlight is copy) {
        my guint $h = self.RESOLVE-UINT($highlight);
        gtk_source_view_set_highlight_current_line($!sv, $h);
      }
    );
  }

  method indent_on_tab is rw is also<indent-on-tab> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_source_view_get_indent_on_tab($!sv);
      },
      STORE => sub ($, Int() $enable is copy) {
        my guint $e = self.RESOLVE-UINT($enable);
        gtk_source_view_set_indent_on_tab($!sv, $e);
      }
    );
  }

  method indent_width is rw is also<indent-width> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_source_view_get_indent_width($!sv);
      },
      STORE => sub ($, Int() $width is copy) {
        my gint $w = self.RESOLVE-INT($width);
        gtk_source_view_set_indent_width($!sv, $w);
      }
    );
  }

  method insert_spaces_instead_of_tabs 
    is rw 
    is also<insert-spaces-instead-of-tabs> 
  {
    Proxy.new(
      FETCH => sub ($) {
        gtk_source_view_get_insert_spaces_instead_of_tabs($!sv);
      },
      STORE => sub ($, Int() $enable is copy) {
        my guint $e = self.RESOLVE-UINT($enable);
        gtk_source_view_set_insert_spaces_instead_of_tabs($!sv, $e);
      }
    );
  }

  method right_margin_position is rw is also<right-margin-position> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_source_view_get_right_margin_position($!sv);
      },
      STORE => sub ($, Int() $pos is copy) {
        my gint $p = self.RESOLVE-INT($pos);
        gtk_source_view_set_right_margin_position($!sv, $p);
      }
    );
  }

  method show_line_marks is rw is also<show-line-marks> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_source_view_get_show_line_marks($!sv);
      },
      STORE => sub ($, $show is copy) {
        gtk_source_view_set_show_line_marks($!sv, $show);
      }
    );
  }

  method show_line_numbers is rw is also<show-line-numbers> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_source_view_get_show_line_numbers($!sv);
      },
      STORE => sub ($, Int() $show is copy) {
        my guint $s = self.RESOLVE-UINT($show);
        gtk_source_view_set_show_line_numbers($!sv, $s);
      }
    );
  }

  method show_right_margin is rw is also<show-right-margin> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_source_view_get_show_right_margin($!sv);
      },
      STORE => sub ($, Int() $show is copy) {
        my guint $s = self.RESOLVE-UINT($show);
        gtk_source_view_set_show_right_margin($!sv, $s);
      }
    );
  }

  method smart_backspace is rw is also<smart-backspace> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_source_view_get_smart_backspace($!sv);
      },
      STORE => sub ($, Int() $smart_backspace is copy) {
        my guint $s = self.RESOLVE-UINT($smart_backspace);
        gtk_source_view_set_smart_backspace($!sv, $s);
      }
    );
  }

  method smart_home_end is rw is also<smart-home-end> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_source_view_get_smart_home_end($!sv);
      },
      STORE => sub ($, $smart_home_end is copy) {
        my guint $s = self.RESOLVE-UINT($smart_home_end);
        gtk_source_view_set_smart_home_end($!sv, $s);
      }
    );
  }

  method tab_width is rw is also<tab-width> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_source_view_get_tab_width($!sv);
      },
      STORE => sub ($, $width is copy) {
        gtk_source_view_set_tab_width($!sv, $width);
      }
    );
  }
  
  method get_completion is also<get-completion> {
    gtk_source_view_get_completion($!sv);
  }

  method get_gutter (
    uint32 $window_type           # GtkTextWindowType
  ) 
    is also<get-gutter> 
  {
    gtk_source_view_get_gutter($!sv, $window_type);
  }

  method get_mark_attributes (Str() $category, Int() $priority) 
    is also<get-mark-attributes> 
  {
    my gint $p = self.RESOLVE-INT($priority);
    gtk_source_view_get_mark_attributes($!sv, $category, $p);
  }

  method get_space_drawer 
    is also<
      get-space-drawer 
      space-drawer 
      space_drawer
    > 
  {
    SourceViewGTK::SpaceDrawer.new( 
      gtk_source_view_get_space_drawer($!sv)
    );
  }

  method get_type is also<get-type> {
    gtk_source_view_get_type();
  }

  method get_visual_column (GtkTextIter() $iter) is also<get-visual-column> {
    gtk_source_view_get_visual_column($!sv, $iter);
  }

  method indent_lines (GtkTextIter() $start, GtkTextIter() $end) 
    is also<indent-lines> 
  {
    gtk_source_view_indent_lines($!sv, $start, $end);
  }

  method set_mark_attributes (
    Str() $category, 
    GtkSourceMarkAttributes() $attributes, 
    gint $priority
  ) 
    is also<set-mark-attributes> 
  {
    gtk_source_view_set_mark_attributes(
      $!sv, 
      $category, 
      $attributes, 
      $priority
    );
  }

  method unindent_lines (GtkTextIter() $start, GtkTextIter() $end) 
    is also<unindent-lines> 
  {
    gtk_source_view_unindent_lines($!sv, $start, $end);
  }

}
