use v6.c;

use lib 't';

use Cairo;

use Pango::Raw::Types;
use Pango::Layout;

use GTK::Compat::Types;

use GTK::Compat::ContentType;
use GTK::Compat::Binding;
use GTK::Compat::File;
use GTK::Compat::Log;
use GTK::Compat::RGBA;

use GTK::Raw::Types;

use GTK::Application;
use GTK::Builder;
use GTK::Dialog::FileChooser;
use GTK::PrintOperation;
use GTK::PrintContext;
use GTK::TextMark;

use SourceViewGTK::Raw::Types;

use SourceViewGTK::Builder::Registry;
use SourceViewGTK::File;
use SourceViewGTK::FileLoader;
use SourceViewGTK::Language;
use SourceViewGTK::LanguageManager;
use SourceViewGTK::Map;
use SourceViewGTK::MarkAttributes;
use SourceViewGTK::PrintCompositor;
use SourceViewGTK::View;
use SourceViewGTK::StyleSchemeChooserButton;

use SourceViewTests;

constant MARK_TYPE_1            = 'one';
constant MARK_TYPE_2            = 'two';
constant LANG_STRING            = 'gtk-source-lang:';
constant LINE_NUMBERS_FONT_NAME	= 'Sans 8';
constant HEADER_FONT_NAME	      = 'Sans 11';
constant FOOTER_FONT_NAME	      = 'Sans 11';
constant BODY_FONT_NAME		      = 'Monospace 9';

my %globals;

sub remove_all_marks {
  my ($start, $end) = %globals<buffer>.get_bounds;
  %globals<buffer>.remove_source_marks($start, $end, Str);
}

sub get_language_for_file ($buffer, $filename) {
  my $start = $buffer.get_start_iter;
  my $end = $buffer.get_iter_at_offset(1024);
  my $text = $buffer.get_slice($start, $end, True);
  my $result_uncertain = 0;

  my $content_type = GTK::Compat::ContentType.guess(
    $filename,
    $text,
    $text.chars,
    $result_uncertain
  );
  $content_type = Str if $result_uncertain;

  my $manager = SourceViewGTK::LanguageManager.default;
  my $language = $manager.guess_language($filename, $content_type);

  GTK::Compat::Log.message(qq:to/M/.chomp);
Detected '{ $content_type || '(null)' }' mime type for file {
$filename }, chose language { $language.get_id || '(none)' }
M

  $language;
}

sub get_language_by_id ($id) {
  SourceViewGTK::LanguageManager.default.get_language($id);
}

# $file ~~ GTK::Compat::File
sub get_language ($buffer, $file) {
  my $end = (my $start = $buffer.get_start_iter);
  $end.forward_line;

  my ($text, $language) = ( $start.get_text($end) );
  $language = $/[0] if $text ~~ /{ LANG_STRING } \s* (.+?) <[\t\v]>/;

  $language = get_language_for_file($buffer, $file.get_path)
    without $language;

  $language // GtkSourceLanguage;
}

sub print_language_style_ids ($language) {
  my @styles = $language.get_style_ids;
  my $lang_name = $language.get_name;

  if @styles {
    say "Styles in language '{ $lang_name }':";
    for @styles {
      say "- { $_ } (name: { $language.get_style_name($_) })" if .defined;
    }
  } else {
    say "No styles in language '{ $lang_name }'";
  }
  put "\n";
}

sub load_cb ($, $result, $) {
  CATCH { default { .message.say } }

  %globals<loader>.load_finish($result);
  with $ERROR {
    GTK::Compat::Log.warning(
      "Error while loading the file: { $ERROR.message }"
    );
    clear_error;
    return;
  }

  %globals<buffer>.place_cursor(%globals<buffer>.get_start_iter);
  %globals<view>.grab_focus;

  my $location = %globals<loader>.get_location;
  my $language = get_language(%globals<buffer>, $location);
  %globals<buffer>.language = $language;

  with $language {
    print_language_style_ids($language);
  } else {
    say "No language found for file '{ $location.get_path }";
  }

  # cw: If uncommented, program hangs.
  #LEAVE %globals<loader>:delete;
}

sub open_file ($filename is copy) {
  $filename = "t/{ $filename }" unless $filename.IO.e;

  my $location = GTK::Compat::File.new_for_path($filename);
  %globals<file> = SourceViewGTK::File.new;
  %globals<file>.location = $location;

  %globals<loader> = SourceViewGTK::FileLoader.new(|%globals<buffer file>);
  remove_all_marks;

  %globals<loader>.load_async(G_PRIORITY_DEFAULT, &load_cb);
}

