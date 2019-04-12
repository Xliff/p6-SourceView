use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;
use SourceViewGTK::Raw::Types;

use SourceViewGTK::Raw::SearchContext;

use GTK::Compat::Roles::Object;
use GTK::Roles::Types;

use GTK::TextIter;

use SourceViewGTK::Buffer;
use SourceViewGTK::SearchSettings;

class SourceViewGTK::SearchContext {
  also does GTK::Compat::Roles::Object;
  also does GTK::Roles::Types;
  
  has GtkSourceSearchContext $!ssc;
  
  submethod BUILD (:$context) {
    self!setObject($!ssc = $context);
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

  method match_style is rw is also<match-style> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_source_search_context_get_match_style($!ssc);
      },
      STORE => sub ($, $match_style is copy) {
        gtk_source_search_context_set_match_style($!ssc, $match_style);
      }
    );
  }
  
  multi method backward (
    GtkTextIter() $iter
  ) {
    my ($start, $end, $hwa) = ( |(GtkTextIter.new xx 2), 0 );
    samewith($iter, $start, $end, $hwa);
  }
  multi method backward (
    GtkTextIter() $iter, 
    GtkTextIter() $match_start, 
    GtkTextIter() $match_end, 
    $has_wrapped_around is rw
  ) {
    my gboolean $hwa = 0;
    my $rc = gtk_source_search_context_backward(
      $!ssc, 
      $iter, 
      $match_start, 
      $match_end, 
      $hwa
    );
    $has_wrapped_around = so $hwa;
    $rc ?? 
      (
        $match_start.defined ?? GTK::TextIter.new($match_start) !! Nil,
        $match_end.defined   ?? GTK::TextIter.new($match_end)   !! Nil,
        $has_wrapped_around
      )
      !!
      Nil;
  }

  proto method backward_async (|) 
    is also<backward-async>
  { * }
  
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

  # Handling should be done for all other _finish methods.
  proto method backward_finish (|)
    is also<backward-finish>
  { * }
  
  multi method backward_finish (GAsyncResult $result) {
    my ($start, $end, $wrapped) = ( |(GtkTextIter.new xx 2), 0 );
    samewith($result, $start, $end, $wrapped);
  }
  multi method backward_finish (
    GAsyncResult $result, 
    GtkTextIter() $match_start, 
    GtkTextIter() $match_end, 
    $has_wrapped_around is rw, 
    CArray[Pointer[GError]] $error = gerror()
  ) {
    clear_error;
    my guint $hwa = 0;
    my $rc = so gtk_source_search_context_backward_finish(
      $!ssc, 
      $result, 
      $match_start, 
      $match_end, 
      $hwa, 
      $error
    );
    $has_wrapped_around = so $hwa;
    set_error($error);
    say "BF: $rc";
    $rc ?? 
      (
        $match_start.defined ?? GTK::TextIter.new($match_start) !! Nil,
        $match_end.defined   ?? GTK::TextIter.new($match_end)   !! Nil,
        $has_wrapped_around
      )
      !!
      Nil;
  }

  multi method forward (
    GtkTextIter() $iter
  ) {
    my ($start, $end, $hwa) = ( |(GtkTextIter.new xx 2), 0 );
    samewith($iter, $start, $end, $hwa);
  }
  multi method forward (
    GtkTextIter() $iter, 
    GtkTextIter() $match_start, 
    GtkTextIter() $match_end, 
    $has_wrapped_around is rw
  ) {
    my gboolean $hwa = 0;
    my $rc = gtk_source_search_context_forward(
      $!ssc, 
      $iter, 
      $match_start, 
      $match_end, 
      $hwa
    );
    $has_wrapped_around = so $hwa;
    $rc ?? 
      (
        $match_start.defined ?? GTK::TextIter.new($match_start) !! Nil,
        $match_end.defined   ?? GTK::TextIter.new($match_end)   !! Nil,
        $has_wrapped_around
      )
      !!
      Nil;
  }

  proto method forward_async (|)
    is also<forward-async>
  { * }
  
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

  proto method forward_finish (|) 
    is also<forward-finish>
  { * }
  
  multi method forward_finish (
    GAsyncResult $result 
  ) {
    my ($start, $end, $wrapped) = ( |(GtkTextIter.new xx 2), 0 );
    samewith($result, $start, $end, $wrapped);
  }
  multi method forward_finish (
    GAsyncResult $result, 
    GtkTextIter() $match_start, 
    GtkTextIter() $match_end, 
    $has_wrapped_around is rw, 
    CArray[Pointer[GError]] $error = gerror()
  ) {
    my guint $hwa = 0;
    clear_error;
    my $rc = so gtk_source_search_context_forward_finish(
      $!ssc, 
      $result, 
      $match_start, 
      $match_end, 
      $hwa, 
      $error
    );
    $has_wrapped_around = so $hwa;
    say "FF: $rc";
    set_error($error);
    
    say "E: { $error[0].deref.gist }" with $error[0];
    
    $rc ?? 
      (
        $match_start.defined ?? GTK::TextIter.new($match_start) !! Nil,
        $match_end.defined   ?? GTK::TextIter.new($match_end)   !! Nil,
        $has_wrapped_around
      )
      !!
      Nil;
  }

  method get_buffer 
    is also<
      buffer
      get-buffer
    > 
  {
    SourceViewGTK::Buffer.new( gtk_source_search_context_get_buffer($!ssc) );
  }

  method get_occurrence_position (
    GtkTextIter() $match_start, 
    GtkTextIter() $match_end
  )  
    is also<get-occurences-position> 
  {
    gtk_source_search_context_get_occurrence_position(
      $!ssc, 
      $match_start, 
      $match_end
    );
  }

  # CANNOT offer simplified aliases on this method as it would conflict with
  # the signal named "occurences-count".
  method get_occurrences_count 
    is also<get-occurences-count> 
  {
    gtk_source_search_context_get_occurrences_count($!ssc);
  }

  method get_regex_error 
    is also<
      get-regex-error
      regex_error
      regex-error
    >
  {
    gtk_source_search_context_get_regex_error($!ssc);
  }

  method get_settings
    is also<
      get-settings
      settings
    >
  {
    SourceViewGTK::SearchSettings.new(
      gtk_source_search_context_get_settings($!ssc)
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( 
      self.^name, 
      gtk_source_search_context_get_type, 
      $n, 
      $t 
    )
  }

  method replace (
    GtkTextIter() $match_start, 
    GtkTextIter() $match_end, 
    Str() $replace, 
    Int() $replace_length, 
    CArray[Pointer[GError]] $error = gerror()
  ) {
    my gint $rl = self.RESOLVE-INT($replace_length);
    clear_error;
    my $rc = gtk_source_search_context_replace(
      $!ssc, 
      $match_start, 
      $match_end, 
      $replace, 
      $replace_length, 
      $error
    );
    set_error($error);
    $rc;
  }

  method replace_all (
    Str() $replace, 
    Int() $replace_length, 
    CArray[Pointer[GError]] $error = gerror()
  ) 
    is also<replace-all> 
  {
    my gint $rl = self.RESOLVE-INT($replace_length);
    clear_error;
    my $rc = gtk_source_search_context_replace_all(
      $!ssc, 
      $replace, 
      $replace_length, 
      $error
    );
    set_error($error);
    $rc;
  }

}
