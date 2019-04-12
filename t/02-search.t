use v6.c;

use GTK::Compat::Binding;
use GTK::Compat::Signal;
use GTK::Compat::Types;

use GTK::Raw::Subs;

use GTK::Application;
use GTK::Builder;
use GTK::TextBuffer;
use GTK::TextIter;

use SourceViewGTK::Language;
use SourceViewGTK::LanguageManager;
use SourceViewGTK::SearchContext;
use SourceViewGTK::SearchSettings;
use SourceViewGTK::View;
use SourceViewGTK::Utils;

use SourceViewGTK::Builder::Registry;

my (%globals, %settings);

sub open_file(Str $filename is copy) {
  my $contents;
  
  $filename = "t/{ $filename }" unless $filename.IO.e;
  
  die "Imposible to load file: { $filename }\n" 
    unless $filename.IO.e && ($contents = $filename.IO.slurp);
  
  %globals<source_buffer>.text = $contents;
  
  my $lang_man = SourceViewGTK::LanguageManager.get_default;
  my $lang = $lang_man.get_language('c');
  my $iter = %globals<source_buffer>.get_start_iter;
  
  %globals<source_buffer>.language = $lang;
  %globals<source_buffer>.select_range($iter, $iter);
}

sub update_label_occurrences {
  my $occ_count = %globals<search_context>.get_occurrences_count;
  my ($start, $end) = %globals<source_buffer>.get_selection_bounds;
  return unless $start.defined && $end.defined;
  my $occ_pos = %globals<search_context>.get_occurrence_position($start, $end);
  
  %globals<label_occurrences>.text = $occ_count == -1 ??
    '' !! $occ_pos == -1 ??
      "{ $occ_count } occurrences" !! "{ $occ_pos } of { $occ_count }";
}

sub update_label_regex_error {
  my $err = %globals<search_context>.get_regex_error;
  
  with $err {
    %globals<label_regex_error>.text = .message;
    %globals<label_regex_error>.show;
    clear_error($err);
  } else {
    %globals<label_regex_error>.text = '';
    %globals<label_regex_error>.hide;
  }
}

sub select_search_occurrence($start, $end) {
  %globals<source_buffer>.select_range($start, $end);
  my $insert = %globals<source_buffer>.get_insert;
  %globals<source_view>.scroll_mark_onscreen($insert) with $insert;
}

sub backward_search_finished($search_context, $result, $gerror) {
  CATCH { default { .message.say } }
        
  my @r = %globals<search_context>.backward_finish($result);
  select_search_occurrence(@r[0], @r[1]) if @r[0].defined && @r[1].defined;
}

sub forward_search_finished($search_context, $result, $gerror) {
  CATCH { default { .message.say } }

  my @r = %globals<search_context>.forward_finish($result);
  select_search_occurrence(@r[0], @r[1]) if @r[0].defined && @r[1].defined;
}

