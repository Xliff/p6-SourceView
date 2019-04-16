use v6.c;

use Test;
use lib 't';

use GTK::Raw::Types;
use SourceViewGTK::Raw::Types;

use GTK::Raw::Utils;

use GTK::TextBuffer;

use TestIter;

sub check_full_word_boundaries($text, $io, $ro, :$forward = True) {
  my $buffer = GTK::TextBuffer.new;
  $buffer.text = $text;

  my $iter = $buffer.get-iter-at-offset($io);
  if $forward {
    _gtk_source_iter_forward_full_word_end($iter.TextIter);
  } else {
    _gtk_source_iter_backward_full_word_start($iter.TextIter);
  }

  ok $ro == $iter.offset,
    "'{ $text.subst("\n", '\n', :g) }' passed with args ({ $io }, { $ro })";
}

sub test_forward_full_word_end {
  check_full_word_boundaries('  ---- abcd ',          2,  6);
  check_full_word_boundaries('  ---- abcd ',          0,  6);
  check_full_word_boundaries('  ---- abcd ',          4,  6);
  check_full_word_boundaries('  ---- abcd ',          8, 11);
  check_full_word_boundaries("  ---- abcd \n  ----", 11, 11);
}

sub test_backward_full_word_start {
  check_full_word_boundaries( '---- abcd  ',        9,  5, :!forward);
  check_full_word_boundaries( '---- abcd  ',       11,  5, :!forward);
  check_full_word_boundaries( '---- abcd  ',        7,  5, :!forward);
  check_full_word_boundaries( '---- abcd  ',        3,  0, :!forward);
  check_full_word_boundaries(' ---- abcd  ',        1,  1, :!forward);
  check_full_word_boundaries("abcd \n ---- abcd  ", 7,  0, :!forward);
}

sub test_starts_full_word {
  my $iter;
  my $buffer = GTK::TextBuffer.new;
  $buffer.text = 'foo--- ---bar';

  diag "Given '{ $buffer.text }'...";
  for ( (0, 1), (1, 0), (7, 1), (10, 0) ) {
    $iter = $buffer.get_iter_at_offset(0);
    if $_[1] {
      ok _gtk_source_iter_starts_full_word($iter.TextIter),
        "Position { $_[0] } starts a full word";
    } else {
      nok _gtk_source_iter_starts_full_word($iter.TextIter),
        "Position { $_[0] } does not start a full word";
    }
  }

  $buffer.text = ' ab ';
  diag "Given '{ $buffer.text }'...";
  for (0, 4) {
    $iter = $buffer.get_iter_at_offset($_);
    nok _gtk_source_iter_starts_full_word($iter.TextIter),
      "Position { $_ } does not start a full word";
  }
}

sub test_ends_full_word {
  my $iter;
  my $buffer = GTK::TextBuffer.new;
  $buffer.text = 'foo--- ---bar ';

  diag "Given '{ $buffer.text }'...";
  for ( (14, 0), (3, 1), (12, 0), (6, 1), (3, 0), (0, 0) ) {
    $iter = $buffer.get_iter_at_offset(0);
    if $_[1] {
      ok _gtk_source_iter_ends_full_word($iter.TextIter),
        "Position { $_[0] } starts a full word";
    } else {
      nok _gtk_source_iter_ends_full_word($iter.TextIter),
        "Position { $_[0] } does not start a full word";
    }
  }
}

sub check_extra_natural_word_boundaries ($text, $io, $ro, :$forward = True) {
  my $buffer = GTK::TextBuffer.new;
  $buffer.text = $text;

  my $iter = $buffer.get_iter_at_offset($io);
  if $forward {
    _gtk_source_iter_forward_extra_natural_word_end($iter.TextIter);
  } else {
    _gtk_source_iter_backward_extra_natural_word_start($iter.TextIter);
  }

  ok $ro == $iter.offset,
    "'{ $text.subst("\n", '\n', :g) }' passed with args ({ $io }, { $ro })";
}

