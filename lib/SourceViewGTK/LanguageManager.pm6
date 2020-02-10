use v6.c;

use NativeCall;

use Method::Also;


use SourceViewGTK::Raw::LanguageManager;
use SourceViewGTK::Raw::Types;

use GLib::Roles::Object;

use SourceViewGTK::Language;

class SourceViewGTK::LanguageManager {
  also does GLib::Roles::Object;

  has GtkSourceLanguageManager $!slm;

  submethod BUILD (:$manager) {
    self!setObject($!slm = $manager);
  }

  method SourceViewGTK::Raw::Definitions::GtkSourceLanguageManager
    is also<LanguageManager>
    { $!slm }

  method new {
    self.bless( manager => gtk_source_language_manager_new() );
  }

  method get_default
    is also<
      get-default
      default
    >
  {
    self.bless( manager => gtk_source_language_manager_get_default() );
  }

  method get_language (Str() $id) is also<get-language> {
    my $l = gtk_source_language_manager_get_language($!slm, $id);
    $l.defined ?? SourceViewGTK::Language.new($l) !! Nil;
  }

  method get_search_path is also<get-search-path> {
    my CArray[Str] $sps = gtk_source_language_manager_get_search_path($!slm);
    my @sps;
    my $i = 0;
    @sps[$i] = $sps[$i++] while $sps[$i];
    @sps;
  }

  method get_language_ids is also<get-language-ids> {
    my CArray[Str] $lids = gtk_source_language_manager_get_language_ids($!slm);
    my @lids;
    my $i = 0;
    @lids[$i] = $lids[$i++] while $lids[$i];
    @lids;
  }

  method get_type is also<get-type> {
    gtk_source_language_manager_get_type();
  }

  method guess_language (Str() $filename, Str() $content_type)
    is also<guess-language>
  {
    my $l = gtk_source_language_manager_guess_language(
      $!slm,
      $filename,
      $content_type
    );
    $l.defined ?? SourceViewGTK::Language.new($l) !! Nil;
  }

  proto method set_search_path (|)
    is also<set-search-path>
    { * }

  multi method set_search_path(@dirs)  {
    die '@dirs must only contain Str objects' unless @dirs.all ~~ Str;
    my $sp = CArray[Str].new;
    $sp[$_] = @dirs[$_] for ^@dirs.elems;
    samewith($sp);
  }
  multi method set_search_path (CArray[Str] $dirs) {
    gtk_source_language_manager_set_search_path($!slm, $dirs);
  }

}