sub update_indent_width {
  %globals<view>.indent_width = %globals<indent_width_checkbutton>.active ??
    %globals<indent_width_spinbutton>.get_value_as_int !! -1;
}

sub smart_home_end_changed_cb {
  %globals<view>.smart_home_end = do given %globals<smart_home_end>.active {
    when 0  { GTK_SOURCE_SMART_HOME_END_DISABLED }
    when 1  { GTK_SOURCE_SMART_HOME_END_BEFORE   }
    when 2  { GTK_SOURCE_SMART_HOME_END_AFTER    }
    when 3  { GTK_SOURCE_SMART_HOME_END_ALWAYS   }
    default { GTK_SOURCE_SMART_HOME_END_DISABLED }
  };
}

sub move_string_iter(:$forward = True) {
  my $method =
    "iter_{ $forward ?? 'forward' !! 'backward' }_to_context_class_toggle";

  my $insert = %globals<buffer>.get_insert;
  my $iter = %globals<buffer>.get_iter_at_mark($insert);

  if %globals<buffer>."$method"($iter, 'string') {
    %globals<buffer>.place_cursor($iter);
    %globals<view>.scroll_mark_onscreen($insert);
  }
  %globals<view>.grab_focus;
}

sub open_button_clicked_cb {
  state $last_dir;

  my $main_window = %globals<view>.get_toplevel;
  my $chooser = GTK::Dialog::FileChooser.new(\
    'Open file...',
    cast(GtkWindow, $main_window.Widget),
    GTK_FILE_CHOOSER_ACTION_OPEN
  );

  without $last_dir {
    $last_dir = '/gtksourceview';
    $last_dir = "t/{ $last_dir }" unless $last_dir.IO.d;
  }
  $chooser.current_folder = $last_dir if $last_dir.IO.is-absolute;

  my $response = $chooser.run;
  if $response == GTK_RESPONSE_OK {
    my $filename = $chooser.filename;
    $last_dir = $chooser.current_folder if $filename.defined;
    open_file($filename);
  }
}

# Can be optimized OUT! - using NON_BLOCKING_PAGINATION
sub begin_print ($context) {
  Nil while %globals<compositor>.paginate($context);
  %globals<print_operation>.n_pages = %globals<compositor>.get_n_pages;
}

# Using - ENABLE_CUSTOM_OVERLAY
sub draw_page ($ctxt) {
  my $context = GTK::PrintContext.new($ctxt);
  my $cr = Cairo::Context.new( $context.get_cairo_context );
  $cr.save;

  my $layout = GTK::PrintContext.create_pango_layout($ctxt);
  $layout.text = 'Draft';

  my $desc = Pango::FontDescription.new_from_string('Sans Bold 120');
  $layout.description = $desc;

  my ($, $lr) = $layout.get_extents;
  $cr.move_to(
    $context.width - $lr.width / PANGO_SCALE / 2,
    $context.height - $lr.height / PANGO_SCALE / 2
  );
  Pango::Cairo.layout_path($cr, $layout);

  $cr.rgba(0.85, 0.85, 0.85, 0.80);
  $cr.line_width(0.5);
  $cr.stroke(:preserve);

  $cr.rgba(0.8, 0.8, 0.8, 0.6);
  $cr.fill;
  $cr.restore;
}

# NOT using SETUP_FROM_VIEW
sub print_button_clicked_cb {
  my $basename;

  with %globals<file> {
    my $location = %globals<file>.location;
    $basename = $location.basename with $location;
  }

  %globals<compositor> = SourceViewGTK::PrintCompositor.new(%globals<buffer>);
  %globals<compositor>.tab_with = %globals<view>.tab_width;
  %globals<compositor>.wrap_mode = %globals<view>.wrap_mode;
  %globals<compositor>.print_line_numbers = True;
  %globals<compositor>.body_font_name = BODY_FONT_NAME;
  %globals<compositor>.footer_font_name = FOOTER_FONT_NAME;
  %globals<compositor>.header_font_name = HEADER_FONT_NAME;
  %globals<compositor>.line_number_font_name = LINE_NUMBERS_FONT_NAME;
  %globals<compositor>.set_header_format(
    True, 'Printed on %A', 'test-widget', '%F'
  );
  %globals<compositor>.set_footer_format(True, '%T', $basename, 'Page %N/%Q');
  %globals<compositor>.print_header = True;
  %globals<compositor>.print_footer = True;

  %globals<print_operation> = GTK::PrintOperation.new;
  %globals<print_operation>.name = $basename;
  %globals<print_operation>.show_progress = True;

  GTK::Compat::Signal.connect(%globals<print_operation>, .key, .value ) for (
    'paginate'   => -> *@a { begin_print( @a[1] )       },
    'draw-page'  => -> *@a { draw_page(   @a[1] )       },
    'end-print'  => -> *@a { %globals<compositor> = Nil }
  );

  %globals<print_operation>.run( GTK_PRINT_OPERATION_ACTION_PRINT_DIALOG );
}