sub test_forward_extra_natural_word_end {
  my $str = 'hello_world ---- blah';

  check_extra_natural_word_boundaries($str, $_, 11) for 0, 1, 5, 11, 21;

  check_extra_natural_word_boundaries('ab ',     2, 2);
  check_extra_natural_word_boundaries('a_ ',     2, 2);
  check_extra_natural_word_boundaries("ab \ncd", 2, 6);
  check_extra_natural_word_boundaries("a_ \n_d", 2, 6);

  check_extra_natural_word_boundaries('__ ab',     0, 2);
  check_extra_natural_word_boundaries('--__--',    0, 4);
  check_extra_natural_word_boundaries('--__-- ab', 0, 4);
}

sub test_backward_extra_natural_word_start {
  my $str = 'hello_world ---- blah';

  check_extra_natural_word_boundaries($str, $_, 17, :!forward) for 21, 20;
  check_extra_natural_word_boundaries($str, $_,  0, :!forward)
    for 17, 11, 6, 5, 0;

  check_extra_natural_word_boundaries(' cd',       1, 1, :!forward);
  check_extra_natural_word_boundaries(' _d',       1, 1, :!forward);
  check_extra_natural_word_boundaries("ab\n cd",   4, 0, :!forward);
  check_extra_natural_word_boundaries("_b\n c_",   4, 0, :!forward);
  check_extra_natural_word_boundaries('ab --__--', 9, 5, :!forward);
}

sub check_starts_extra_natural_word ($text, $o, :$s = True) {
  my $buffer = GTK::TextBuffer.new;
  $buffer.text = $text;

  my $iter = $buffer.get_iter_at_offset($o);
  ok $s == so _gtk_source_iter_starts_extra_natural_word($iter.TextIter, 1),
    "'{ $text }' { $s ?? 'starts' !! "doesn't start" } a natural word at {$o }";
}

sub test_starts_extra_natural_word {
  check_starts_extra_natural_word('ab'   ,    2, :!s);
  check_starts_extra_natural_word('hello',    0);
  check_starts_extra_natural_word('__',       0);
  check_starts_extra_natural_word(' hello',   0, :!s);
  check_starts_extra_natural_word(' hello',   1);
  check_starts_extra_natural_word('_hello',   1, :!s);
  check_starts_extra_natural_word('()',       1, :!s);
  check_starts_extra_natural_word('__',       1, :!s);
  check_starts_extra_natural_word(' __',      1);
  check_starts_extra_natural_word(' __hello', 1);
  check_starts_extra_natural_word('hello_',   5, :!s);
}

sub check_ends_extra_natural_word($text, $o, :$e = True) {
  my $buffer = GTK::TextBuffer.new;
  $buffer.text = $text;

  my $iter = $buffer.get_iter_at_offset($o);
  ok $e == so _gtk_source_iter_ends_extra_natural_word($iter.TextIter, 1),
    "'{ $text }' { $e ?? 'ends' !! "doesn't end" } a natural word at { $o }";
}

sub test_ends_extra_natural_word {
  check_ends_extra_natural_word('ab',    0, :!e);
	check_ends_extra_natural_word('ab',    2);
	check_ends_extra_natural_word('__',    2);
	check_ends_extra_natural_word('ab ',   3, :!e);
	check_ends_extra_natural_word('ab ',   2);
	check_ends_extra_natural_word('ab_',   2, :!e);
	check_ends_extra_natural_word('()',    1, :!e);
	check_ends_extra_natural_word('__ ',   1, :!e);
	check_ends_extra_natural_word('__ab ', 2, :!e);
	check_ends_extra_natural_word('__ ',   2);
}

sub check_word_boundaries($text, $o, $sw, $ew, $iw) {
  my $buffer = GTK::TextBuffer.new;
  $buffer.text = $text;

  my $iter = $buffer.get_iter_at_offset($o);
  ok $sw == so _gtk_source_iter_starts_word($iter.TextIter),
    "'{ $text }' { $sw ?? 'starts' !! "doesn't start" } a word at { $o }";
  ok $ew == so _gtk_source_iter_ends_word($iter.TextIter),
    "'{ $text }' { $ew ?? 'ends' !! "doesn't end" } a word at { $o }";
  ok $iw == so _gtk_source_iter_inside_word($iter.TextIter),
    "'{ $text }' { $ew ?? 'is inside' !! "isn't inside" } a word at { $o }";
}

