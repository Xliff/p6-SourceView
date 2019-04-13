use v6.c;

use GTK::Compat::ContentType;

use SourceViewGTK::View;

constant MARK_TYPE_1 = 'one';
constant MARK_TYPE_2 = 'two';

constant LANG_STRING = 'gtk-source-lang:';

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
sub backward_string_clicked_cb {

}