sub update_cursor_position_info {
  my $iter = %globals<buffer>.get_iter_at_mark(%globals<buffer>.get_insert);
  my $o = $iter.offset;
  my $l = $iter.line + 1;
  my $c = %globals<view>.get_visual_column($iter) + 1;
  my @cls = %globals<buffer>.get_context_classes_at_iter($iter);

  %globals<cursor_position_info>.label = qq:to/M/.chomp;
    offset: { $o }, line:{ $l }, column: { $c }, classes: {
      @cls.grep( *.defined ).join(', ') }
    M
}

sub line_mark_activated_cb ($i, $event) {
  my $button_event = cast(GdkEventButton, $event);
  my $iter = GTK::TextIter.new($i);
  my $mark_type = $button_event.button ?? MARK_TYPE_1 !! MARK_TYPE_2;
  my $mark_list = %globals<buffer>.get_source_marks_at_line(
    $iter.get_line, $mark_type
  );

  with $mark_list {
    %globals<buffer>.delete_mark($mark_list[0]);
  } else {
    # No category so use Str as NULL
    %globals<buffer>.create_source_mark(Str, $mark_type, $iter);
  }
  #g_slist_free (mark_list);
}

sub bracket_matched_cb ($it, $s) {
  my $state = GtkSourceBracketMatchType($s);
  my $iter = GTK::TextIter.new($it);

  say "Bracket match state: '{ $state }'";
  if $state == GTK_SOURCE_BRACKET_MATCH_FOUND {
    my ($ch, $r, $c) = ($iter.char, $iter.line + 1, $iter.line_offset + 1);
    say qq:to/MATCH/.chomp;
      Matched bracket: '{ $ch }' at row: { $r }, col: { $c }
      MATCH
  }
}

sub mark_tooltip_func ($m) {
  my $mark = GTK::TextMark.new($m);
  my $buffer = $mark.buffer;
  my $iter = $buffer.get_iter_at_mark($mark);
  my ($line, $col) = ($iter.line + 1, $iter.get_line_offset);

  $mark.category eq MARK_TYPE_1 ??
    "Line: { $line }, Column: { $col }"
    !!
    "<b>Line</b>: { $line }\n<i>Column</i>: { $col }";
}

sub add_source_mark_attributes {
  my ($a1, $a2) = SourceViewGTK::MarkAttributes.new xx 2;
  my ($c1, $c2) = GTK::Compat::RGBA.new xx 2;

  $a1.background = do { $c1.parse('lightgreen'); $c1 };
  $a1.icon_name = 'list-add';
  $a1.query-tooltip-markup.tap(-> *@a { mark_tooltip_func(@a[1]) });

  $a2.background = do { $c2.parse('pink'); $c2 };
  $a2.icon_name = 'list-remove';
  $a2.query-tooltip-markup.tap(-> *@a { mark_tooltip_func(@a[1]) });

  %globals<view>.set_mark_attributes(MARK_TYPE_1, $a1, 1);
  %globals<view>.set_mark_attributes(MARK_TYPE_2, $a2, 2);
}

