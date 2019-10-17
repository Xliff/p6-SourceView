use v6.c;

use Method::Also;
use NativeCall;

use GTK::Compat::Types;

use GTK::Raw::Utils;

use GIO::InputStream;

use GTK::Compat::Roles::GFile;

use SourceViewGTK::Raw::Types;
use SourceViewGTK::Raw::FileLoader;

use GTK::Compat::Roles::Object;

class SourceViewGTK::FileLoader {
  also does GTK::Compat::Roles::Object;

  has GtkSourceFileLoader $!sfl;

  submethod BUILD (:$loader) {
    self!setObject($!sfl = $loader);
  }

  method SourceViewGTK::Raw::Types::GtkSourceFileLoader
    is also<FileLoader>
  { $!sfl }

  method new (GtkSourceBuffer() $buffer, GtkSourceFile() $file) {
    my $o = self.bless( loader => gtk_source_file_loader_new($buffer, $file) );
    $o;
  }

  method new_from_stream (
    GtkSourceBuffer() $buffer,
    GtkSourceFile() $file,
    GInputStream() $stream
  )
    is also<new-from-stream>
  {
    self.bless(
      loader => gtk_source_file_loader_new_from_stream(
        $buffer,
        $file,
        $stream
      )
    )
  }

  method error_quark is also<error-quark> {
    gtk_source_file_loader_error_quark();
  }

  method get_buffer
    is also<
      get-buffer
      buffer
    >
  {
    gtk_source_file_loader_get_buffer($!sfl);
  }

  method get_compression_type
    is also<
      get-compression-type
      compression_type
      compression-type
    >
  {
    gtk_source_file_loader_get_compression_type($!sfl);
  }

  method get_encoding
    is also<
      get-encoding
      encoding
    >
  {
    gtk_source_file_loader_get_encoding($!sfl);
  }

  method get_file
    is also<
      get-file
      file
    >
  {
    gtk_source_file_loader_get_file($!sfl);
  }

  method get_input_stream (:$raw = False)
    is also<
      get-input-stream
      input_stream
      input-stream
    >
  {
    my $rv = gtk_source_file_loader_get_input_stream($!sfl);

    $raw ?? $rv !! GIO::InputStream.new($rv);
  }

  method get_location (:$raw = False)
    is also<
      get-location
      location
    >
  {
    my $l = gtk_source_file_loader_get_location($!sfl);

    $raw ?? $l !! GTK::Compat::Roles::GFile.new($l);
  }

  method get_newline_type
    is also<
      get-newline-type
      newline_type
      newline-type
    >
  {
    gtk_source_file_loader_get_newline_type($!sfl);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_source_file_loader_get_type, $n, $t );
  }

  proto method load_async (|)
    is also<load-async>
  { * }

  multi method load_async (
    Int() $io_priority,
    &callback,
    &progress_callback = -> $, $, $ { },
    gpointer $progress_callback_data = Pointer,
    GDestroyNotify $progress_callback_notify = Pointer,
    gpointer $user_data = Pointer
  ) {
    samewith(
      $io_priority,
      GCancellable,
      &progress_callback,
      $progress_callback_data,
      $progress_callback_notify,
      &callback,
      $user_data
    );
  }
  multi method load_async (
    Int() $io_priority,
    GCancellable() $cancellable,
    &progress_callback,
    gpointer $progress_callback_data,
    GDestroyNotify $progress_callback_notify,
    &callback,
    gpointer $user_data = Pointer
  ) {
    my gint $ip = resolve-int($io_priority);

    gtk_source_file_loader_load_async(
      $!sfl,
      $ip,
      $cancellable,
      &progress_callback,
      $progress_callback_data,
      $progress_callback_notify,
      &callback,
      $user_data
    );
  }

  proto method load_finished (|)
    is also<load-finished>
  { * }

  multi method load_finish (GAsyncResult $result) {
    my $error = CArray[Pointer[GError]].new;

    samewith($result, $error);
  }
  multi method load_finish (
    GAsyncResult() $result,
    CArray[Pointer[GError]] $error = gerror()
  ) {
    clear_error;
    gtk_source_file_loader_load_finish($!sfl, $result, $error);
    set_error($error);
  }

  method set_candidate_encodings (GSList() $candidate_encodings)
    is also<set-candidate-encodings>
  {
    gtk_source_file_loader_set_candidate_encodings(
      $!sfl,
      $candidate_encodings
    );
  }

}