sub test_word_boundaries {
  check_word_boundaries ('ab()cd', 0, True,  False,  True);
	check_word_boundaries ('ab()cd', 1, False, False,  True);
	check_word_boundaries ('ab()cd', 2, True,  True,   True);
	check_word_boundaries ('ab()cd', 3, False, False,  True);
	check_word_boundaries ('ab()cd', 4, True,  True,   True);
	check_word_boundaries ('ab()cd', 5, False, False,  True);
	check_word_boundaries ('ab()cd', 6, False, True,  False);

	check_word_boundaries (' ab',    0, False, False, False);
	check_word_boundaries ('ab ',    3, False, False, False);

	check_word_boundaries (' () ',   1, True,  False,  True);
	check_word_boundaries (' () ',   3, False, True,  False);
}

sub check_word_boundaries_movement ($text, $io, $ro, $ret, :$forward = True) {
  my $buffer = GTK::TextBuffer.new;
  $buffer.text = $text;

  my $iter = $buffer.get_iter_at_offset($io);
  if $forward {
    ok $ret == _gtk_source_iter_forward_visible_word_end($iter.TextIter),
      "Can move iter forward from position { $io } to word end in '{ $text }'";
  } else {
    ok $ret == _gtk_source_iter_backward_visible_word_start($iter),
      "Can move iter backward from position { $io } to word start in '{ $text }'";
  }
  ok $ro == $iter.offset, "Iter is at proper offset of { $ro }";
}

sub test_forward_word_end {
  check_word_boundaries_movement('---- aaaa', 0, 4,  True);
  check_word_boundaries_movement('---- aaaa', 1, 4,  True);
  check_word_boundaries_movement('---- aaaa', 4, 9, False);
  check_word_boundaries_movement('---- aaaa', 5, 9, False);
  check_word_boundaries_movement('---- aaaa', 6, 9, False);
  check_word_boundaries_movement('aaaa ----', 0, 4,  True);
  check_word_boundaries_movement('aaaa ----', 1, 4,  True);
  check_word_boundaries_movement('aaaa ----', 4, 9, False);
  check_word_boundaries_movement('aaaa ----', 5, 9, False);
  check_word_boundaries_movement('aaaa ----', 6, 9, False);

  check_word_boundaries_movement('abcd',       2, 4, False);
  check_word_boundaries_movement('abcd ',      2, 4, True);
  check_word_boundaries_movement(' abcd()',    0, 5, True);
  check_word_boundaries_movement('abcd()efgh', 4, 6, True);

  check_word_boundaries_movement('ab ',     2, 2, False);
  check_word_boundaries_movement("ab \n",   2, 2, False);
  check_word_boundaries_movement("ab \ncd", 2, 6, False);

  check_word_boundaries_movement('--__--', 0, 2, True);
  check_word_boundaries_movement('--__--', 2, 4, True);
  check_word_boundaries_movement('--__--', 4, 6, False);
}

sub test_backward_word_start {
  check_word_boundaries_movement('aaaa ----', 9, 5, True, :!forward);
  check_word_boundaries_movement('aaaa ----', 8, 5, True, :!forward);
  check_word_boundaries_movement('aaaa ----', 5, 0, True, :!forward);
  check_word_boundaries_movement('aaaa ----', 4, 0, True, :!forward);
  check_word_boundaries_movement('aaaa ----', 3, 0, True, :!forward);
  check_word_boundaries_movement('---- aaaa', 9, 5, True, :!forward);
  check_word_boundaries_movement('---- aaaa', 8, 5, True, :!forward);
  check_word_boundaries_movement('---- aaaa', 5, 0, True, :!forward);
  check_word_boundaries_movement('---- aaaa', 4, 0, True, :!forward);
  check_word_boundaries_movement('---- aaaa', 3, 0, True, :!forward);

  check_word_boundaries_movement('abcd',    2, 0,  True, :!forward);
  check_word_boundaries_movement('()abcd ', 7, 2,  True, :!forward);
  check_word_boundaries_movement('abcd()',  6, 4,  True, :!forward);
  check_word_boundaries_movement('abcd()',  0, 0, False, :!forward);

  check_word_boundaries_movement(" cd",     1, 1, False, :!forward);
  check_word_boundaries_movement("\n cd",   2, 2, False, :!forward);
  check_word_boundaries_movement("ab\n cd", 4, 0,  True, :!forward);

  check_word_boundaries_movement('--__--', 6, 4, True, :!forward);
  check_word_boundaries_movement('--__--', 4, 2, True, :!forward);
  check_word_boundaries_movement('--__--', 2, 0, True, :!forward);
}

