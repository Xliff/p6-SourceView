use v6.c;

use SourceViewGTK::Raw::Types;
use SourceViewGTK::Raw::Mark;

use GTK::Compat::Roles::Object;

class SourceViewGTK::Mark {
  also does GTK::Compat::Roles::Object;
  
  has GtkSourceMark $!sm;
  
  submethod BUILD (:$mark) {
    self!setObject($!sm = $mark);
  }
  
  method SourceViewGTK::Raw::Types::GtkSourceMark { $!sm }
  
  method new (Str() $name, Str() $category) {
    self.bless( mark => gtk_source_mark_new($name, $category) );
  }
  
  method get_category {
    gtk_source_mark_get_category($!sm);
  }

  method get_type {
    gtk_source_mark_get_type();
  }

  method next (Str() $category) {
    gtk_source_mark_next($!sm, $category);
  }

  method prev (Str() $category) {
    gtk_source_mark_prev($!sm, $category);
  }

}
