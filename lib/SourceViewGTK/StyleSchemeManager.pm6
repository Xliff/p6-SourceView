use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;
use SourceViewGTK::Raw::StyleSchemeManager;

class SourceViewGTK::StyleSchemeManager {
  has GtkSourceStyleSchemeManager $!sscm;
  
  submethod BUILD (:$manager) {
    $!sscm = $manager;
  }
  
  method new {
    self.bless( manager => gtk_source_style_scheme_manager_new() );
  }

  method append_search_path (Str() $path) is also<append-search-path> {
    gtk_source_style_scheme_manager_append_search_path($!sscm, $path);
  }

  method force_rescan is also<force-rescan> {
    gtk_source_style_scheme_manager_force_rescan($!sscm);
  }

  method get_default is also<get-default> {
    gtk_source_style_scheme_manager_get_default($!sscm);
  }

  method get_scheme (Str() $scheme_id) is also<get-scheme> {
    gtk_source_style_scheme_manager_get_scheme($!sscm, $scheme_id);
  }
  
  method get_scheme_ids is also<get-scheme-ids> {
    my CArray[Str] $sids = gtk_source_style_scheme_manager_get_search_path(
      $!sscm
    );
    my ($i, @sids) = (0);
    @sids[$i] = $sids[$i++] while $sids[$i];
    @sids;
  }
  
  method get_search_path is also<get-search-path> {
    my CArray[Str] $sp = gtk_source_style_scheme_manager_get_search_path(
      $!sscm
    );
    my ($i, @sp) = (0);
    @sp[$i] = $sp[$i++] while $sp[$i];
    @sp;
  }

  method get_type is also<get-type> {
    gtk_source_style_scheme_manager_get_type();
  }

  method prepend_search_path (Str() $path) is also<prepend-search-path> {
    gtk_source_style_scheme_manager_prepend_search_path($!sscm, $path);
  }

  proto method set_search_path(|) 
    is also<set-search-path>
    { * }
    
  multi method set_search_path(@path)  {
    die '@path must contain only strings.' unless @path.all ~~ Str;
    my $p = CArray[Str].new;
    $p[$_] = @path[$_] for ^@path.elems;
    samewith($p);
  }
  multi method set_search_path (CArray[Str] $path) {
    gtk_source_style_scheme_manager_set_search_path($!sscm, $path);
  }

}