sub process_ui {
  my $dir = 'ui';
  $dir = "t/{ $dir }" unless $dir.IO.d;
  
  die 'Cannot find UI directory!' unless $dir.IO.e && $dir.IO.d;
  die 'Cannot find UI file!' unless 
    (my $filename = "{ $dir }/test-search.ui").IO.e;
  my $contents = $filename.IO.slurp;
  
  my regex quoted { \" ~ \" (<-[\"]>+) }
  $contents ~~ s:g{ '<template class='<quoted>' parent='<quoted> } =
                  "<object class=$/<quoted>[1] id=$/<quoted>[0]";
  $contents ~~ s:g!'</template>'!</object>!;
  $contents;
}

sub MAIN {
  my $ui-data = process_ui;
  
  my $a = GTK::Application.new( title => 'org.genex.sourceview.search' );
  my $dv = SourceViewGTK::View.new;
  
  # Register SourceViewGTK widgets.
  GTK::Builder.register( SourceViewGTK::Builder::Registry );
  
  my $b = GTK::Builder.new_from_string($ui-data);
  
  die 'GTK::Builder error' unless $b.keys;
  
  (%globals<source_buffer> = $b<source_view>.source_buffer).upref;
  open_file('gtksourceview/gtksourcesearchcontext.c');
  
  %globals{$_} := $b{$_} for $b.keys;
  %globals<settings> = SourceViewGTK::SearchSettings.new;
  %globals<search_context> = SourceViewGTK::SearchContext.new(
    %globals<source_buffer>, 
    %globals<settings>
  );
  
  #$b.add_callback_symbol('search_entry_changed_cb', -> $, $ {
  %globals<search_entry>.changed.tap(-> *@a {
    my $text = $b<search_entry>.text;
    my $utext = SourceViewGTK::Utils.unescape_search_text($text);
    %globals<settings>.search_text = $utext;
  });
  
  #$b.add_callback_symbol('button_previous_clicked_cb', -> $, $ {
  %globals<button_previous>.clicked.tap(-> *@a {
    my ($start, $) = %globals<source_buffer>.get_selection_bounds;
    %globals<search_context>.backward_async($start, &backward_search_finished);
  });
  
  #$b.add_callback_symbol('button_next_clicked_cb', -> $, $ {
  %globals<button_next>.clicked.tap(-> *@a {
    my ($, $start) = %globals<source_buffer>.get_selection_bounds;
    %globals<search_context>.forward_async($start, &forward_search_finished);
  });
  
  #$b.add_callback_symbol('button_replaced_clicked_cb', -> $, $ {
  %globals<button_replace>.clicked.tap(-> *@a {
    my ($start, $end) = %globals<source_buffer>.get_selection_bounds;
    my $len = $b<replace_entry>.buffer.get_bytes;
    
    %globals<search_context>.replace(
      $start, 
      $end, 
      $b<replace_entry>.text, 
      $len
    );
    
    ($start, $end) = %globals<source_buffer>.get_selection_bounds;
    %globals<search_context>.forward_async($end, &forward_search_finished);
  });
  
  #$b.add_callback_symbol('button_replace_all_clicked_cb', -> $, $ {
  %globals<button_replace_all>.clicked.tap(-> *@a {
    my $eb = %globals<replace_entry>.buffer;
    my $len = $eb.get_bytes;
    %globals<search_context>.replace_all(%globals<replace_entry>.text, $len);
  });
  
  %settings<highlight> = GTK::Compat::Binding.bind(
    %globals<search_context>, 
    'highlight', 
    %globals<checkbutton_highlight>,
    'active'
  );
  %settings{$_[0]} = GTK::Compat::Binding.bind(
    %globals<settings>, $_[0], $_[1], 'active'
  ) for (
    [ 'case-sensitive',     %globals<checkbutton_match_case>         ],
    [ 'at-word-boundaries', %globals<checkbutton_at_word_boundaries> ],
    [ 'wrap-around',        %globals<checkbutton_wrap_around>        ],
    [ 'regex-enabled',      %globals<checkbutton_regex>              ]
  );
    
  GTK::Compat::Signal.connect_swapped(
    %globals<search_context>,
    'notify::occurrences-count',
    -> *@a { 
      CATCH { default { .message.say } }
      update_label_occurrences;
    }
  );
  
  GTK::Compat::Signal.connect_swapped(
    %globals<search_context>,
    'notify::regex_error',
    -> *@a { 
      CATCH { default { .message.say } }
      update_label_regex_error(); 
    }
  );
  
  # Causes MoarVM panic: Internal error: Unwound entire stack and missed handler
  # Reason currently unknown.
  %globals<source_buffer>.mark-set.tap( -> *@a {
    CATCH { default { .message.say; } }
  
    my $insert = %globals<source_buffer>.get_insert;
    my $bound = %globals<source_buffer>.get_selection_bound;
    if 
      (@a[2].p == $insert.TextMark.p || @a[2].p == $bound.TextMark.p) 
      &&
      (%globals<idle_update_label_id> // 0) == 0
    {
      # g_idle_add should be place into an object, but for now...
      %globals<idle_update_label_id> = g_idle_add_rint(sub () returns guint {
        %globals<idle_update_label_id> = 0;
        update_label_occurrences;
        G_SOURCE_REMOVE;
      }, gpointer);
    }
  });
  
  $a.activate.tap({
    $a.wait-for-init;
    update_label_regex_error;
    $a.window.destroy-signal.tap({ $a.exit });
    $a.window.set_default_size(700, 500);
    $a.window.add($b<TestSearch>);
    $a.window.show_all;
  });
 
  $a.run;
}
