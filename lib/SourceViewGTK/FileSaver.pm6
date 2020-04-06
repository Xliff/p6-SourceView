use v6.c;

use Method::Also;
use NativeCall;

use SourceViewGTK::Raw::Types;
use SourceViewGTK::Raw::FileSaver;

use SourceViewGTK::Buffer;
use SourceViewGTK::Encoding;
use SourceViewGTK::File;

use GLib::Roles::Object;

class SourceViewGTK::FileSaver {
  also does GLib::Roles::Object;

  has GtkSourceFileSaver $!sfs;

  submethod BUILD (:$saver) {
    self!setObject($!sfs = $saver);
  }

  method SourceViewGTK::Raw::Definitions::GtkSourceFileSaver
    is also<GtkSourceFileSaver>
  { $!sfs }

  multi method new (GtkSourceFileSaver $saver) {
    $saver ?? self.bless( :$saver ) !! Nil;
  }
  multi method new (GtkSourceBuffer() $buffer, GtkSourceFile() $file) {
    my $saver = gtk_source_file_saver_new($buffer, $file);

    $saver ?? self.bless( :$saver ) !! Nil;
  }

  method new_with_target (
    GtkSourceBuffer() $buffer,
    GtkSourceFile() $file,
    GFile() $target_location
  )
    is also<new-with-target>
  {
    my $saver = gtk_source_file_saver_new_with_target(
      $buffer,
      $file,
      $target_location
    );

    $saver ?? self.bless( :$saver ) !! Nil;
  }

  method compression_type is rw is also<compression-type> {
    Proxy.new(
      FETCH => sub ($) {
        GtkSourceCompressionTypeEnum(
          gtk_source_file_saver_get_compression_type($!sfs)
        );
      },
      STORE => sub ($, Int() $compression_type is copy) {
        my guint $ct = $compression_type;

        gtk_source_file_saver_set_compression_type($!sfs, $ct);
      }
    );
  }

  method encoding (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $e = gtk_source_file_saver_get_encoding($!sfs);

        $e ??
          ( $raw ?? $e !! SourceViewGTK::Encoding.new($e) )
          !!
          Nil;
      },
      STORE => sub ($, GtkSourceEncoding() $encoding is copy) {
        gtk_source_file_saver_set_encoding($!sfs, $encoding);
      }
    );
  }

  method flags is rw {
    Proxy.new(
      FETCH => sub ($) {
        GtkSourceFileSaverFlagsEnum( gtk_source_file_saver_get_flags($!sfs) );
      },
      STORE => sub ($, Int() $flags is copy) {
        gtk_source_file_saver_set_flags($!sfs, $flags);
      }
    );
  }

  method newline_type is rw is also<newline-type> {
    Proxy.new(
      FETCH => sub ($) {
        GtkSourceNewlineTypeEnum(
          gtk_source_file_saver_get_newline_type($!sfs)
        );
      },
      STORE => sub ($, Int() $newline_type is copy) {
        my guint $nt = $newline_type;

        gtk_source_file_saver_set_newline_type($!sfs, $nt);
      }
    );
  }

  method error_quark is also<error-quark> {
    gtk_source_file_saver_error_quark();
  }

  method get_buffer (:$raw = False) is also<get-buffer> {
    my $b = gtk_source_file_saver_get_buffer($!sfs);

    $b ??
      ( $raw ?? $b !! SourceViewGTK::Buffer.new($b) )
      !!
      Nil;
  }

  method get_file (:$raw = False)is also<get-file> {
    my $f = gtk_source_file_saver_get_file($!sfs);

    $f ??
      ( $raw ?? $f !! SourceViewGTK::File.new($f) )
      !!
      Nil;
  }

  method get_location (:$raw = False) is also<get-location> {
    my $l = gtk_source_file_saver_get_location($!sfs);

    $l ??
      ( $raw ?? $l !! GLib::Roles::GFile.new-file-obj($l) )
      !!
      Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_source_file_saver_get_type, $n, $t );
  }

  # ::FileLoader.load_async and ::FileSaver.save_async
  # do NOT match. This needs a review!

  proto method save_async (|)
    is also<save-async>
  { * }

  multi method save_async (
    Int() $io_priority,
    &progress_callback,
    gpointer $progress_callback_data         = gpointer,
    GDestroyNotify $progress_callback_notify = GDestroyNotify,
    &async_callback                          = Callable,
    gpointer $user_data                      = gpointer
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
    gpointer $progress_callback_data         = gpointer,
    GDestroyNotify $progress_callback_notify = GDestroyNotify,
    &async_callback                          = Callable,
    gpointer $user_data                      = gpointer
  ) {
    my gint $iop = $io_priority;

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

  method save_finish (
    GAsyncResult() $result,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<save-finish>
  {
    clear_error;
    my $rv = so gtk_source_file_saver_save_finish($!sfs, $result, $error);
    set_error($error);
    $rv;
  }

}
