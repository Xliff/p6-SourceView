use v6.c;

use NativeCall;

use GTK::Compat::Types;

use SourceViewGTK::Raw::Types;
use SourceViewGTK::Raw::FileSaver;

use GTK::Roles::Types;
use GLib::Roles::Object;

use SourceViewGTK::Buffer;
use SourceViewGTK::Encoding;
use SourceViewGTK::File;

class SourceViewGTK::FileSaver {
  also does GTK::Roles::Types;
  also does GLib::Roles::Object;

  has GtkSourceFileSaver $!sfs;

  submethod BUILD (:$saver) {
    self!setObject($!sfs = $saver);
  }

  method SourceViewGTK::Raw::Types::GtkSourceFileSaver { $!sfs }

  method new (GtkSourceBuffer() $buffer, GtkSourceFile $file) {
    self.bless( saver => gtk_source_file_saver_new($buffer, $file) );
  }

  method new_with_target (
    GtkSourceBuffer() $buffer,
    GtkSourceFile() $file,
    GFile $target_location
  ) {
    self.bless(
      saver => gtk_source_file_saver_new_with_target(
        $buffer,
        $file,
        $target_location
      )
    );
  }

  method compression_type is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkSourceCompressionType(
          gtk_source_file_saver_get_compression_type($!sfs)
        );
      },
      STORE => sub ($, Int() $compression_type is copy) {
        my guint $ct = self.RESOLVE-UINT($compression_type);
        gtk_source_file_saver_set_compression_type($!sfs, $ct);
      }
    );
  }

  method encoding is rw {
    Proxy.new(
      FETCH => sub ($) {
        SourceViewGTK::Encoding.new(
          gtk_source_file_saver_get_encoding($!sfs)
        );
      },
      STORE => sub ($, GtkSourceEncoding() $encoding is copy) {
        gtk_source_file_saver_set_encoding($!sfs, $encoding);
      }
    );
  }

  method flags is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkSourceFileSaverFlags( gtk_source_file_saver_get_flags($!sfs) );
      },
      STORE => sub ($, $flags is copy) {
        gtk_source_file_saver_set_flags($!sfs, $flags);
      }
    );
  }

  method newline_type is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkSourceNewlineType( gtk_source_file_saver_get_newline_type($!sfs) );
      },
      STORE => sub ($, Int() $newline_type is copy) {
        my guint $nt = self.RESOLVE-UINT($newline_type);
        gtk_source_file_saver_set_newline_type($!sfs, $nt);
      }
    );
  }

  method error_quark {
    gtk_source_file_saver_error_quark();
  }

  method get_buffer {
    SourceViewGTK::Buffer.new( gtk_source_file_saver_get_buffer($!sfs) );
  }

  method get_file {
    SourceViewGTK::File.new( gtk_source_file_saver_get_file($!sfs) );
  }

  method get_location {
    gtk_source_file_saver_get_location($!sfs);
  }

  method get_type {
    gtk_source_file_saver_get_type();
  }

  # ::FileLoader.load_async and ::FileSaver.save_async
  # do NOT match. This needs a review!
  multi method save_async (
    Int() $io_priority,
    &progress_callback,
    gpointer $progress_callback_data = Pointer,
    GDestroyNotify $progress_callback_notify = Pointer,
    &async_callback = -> {},
    gpointer $user_data = Pointer
  ) {
    samewith(
      $io_priority,
      GCancellable,
      &progress_callback,
      $progress_callback_data,
      $progress_callback_notify,
      &async_callback,
      $user_data
    );
  }
  multi method save_async (
    Int() $io_priority,
    GCancellable() $cancellable,
    &progress_callback,
    gpointer $progress_callback_data = Pointer,
    GDestroyNotify $progress_callback_notify = Pointer,
    &async_callback = -> {},
    gpointer $user_data = Pointer
  ) {
    my gint $iop = self.RESOLVE-INT($io_priority);
    gtk_source_file_saver_save_async(
      $!sfs,
      $io_priority,
      $cancellable,
      &progress_callback,
      $progress_callback_data,
      $progress_callback_notify,
      &async_callback,
      $user_data
    );
  }

  multi method save_finish (GAsyncResult $result) {
    my $error = CArray[Pointer[GError]].new;
    samewith($result, $error);
  }
  multi method save_finish (
    GAsyncResult $result,
    CArray[Pointer[GError]] $error = gerror()
  ) {
    gtk_source_file_saver_save_finish($!sfs, $result, $error);
  }

}
