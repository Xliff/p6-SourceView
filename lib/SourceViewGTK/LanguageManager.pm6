use v6.c;

use Method::Also;
use NativeCall;

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
    is also<
      LanguageManager
      GtkSourceLanguageManager
    >
  { $!slm }

  method new {
    my $manager = gtk_source_language_manager_new();

    $manager ?? self.bless(:$manager) !! Nil;
  }

  method get_default
    is also<
      get-default
      default
    >
  {
    my $manager = gtk_source_language_manager_get_default();

    $manager ?? self.bless(:$manager) !! Nil;
  }

  method get_language (Str() $id, :$raw = False) is also<get-language> {
    my $l = gtk_source_language_manager_get_language($!slm, $id);

    $l ??
      ( $raw ?? $l !! SourceViewGTK::Language.new($l) )
      !!
      Nil;
  }

  method get_search_path is also<get-search-path> {
    CStringArrayToArray( gtk_source_language_manager_get_search_path($!slm) )
  }

  method get_language_ids is also<get-language-ids> {
    CStringArrayToArray( gtk_source_language_manager_get_language_ids($!slm) );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gtk_source_language_manager_get_type,
      $n,
      $t
    );
  }

  method guess_language (Str() $filename, Str() $content_type, :$raw = False)
    is also<guess-language>
  {
    my $l = gtk_source_language_manager_guess_language(
      $!slm,
      $filename,
      $content_type
    );

    $l ??
      ( $raw ?? $l !! SourceViewGTK::Language.new($l) )
      !!
      Nil;
  }

  proto method set_search_path (|)
    is also<set-search-path>
    { * }

  multi method set_search_path(@dirs)  {
    die '@dirs must only contain Str objects' unless @dirs.all ~~ Str;

    samewith( ArrayToCArray(Str, @dirs) );
  }
  multi method set_search_path (CArray[Str] $dirs) {
    gtk_source_language_manager_set_search_path($!slm, $dirs);
  }

}
