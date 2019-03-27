use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;
use SourceViewGTK::Raw::Types;

use SourceViewGTK::Raw::SearchContext;

use GTK::Roles::Types;

use SourceViewGTK::SearchSettings;

class SourceViewGTK::SearchContext {
  also does GTK::Roles::Types;
  
  has GtkSourceSearchContext $!ssc;
  
  submethod BUILD (:$context) {
    $!ssc = $context;
  }
  
  method SourceViewGTK::Raw::Types::GtkSourceSearchContext { $!ssc }
  
  method new (
    GtkSourceBuffer() $buffer, 
    GtkSourceSearchSettings() $settings
  ) {
    self.bless( 
      context => gtk_source_search_context_new($buffer, $settings) 
    );
  }
  
  method highlight is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_source_search_context_get_highlight($!ssc);
      },
      STORE => sub ($, $highlight is copy) {
        gtk_source_search_context_set_highlight($!ssc, $highlight);
      }
    );
  }

  method match_style is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_source_search_context_get_match_style($!ssc);
      },
      STORE => sub ($, $match_style is copy) {
        gtk_source_search_context_set_match_style($!ssc, $match_style);
      }
    );
  }
  
  method backward (
    GtkTextIter() $iter, 
    GtkTextIter() $match_start, 
    GtkTextIter() $match_end, 
    Int() $has_wrapped_around
  ) {
    my gboolean $hwa = self.RESOLVE-BOOL($has_wrapped_around);
    gtk_source_search_context_backward(
      $!ssc, 
      $iter, 
      $match_start, 
      $match_end, 
      $hwa
    );
  }

  multi method backward_async (
    GtkTextIter() $iter, 
    &callback,
    gpointer $user_data       = Pointer,
    GCancellable $cancellable = Pointer
  ) {
    samewith($iter, $cancellable, &callback, $user_data);
  }
  multi method backward_async (
    GtkTextIter() $iter, 
    GCancellable $cancellable, 
    &callback, 
    gpointer $user_data
  ) {
    gtk_source_search_context_backward_async(
      $!ssc, 
      $iter, 
      $cancellable, 
      &callback, 
      $user_data
    );
  }

  method backward_finish (
    GAsyncResult $result, 
    GtkTextIter() $match_start, 
    GtkTextIter() $match_end, 
    Int() $has_wrapped_around, 
    CArray[Pointer[GError]] $error = gerror()
  ) {
    my gboolean $hwa = self.RESOLVE-BOOL($has_wrapped_around);
    $ERROR = Nil;
    my $rc = gtk_source_search_context_backward_finish(
      $!ssc, 
      $result, 
      $match_start, 
      $match_end, 
      $hwa, 
      $error
    );
    $ERROR = $error[0] with $error[0];
    $rc;
  }

  method forward (
    GtkTextIter() $iter, 
    GtkTextIter() $match_start, 
    GtkTextIter() $match_end, 
    Int() $has_wrapped_around
  ) {
    my gboolean $hwa = self.RESOLVE-BOOL($has_wrapped_around);
    gtk_source_search_context_forward(
      $!ssc, 
      $iter, 
      $match_start, 
      $match_end, 
      $has_wrapped_around
    );
  }

  multi method forward_async(
    GtkTextIter() $iter, 
    &callback, 
    GCancellable $cancellable = Pointer, 
    gpointer $user_data       = Pointer
  ) {
    samewith($iter, $cancellable, &callback, $user_data);
  }
  multi method forward_async (
    GtkTextIter() $iter, 
    GCancellable $cancellable, 
    &callback, 
    gpointer $user_data
  ) {
    gtk_source_search_context_forward_async(
      $!ssc, 
      $iter, 
      $cancellable, 
      &callback, 
      $user_data
    );
  }

  method forward_finish (
    GAsyncResult $result, 
    GtkTextIter() $match_start, 
    GtkTextIter() $match_end, 
    Int() $has_wrapped_around, 
    CArray[Pointer[GError]] $error
  ) {
    $ERROR = Nil;
    my gboolean $hwa = self.RESOLVE-BOOL($has_wrapped_around);
    my $rc = gtk_source_search_context_forward_finish(
      $!ssc, 
      $result, 
      $match_start, 
      $match_end, 
      $hwa, 
      $error
    );
    $ERROR = $error[0] with $error[0];
    $rc;
  }

  method get_buffer {
    gtk_source_search_context_get_buffer($!ssc);
  }

  method get_occurrence_position (
    GtkTextIter() $match_start, 
    GtkTextIter() $match_end
  ) {
    gtk_source_search_context_get_occurrence_position(
      $!ssc, 
      $match_start, 
      $match_end
    );
  }

  method get_occurrences_count {
    gtk_source_search_context_get_occurrences_count($!ssc);
  }

  method get_regex_error {
    gtk_source_search_context_get_regex_error($!ssc);
  }

  method get_settings {
    SourceViewGTK::SearchSettings.new(
      gtk_source_search_context_get_settings($!ssc)
    );
  }

  method get_type {
    gtk_source_search_context_get_type();
  }

  method replace (
    GtkTextIter() $match_start, 
    GtkTextIter() $match_end, 
    Str() $replace, 
    Int() $replace_length, 
    CArray[Pointer[GError]] $error = gerror()
  ) {
    my gint $rl = self.RESOLVE-INT($replace_length);
    $ERROR = Nil;
    my $rc = gtk_source_search_context_replace(
      $!ssc, 
      $match_start, 
      $match_end, 
      $replace, 
      $replace_length, 
      $error
    );
    $ERROR = $error[0] with $error[0];
    $rc;
  }

  method replace_all (
    Str() $replace, 
    Int() $replace_length, 
    CArray[Pointer[GError]] $error = gerror()
  ) {
    my gint $rl = self.RESOLVE-INT($replace_length);
    $ERROR = Nil;
    my $rc = gtk_source_search_context_replace_all(
      $!ssc, 
      $replace, 
      $replace_length, 
      $error
    );
    $ERROR = $error[0] with $error[0];
    $rc;
  }

}
