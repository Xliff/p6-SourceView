use v6.c;

use Method::Also;
use NativeCall;

use SourceViewGTK::Raw::Types;
use SourceViewGTK::Raw::StyleSchemeManager;

use SourceViewGTK::StyleScheme;

class SourceViewGTK::StyleSchemeManager {
  has GtkSourceStyleSchemeManager $!sscm;

  submethod BUILD (:$manager) {
    $!sscm = $manager;
  }

  method SourceViewGTK::Raw::Definitions::GtkSourceStyleSchemeManager
    is also<GtkSourceStyleSchemeManager>
  { $!sscm }

  multi method new (GtkSourceStyleSchemeManager $manager) {
    $manager ?? self.bless($manager) !! Nil;
  }
  multi method new {
    my $manager = gtk_source_style_scheme_manager_new();

    $manager ?? self.bless($manager) !! Nil;
  }

  method get_default is also<get-default> {
    my $manager = gtk_source_style_scheme_manager_get_default();

    $manager ?? self.bless($manager) !! Nil;
  }

  method append_search_path (Str() $path) is also<append-search-path> {
    gtk_source_style_scheme_manager_append_search_path($!sscm, $path);
  }

  method force_rescan is also<force-rescan> {
    gtk_source_style_scheme_manager_force_rescan($!sscm);
  }

  method get_scheme (Str() $scheme_id, :$raw = False) is also<get-scheme> {
    my $sc = gtk_source_style_scheme_manager_get_scheme($!sscm, $scheme_id);

    $sc ??
      ( $raw ?? $sc !! SourceViewGTK::StyleScheme.new($sc) )
      !!
      Nil;
  }

  method get_scheme_ids is also<get-scheme-ids> {
    CStringArrayToArray(
      gtk_source_style_scheme_manager_get_search_path($!sscm)
    );
  }

  method get_search_path is also<get-search-path> {
    CStringArrayToArray(
      gtk_source_style_scheme_manager_get_search_path(
        $!sscm
      )
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gtk_source_style_scheme_manager_get_type,
      $n,
      $t
    );
  }

  method prepend_search_path (Str() $path) is also<prepend-search-path> {
    gtk_source_style_scheme_manager_prepend_search_path($!sscm, $path);
  }

  proto method set_search_path(|)
    is also<set-search-path>
  { * }

  multi method set_search_path(@path)  {
    die '@path must contain only strings.' unless @path.all ~~ Str;

    samewith( ArrayToCArray(Str, @path) );
  }
  multi method set_search_path (CArray[Str] $path) {
    gtk_source_style_scheme_manager_set_search_path($!sscm, $path);
  }

}