sub check_get_leading_spaces_end_boundary($text, $io, $eeo) {
  my $buffer = GTK::TextBuffer.new;
  $buffer.text = $text;

  my $iter = $buffer.get_iter_at_offset($io);
  my $le = GtkTextIter.new;
  _gtk_source_iter_get_leading_spaces_end_boundary($iter.TextIter, $le);

  my $le_iter = GTK::TextIter.new($le);
  ok $le.offset == $eeo,
    "Leading end offset matches expectation ({ $eeo }) using '{
      $text.subst("\n", '\n').subst("\t", '\t') }'";
}

sub test_get_leading_spaces_end_boundary {
  check_get_leading_spaces_end_boundary("  abc\n", 0, 2);
  check_get_leading_spaces_end_boundary("  \n",    0, 2);
  check_get_leading_spaces_end_boundary("\t\n",    0, 1);
  check_get_leading_spaces_end_boundary("\t\r\n",  0, 1);
  check_get_leading_spaces_end_boundary("\t\r",    0, 1);
  check_get_leading_spaces_end_boundary(" \t \n",  0, 3);

  # No-Break Space U+00A0
  check_get_leading_spaces_end_boundary("\o302\o240abc\n",   0, 1);
  check_get_leading_spaces_end_boundary(" \t\o302\o240\t\n", 0, 4);

  # Narrow No-Break Space U+202F
  check_get_leading_spaces_end_boundary("\o342\o200\o257abc\n", 0, 1);
  check_get_leading_spaces_end_boundary("\t \o342\o200\o257\n", 0, 3);
}

sub check_get_trailing_spaces_start_boundary ($text, $io, $eto) {
  my $buffer = GTK::TextBuffer.new;
  $buffer.text = $text;

  my $iter = $buffer.get_iter_at_offset($io);
  my $ts = GtkTextIter.new;
  _gtk_source_iter_get_trailing_spaces_start_boundary($iter, $ts);

  my $ts_iter = GTK::TextIter.new($ts);
  ok $ts_iter.ofset == $eto,
    "Trailing start offset matches expectation ({ $eto }) using '{
      $text.subst("\n", '\n').subst("\t", '\t') }'";
}

sub test_get_trailing_spaces_start_boundary {
  check_get_trailing_spaces_start_boundary("",          0, 0);
	check_get_trailing_spaces_start_boundary("a",         0, 1);
	check_get_trailing_spaces_start_boundary("a ",        0, 1);
	check_get_trailing_spaces_start_boundary("a \n",      0, 1);
	check_get_trailing_spaces_start_boundary("a \r\n",    0, 1);
	check_get_trailing_spaces_start_boundary("a \r",      0, 1);
	check_get_trailing_spaces_start_boundary("a\t\n",     0, 1);
	check_get_trailing_spaces_start_boundary(" \t\t  \n", 0, 0);
	check_get_trailing_spaces_start_boundary("\n",        1, 1);

	# No-Break Space U+00A0
	check_get_trailing_spaces_start_boundary("a\o302\o240",                 0, 1);
	check_get_trailing_spaces_start_boundary("a \t\o302\o240 \t\o302\o240", 0, 1);

	# Narrow No-Break Space U+202F
	check_get_trailing_spaces_start_boundary (
    "a\o342\o200\o257", 0, 1
  );
	check_get_trailing_spaces_start_boundary (
    " \ta;\t  \o342\o200\o257 \t\o302\o240\n", 0, 4
  );
}

sub MAIN {
  my $p = gtk_source_tag_new();
  say $p;

  subtest '/Iter/full-word' => sub {
    test_forward_full_word_end;
    test_backward_full_word_start;
    test_starts_full_word;
    test_ends_full_word;
  };

  subtest '/Iter/extra-natural-word' => sub {
    test_forward_extra_natural_word_end;
    test_backward_extra_natural_word_start;
    test_starts_extra_natural_word;
    test_ends_extra_natural_word;
  }

  subtest '/Iter/custom-word' => sub {
    test_word_boundaries;
    test_forward_word_end;
    test_backward_word_start;
  };

  subtest '/Iter/leading-trailing-spaces' => sub {
    test_get_leading_spaces_end_boundary;
    test_get_trailing_spaces_start_boundary;
  };
}
