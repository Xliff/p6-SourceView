use v6.c;

use Method::Also;

use GTK::Compat::Types;

use SourceViewGTK::Raw::Types;
use SourceViewGTK::Raw::Mark;

use GTK::Compat::Roles::Object;

class SourceViewGTK::Mark {
  also does GTK::Compat::Roles::Object;
  
  has GtkSourceMark $!sm;
  
  submethod BUILD (:$mark) {
    self!setObject($!sm = $mark);
  }
  
  method SourceViewGTK::Raw::Types::GtkSourceMark 
    is also<SourceMark> 
  { $!sm }
  
  multi method new (GtkSourceMark $mark) {
    my $o = self.bless(:$mark);
    #$o.upref;
    $o;
  }
  multi method new (Str() $name, Str() $category) {
    self.bless( mark => gtk_source_mark_new($name, $category) );
  }
  
  method get_category is also<get-category> {
    gtk_source_mark_get_category($!sm);
  }

  method get_type is also<get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &gtk_source_mark_get_type, $n, $t );
  }

  method next (Str() $category) {
    gtk_source_mark_next($!sm, $category);
  }

  method prev (Str() $category) {
    gtk_source_mark_prev($!sm, $category);
  }

}