sub MAIN {
  my $ui-data = process_ui('test-widget.ui');

  my $a  = GTK::Application.new( title => 'org.genex.sourceview.test_widget' );

  # Seems to prevent this error:
  #    Type check failed for return value; expected Str but got Whatever (*)
  my $dv;
  $dv = .new for SourceViewGTK::Map,
                 SourceViewGTK::StyleSchemeChooserButton,
                 SourceViewGTK::View;

  # Register SourceViewGTK widgets.
  GTK::Builder.register( SourceViewGTK::Builder::Registry );

  my $b = GTK::Builder.new_from_string($ui-data);

  die 'GTK::Builder error' unless $b.keys;
  %globals{$_}      := $b{$_} for $b.keys;
  %globals<buffer>   = $b<view>.source_buffer;

  GTK::Compat::Binding.bind(%globals<view>, $_[0], $_[1], 'active')
    for (
      [ 'auto-indent',                   $b<auto_indent>            ],
      [ 'highlight-current-line',        $b<highlight_current_line> ],
      [ 'insert-spaces-instead-of-tabs', $b<indent_spaces>          ],
      [ 'show-line-marks',               $b<show_line_marks>        ],
      [ 'show-line-numbers',             $b<show_line_numbers>      ],
      [ 'show-right-margin',             $b<show_right_margin>      ],
    );

  GTK::Compat::Binding.bind(%globals<buffer>, $_[0], $_[1], 'active')
    for (
      [ 'highlight-syntax',            $b<highlight_syntax>           ],
      [ 'highlight-matching-brackets', $b<highlight_matching_bracket> ],
    );

  $b<open_button>    .clicked.tap(-> *@a { open_button_clicked_cb       });
  $b<print_button>   .clicked.tap(-> *@a { print_button_clicked_cb      });
  $b<backward_string>.clicked.tap(-> *@a { move_string_iter(:!forward)  });
  $b<forward_string> .clicked.tap(-> *@a { move_string_iter(:forward)   });
  $b<smart_home_end> .changed.tap(-> *@a { smart_home_end_changed_cb    });

  $b<right_margin_position>.changed.tap(-> *@a {
    $b<view>.right-margin-position =
      $b<right_margin_position>.get_value_as_int;
  });

  $b<wrap_lines>.toggled.tap(-> *@a {
    $b<view>.wrap-mode = $b<wrap_lines>.active ??
      GTK_WRAP_WORD !! GTK_WRAP_NONE;
  });

  $b<tab_width>.changed.tap(-> *@a {
    $b<view>.tab-width = $b<tab_width>.get_value_as_int;
  });

  $b<show_top_border_window_checkbutton>.toggled.tap(-> *@a {
    $b<view>.set_border_window_size(
      GTK_TEXT_WINDOW_TOP,
      $b<show_top_border_window_checkbutton>.active ?? 20 !! 0;
    );
  });

  $b<indent_width_checkbutton>.toggled.tap(-> *@a {
    update_indent_width
  });
  $b<indent_width_spinbutton> .value-changed.tap(-> *@a {
    update_indent_width
  });

  %globals<buffer>.mark-set.tap(-> *@a {
    update_cursor_position_info
      if @a[2].p == %globals<buffer>.get_insert.TextMark.p
  });
  %globals<buffer>.bracket-matched.tap(-> *@a {
    bracket_matched_cb( |@a[1, 2] )
  });

  add_source_mark_attributes;

  $b<view>.line-mark-activated.tap(-> *@a {
    line_mark_activated_cb( |@a[1, 2] );
  });

  GTK::Compat::Binding.bind(
    $b<chooser_button>, 'style-scheme',
    %globals<buffer>,   'style-scheme',
    G_BINDING_SYNC_CREATE
  );
  GTK::Compat::Binding.bind(
    $b<show_map_checkbutton>, 'active',
    $b<map>,                  'visible',
    G_BINDING_SYNC_CREATE
  );
  GTK::Compat::Binding.bind(
    $b<smart_backspace_checkbutton>, 'active',
    %globals<view>,                  'smart-backspace',
    G_BINDING_SYNC_CREATE
  );

  $b<background_pattern>.changed.tap(-> *@a {
    $b<view>.background-pattern =
      $b<background_pattern>.active_text eq 'Grid' ??
        GTK_SOURCE_BACKGROUND_PATTERN_TYPE_GRID
        !!
        GTK_SOURCE_BACKGROUND_PATTERN_TYPE_NONE
  });

  %globals<space_drawer> = $b<view>.space-drawer;
  GTK::Compat::Binding.bind(
    $b<draw_spaces_checkbutton>,
    'active',
    %globals<space_drawer>,
    'enable-matrix'
  );

  open_file('gtksourceview/gtksourcebuffer.c');

  $a.activate.tap({
    $a.wait-for-init;
    $a.window.set_default_size(900, 600);
    $a.window.destroy-signal.tap({ $a.exit });
    $a.window.add($b<TestWidget>);
    $a.window.show;
  });

  $a.run;
}
