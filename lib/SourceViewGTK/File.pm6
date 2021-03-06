use v6.c;

use Method::Also;

use SourceViewGTK::Raw::Types;
use SourceViewGTK::Raw::File;

use GLib::Roles::Object;

use GIO::Roles::GFile;

class SourceViewGTK::File {
  also does GLib::Roles::Object;

  has GtkSourceFile $!sf;

  submethod BUILD (:$file) {
    self!setObject($!sf = $file);
  }

  method SourceViewGTK::Raw::Definitions::GtkSourceFile
    is also<GtkSourceFile>
  { $!sf }

  method new {
    my $file = gtk_source_file_new();

    $file ?? self.bless( :$file ) !! Nil;
  }

  method location (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $f = gtk_source_file_get_location($!sf);

        $f ??
          ( $raw ?? $f !! GIO::Roles::GFile.new-file-obj($f) )
          !!
          Nil;
      },
      STORE => sub ($, GFile() $location is copy) {
        gtk_source_file_set_location($!sf, $location);
      }
    );
  }

  method check_file_on_disk is also<check-file-on-disk> {
    gtk_source_file_check_file_on_disk($!sf);
  }

  method get_compression_type
    is also<
      get-compression-type
      compression_type
      compression-type
    >
  {
    GtkSourceCompressionTypeEnum( gtk_source_file_get_compression_type($!sf) );
  }

  method get_encoding
    is also<
      get-encoding
      encoding
    >
  {
    gtk_source_file_get_encoding($!sf);
  }

  method get_newline_type
    is also<
      get-newline-type
      newline_type
      newline-type
    >
  {
    GtkSourceNewlineTypeEnum( gtk_source_file_get_newline_type($!sf) );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_source_file_get_type, $n, $t );
  }

  method is_deleted is also<is-deleted> {
    so gtk_source_file_is_deleted($!sf);
  }

  method is_externally_modified is also<is-externally-modified> {
    so gtk_source_file_is_externally_modified($!sf);
  }

  method is_local is also<is-local> {
    so gtk_source_file_is_local($!sf);
  }

  method is_readonly is also<is-readonly> {
    so gtk_source_file_is_readonly($!sf);
  }

  method set_mount_operation_factory (
    &callback,
    gpointer $user_data    = gpointer,
    GDestroyNotify $notify = GDestroyNotify
  )
    is also<set-mount-operation-factory>
  {
    gtk_source_file_set_mount_operation_factory(
      $!sf,
      &callback,
      $user_data,
      $notify
    );
  }

}
