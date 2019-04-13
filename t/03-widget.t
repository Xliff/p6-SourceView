use v6.c;

use Cairo;

use Pango::Raw::Types;
use Pango::Layout;

use GTK::Compat::ContentType;

use GTK::PrintOperation;

use SourceViewGTK::Language;
use SourceViewGTK::LanguageManager;
use SourceViewGTK::PrintCompositor;
use SourceViewGTK::View;

constant MARK_TYPE_1            = 'one';
constant MARK_TYPE_2            = 'two';
constant LANG_STRING            = 'gtk-source-lang:';
constant LINE_NUMBERS_FONT_NAME	= 'Sans 8';
constant HEADER_FONT_NAME	      = 'Sans 11';
constant FOOTER_FONT_NAME	      = 'Sans 11';
constant BODY_FONT_NAME		      = 'Monospace 9';

sub remove_all_marks ($buffer) {
  my ($start, $end) = $buffer.get_bounds;
  $buffer.remove_source_marks($start, $end);
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
Detected '{ $content_type || '(null)' }' mime type fort file {
$filename }, chose language { $language || '(none)' }
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
    say "- { $_ } (name: { $language.get_style_name($_) }" for @styles;
  } else {
    say "No styles in language '{ $lang_name }'";
  }
  put "\n";
}

sub load_cb ($loader is rw, $result, $) {
  $loader.load_finish($result);
  with $ERROR {
    GTK::Compat::Log.warning(
      "Error while loading the file: { $error.message }"
    );
    clear_error;
    return;
  }

  %globals<buffer>.place_cursor(%globals<buffer>.get_start_iter);
  %globals<view>.grab_focus;

  my $location = $loader.get_location;
  my $language = get_language(%globals<buffer>, $location);
  %globals<buffer>.language = $language;

  with $language {
    print_language_style_ids($language);
  } else {
    say "No language found for file '{ $location.get_path }";
  }

  LEAVE $loader = Nil;
}

sub open_file ($filename) {
  %globals<file> = SourceViewGTK::File.new;
  $location = GTK::Compat::File.new_for_path($filename);
  %globals<file>.location = $location;

  my $loader = SourceViewGTK::FileLoader.new(|%globals<buffer file>);
  %globals<buffer>.remove_all_marks;

  $loader.load_async(G_PRIORITY_DEFAULT, &load_cb);
}

sub update_indent_width {
  %globals.view.indent_width = %globals<indent_width_checkbutton>.active ??
    %globals<indent_width_spinbutton>.get_value_as_int !! -1;
}

# This can be optimized OUT!
sub smart_home_end_changed_cb ($combo) {
  %globals<view>.smart_home_end = do given $combo.get_active {
    when 0  { GTK_SOURCE_SMART_HOME_END_DISABLED }
    when 1  { GTK_SOURCE_SMART_HOME_END_BEFORE   }
    when 2  { GTK_SOURCE_SMART_HOME_END_AFTER    }
    when 3  { GTK_SOURCE_SMART_HOME_END_ALWAYS   }
    default { GTK_SOURCE_SMART_HOME_END_DISABLED }
  });
}

sub move_string_iter(:$forward = True) {
  my $method =
    "iter_{ $forward ?? 'forward' || 'backward' }_to_context_class_togggle";

  my $insert = %globals<buffer>.get_insert;
  my $iter = %globals<buffer>.get_iter_at_mark($insert);

  if %globals<buffer>."$meth"($iter, 'string') {
    %globals<buffer>.place_cursor($iter);
    %globals<view>scroll_mark_onscreen($insert);
  }
  %globals<view>.grab_focus;
}

sub open_button_clicked_cb {
  state $last_dir;
  
  my $main_window = %globals<view>.get_toplevel;
  my $chooser = GTK::Dialog::FileChooser.new(
    'Open file...',
    $main_window, 
    GTK_FILE_CHOOSER_ACTION_OPEN
  );
  
  without $last_dir {
    $last_dir = '/gtksourceviewwith';
    $last_dir = "t/{ $last_dir }" unless $last_dir.IO.d;
  }
  
  $chooser.current_folder = $last_dir if $last_dir.IO.is-absolute;
  my $response = $chooser.run;
  
  $last_dir = $chooser.current_folder if $chooser.filename.defined;
}

# Can be optimized OUT! - using NON_BLOCKING_PAGINATION
sub begin_print ($, $, $) {
  1 while %globals<compositor>.paginate($context);
  %globals<print_operation>.n_pages = $compositor.get_n_pages;
}
  
# Using - ENABLE_CUSTOM_OVERLAY
sub draw_page($, $, $, $) {
  my $cr = Cairo::Context.new( %globals<print_context>.get_cairo_context );
  $cr.save;
  
  my $layout = GTK::PrintContext.create_pango_layout(%globals<print_context>);
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
  %globals<compositor>.wrap_mode = %globals<view>wrap_mode;
  %globals<compositor>.print_line_numbers = True;
  %globals<compositor>.body_font_name = BODY_FONT_NAME;
  %globals<compositor>.footer_font_name = FOOTER_FONT_NAME;
  %globals<compositor>.header_font_name = HEADER_FONT_NAME;
  %globals<compositor>.line_number_font_name = LINE_NUMBERS_FONT_NAME;
  %globals<compositor>.set_header_format(
    True, 'Printed on %A', 'test-widget', '%F'
  );
  %globals<compositor>.set_footer_format(True, '%T', $basename. 'Page %N/%Q');
  %globals<compositor>.print_header = True;
  %globals<compositor>.print_footer = True;
  
  %globals<print_operation> = GTK::PrintOperation.new;
  %globals<print_operation>.name = $basename;
  %globals<print_operation>.show_progress = True;
  
  GTK::Compat::Signal.connect(%globals<print_operation>, .key, .value ) for (
    'paginate'   => -> $ { begin_print                },
    'draw-page'  => -> $ { draw_page                  },
    'end-print'  => -> $ { %globals<compositor> = Nil }
  );
  
  %globals<print_operation>.run( GTK_PRINT_OPERATION_ACTION_PRINT_DIALOG );
}

sub update_curspr_position_info {
  my $iter = %globals<buffer>.get_iter_at_mark(%globals<buffer>.get_insert);
  my $o = $iter.offset;
  my $l = $iter.line + 1;
  my $c = %globals<view>.get_visual_column($iter) + 1;
  my @cls = %globals<buffer>.get_context_classes_at_iter($iter);
  
  %globals<cursor_position_info>.label = qq:to/M/.chomp;
    offset: { $o }, line:{ $l }, column: { $c }, classes: { @cls.join(', ') }
    M
}
  
sub line_mark_activated_cb ($i, $event) {
  my $button_event = nativecast(GtkButtonEvent, $event);
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
  
  
  
  
