use v6.c;

use GTK::Compat::Types;
use SourceViewGTK::Raw::Types;

class SourceViewGTK::LanguageManager {
  has GtkSourceLanguageManager $!slm;
  
  submethod BUILD (:$manager) {
    $!slm = $manager;
  }
  
  method new {
    self.bless( manager => gtk_source_language_manager_new() );
  }
  
  method get_default is also<get-default> {
    gtk_source_language_manager_get_default($!slm);
  }

  method get_language (Str() $id) is also<get-language> {
    gtk_source_language_manager_get_language($!slm, $id);
  }
  
  method get_search_path is also<get-search-path> {
    my CArray[Str] $sps = gtk_source_manager_get_search_path($slm);
    my @sps;
    my $i = 0;
    @sps[$i] = $sps[$i++] while $sps[$i];
    @sps;   b bnm,. 
  }
    
  method get_language_ids is also<get-language-ids> {
    my CArray[Str] $lids = gtk_source_manager_get_language_ids($slm);
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
    gtk_source_language_manager_guess_language(
      $!slm, 
      $filename, 
      $content_type
    );
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