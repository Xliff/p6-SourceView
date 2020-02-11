use v6.c;

use Method::Also;
use NativeCall;

use SourceViewGTK::Raw::Types;
use SourceViewGTK::Raw::SearchContext;

use GTK::TextIter;
use SourceViewGTK::Buffer;
use SourceViewGTK::SearchSettings;
use SourceViewGTK::Style;

use GLib::Roles::Object;

class SourceViewGTK::SearchContext {
  also does GLib::Roles::Object;

  has GtkSourceSearchContext $!ssc;

  submethod BUILD (:$context) {
    self!setObject($!ssc = $context);
  }

  method SourceViewGTK::Raw::Definitions::GtkSourceSearchContext
    is also<GtkSourceSearchContext>
  { $!ssc }

  multi method new (GtkSourceSearchContext $context) {
    $context ?? self.bless( :$context ) !! Nil;
  }
  multi method new (
    GtkSourceBuffer() $buffer,
    GtkSourceSearchSettings() $settings
  ) {
    my $context = gtk_source_search_context_new($buffer, $settings);

    $context ?? self.bless( :$context ) !! Nil;
  }

  method highlight is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_source_search_context_get_highlight($!ssc);
      },
      STORE => sub ($, Int() $highlight is copy) {
        my gboolean $h = $highlight.so.Int;

        gtk_source_search_context_set_highlight($!ssc, $h);
      }
    );
  }

  method match_style (:$raw = False) is rw is also<match-style> {
    Proxy.new(
      FETCH => sub ($) {
        my $s = gtk_source_search_context_get_match_style($!ssc);

        $s ??
          ( $raw ?? $s !! SourceViewGTK::Style.new($s) )
          !!
          Nil;
      },
      STORE => sub ($, GtkSourceStyle() $match_style is copy) {
        gtk_source_search_context_set_match_style($!ssc, $match_style);
      }
    );
  }

  # This may best answer the question posed earlier in the refinement review
  # process!
  multi method backward (
    GtkTextIter() $iter,
    :$raw = False
  ) {
    my ($start, $end, $hwa) = ( |(GtkTextIter.new xx 2), 0 );
    samewith($iter, $start, $end, $hwa, :$raw);
  }
  multi method backward (
    GtkTextIter() $iter,
    GtkTextIter() $match_start,
    GtkTextIter() $match_end,
    $has_wrapped_around is rw,
    :$raw = False
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
        $match_start.defined ?? ( $raw ?? $match_start !!
                                          GTK::TextIter.new($match_start) ) !!
                                Nil,
        $match_end.defined   ?? ( $raw ?? $match_end   !!
                                          GTK::TextIter.new($match_end) )   !!
                                Nil,
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
    gpointer $user_data       = gpointer,
  ) {
    samewith($iter, GCancellable, &callback, $user_data);
  }
  multi method backward_async (
    GtkTextIter() $iter,
    GCancellable() $cancellable,
    &callback,
    gpointer $user_data = gpointer
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

  multi method backward_finish (GAsyncResult() $result, :$raw = False) {
    my ($start, $end, $wrapped) = ( |(GtkTextIter.new xx 2), 0 );
    samewith($result, $start, $end, $wrapped, :$raw);
  }
  multi method backward_finish (
    GAsyncResult $result,
    GtkTextIter() $match_start,
    GtkTextIter() $match_end,
    $has_wrapped_around is rw,
    CArray[Pointer[GError]] $error = gerror,
    :$raw = False
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
        $match_start.defined ?? ( $raw ?? $match_start !!
                                          GTK::TextIter.new($match_start) ) !!
                                Nil,
        $match_end.defined   ?? ( $raw ?? $match_end   !!
                                          GTK::TextIter.new($match_end) )   !!
                                Nil,
        $has_wrapped_around
      )
      !!
      Nil;
  }

  multi method forward (
    GtkTextIter() $iter,
    :$raw = False
  ) {
    my ($start, $end, $hwa) = ( |(GtkTextIter.new xx 2), 0 );
    samewith($iter, $start, $end, $hwa, :$raw);
  }
  multi method forward (
    GtkTextIter() $iter,
    GtkTextIter() $match_start,
    GtkTextIter() $match_end,
    $has_wrapped_around is rw,
    :$raw = False
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
        $match_start.defined ?? ( $raw ?? $match_start !!
                                          GTK::TextIter.new($match_start) ) !!
                                Nil,
        $match_end.defined   ?? ( $raw ?? $match_end   !!
                                          GTK::TextIter.new($match_end) )   !!
                                Nil,
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
    gpointer $user_data       = gpointer
  ) {
    samewith($iter, GCancellable, &callback, $user_data);
  }
  multi method forward_async (
    GtkTextIter() $iter,
    GCancellable() $cancellable,
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
    GAsyncResult() $result,
    :$raw = False
  ) {
    my ($start, $end, $wrapped) = ( |(GtkTextIter.new xx 2), 0 );
    samewith($result, $start, $end, $wrapped, :$raw);
  }
  multi method forward_finish (
    GAsyncResult() $result,
    GtkTextIter() $match_start,
    GtkTextIter() $match_end,
    $has_wrapped_around is rw,
    CArray[Pointer[GError]] $error = gerror,
    :$raw = False
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
        $match_start.defined ?? ($raw ?? $match_start !!
                                         GTK::TextIter.new($match_start) ) !!
                                Nil,
        $match_end.defined   ?? ($raw ?? $match_end   !!
                                         GTK::TextIter.new($match_end) )   !!
                                Nil,
        $has_wrapped_around
      )
      !!
      Nil;
  }

  method get_buffer (:$raw = False)
    is also<
      buffer
      get-buffer
    >
  {
    my $b = gtk_source_search_context_get_buffer($!ssc);

    $b ??
      ( $raw ?? $b !! SourceViewGTK::Buffer.new($b) )
      !!
      Nil;
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

  method get_settings (:$raw = False)
    is also<
      get-settings
      settings
    >
  {
    my $s = gtk_source_search_context_get_settings($!ssc);

    $s ??
      ( $raw ?? $s !! SourceViewGTK::SearchSettings.new($s) )
      !!
      Nil;
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
    my gint $rl = $replace_length;

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
    my gint $rl = $replace_length;

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
