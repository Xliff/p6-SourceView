use v6.c;

use NativeCall;

use GTK::Compat::Types;

use SourceViewGTK::Raw::Types;
use SourceViewGTK::Raw::File;

use GTK::Compat::Roles::Object;

class SourceViewGTK::File {
  also does GTK::Compat::Roles::Object;
  
  has GtkSourceFile $!sf;
  
  submethod BUILD (:$file) {
    self!setObject($!sf = $file);
  }
  
  method SourceViewGTK::Raw::Types::GtkSourceFile { $!sf }
  
  method new {
    self.bless( file => gtk_source_file_new() );
  }
  
  method location is rw {
    Proxy.new(
      FETCH => sub ($) {
        #GTK::Compat::File.new( gtk_source_file_get_location($!sf) );
        gtk_source_file_get_location($!sf);
      },
      STORE => sub ($, GFile() $location is copy) {
        gtk_source_file_set_location($!sf, $location);
      }
    );
  }

  
  method check_file_on_disk {
    gtk_source_file_check_file_on_disk($!sf);
  }

  method get_compression_type {
    GtkSourceCompressionType( gtk_source_file_get_compression_type($!sf) );
  }

  method get_encoding {
    gtk_source_file_get_encoding($!sf);
  }

  method get_newline_type {
    GtkSourceNewlineType( gtk_source_file_get_newline_type($!sf) );
  }

  method get_type {
    gtk_source_file_get_type();
  }

  method is_deleted {
    so gtk_source_file_is_deleted($!sf);
  }

  method is_externally_modified {
    so gtk_source_file_is_externally_modified($!sf);
  }

  method is_local {
    so gtk_source_file_is_local($!sf);
  }

  method is_readonly {
    so gtk_source_file_is_readonly($!sf);
  }

  method set_mount_operation_factory (
    &callback, 
    gpointer $user_data, 
    GDestroyNotify $notify = Pointer
  ) {
    gtk_source_file_set_mount_operation_factory(
      $!sf, 
      &callback, 
      $user_data, 
      $notify
    );
  }

}
