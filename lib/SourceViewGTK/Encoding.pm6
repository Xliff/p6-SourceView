use v6.c;

use GTK::Compat::GSList;

use SourceViewGTK::Raw::Types;
use SourceViewGTK::Raw::Encoding;

class SourceViewGTK::Encoding {
  has GtkSourceEncoding $!se;
  
  submethod BUILD (:$encoding) {
    $!se = $encoding;
  }
  
  method SourceViewGTK::Raw::Types::GtkSourceEncoding { $!se }
  
  method get_current {
    self.bless( encoding => gtk_source_encoding_get_current() );
  }
  
  method get_from_charset (Str() $charset) {
    self.bless( encoding => gtk_source_encoding_get_from_charset($charset) );
  }
  
  method get_utf8 {
    self.bless( encoding => gtk_source_encoding_get_utf8() );
  }
  
  # Static
  method copy (SourceViewGTK::Encoding:U: GtkSourceEncoding() $orig) {
    self.bless( encoding => gtk_source_encoding_copy($orig) );
  }

  method free {
    gtk_source_encoding_free($!se);
  }

  method get_all (SourceViewGTK::Encoding:U: ) {
    GTK::Compat::GSList.new( gtk_source_encoding_get_all() );
  }

  method get_charset {
    gtk_source_encoding_get_charset($!se);
  }

  method get_default_candidates (SourceViewGTK::Encoding:U: ) {
    GTK::Compat::GSList.new( 
      gtk_source_encoding_get_default_candidates()
    );
  }

  method get_name {
    gtk_source_encoding_get_name($!se);
  }

  method get_type {
    gtk_source_encoding_get_type();
  }

  method to_string {
    gtk_source_encoding_to_string($!se);
  }
  
}
