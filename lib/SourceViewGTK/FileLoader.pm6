use v6.c;

use NativeCall;

use GTK::Compat::Types;

use SourceViewGTK::Raw::Types;
use SourceViewGTK::Raw::FileLoader;

use GTK::Compat::Roles::Object;

class SourceViewGTK::FileLoader {
  also does GTK::Compat::Roles::Object;

  has GtkSourceFileLoader $!sfl;

  submethod BUILD (:$loader) {
    self!setObject($!sfl = $loader);
  }

  method SourceViewGTK::Raw::Types::GtkSourceFileLoader { $!sfl }

  method new (GtkSourceBuffer() $buffer, GtkSourceFile() $file) {
    self.bless( loader => gtk_source_file_loader_new($buffer, $file) );
  }

  method new_from_stream (
    GtkSourceBuffer $buffer,
    GtkSourceFile() $file,
    GInputStream $stream
  ) {
    self.bless(
      loader => gtk_source_file_loader_new_from_stream($buffer, $file, $stream)
    )
  }

  method error_quark {
    gtk_source_file_loader_error_quark();
  }

  method get_buffer {
    gtk_source_file_loader_get_buffer($!sfl);
  }

  method get_compression_type {
    gtk_source_file_loader_get_compression_type($!sfl);
  }

  method get_encoding {
    gtk_source_file_loader_get_encoding($!sfl);
  }

  method get_file {
    gtk_source_file_loader_get_file($!sfl);
  }

  method get_input_stream {
    gtk_source_file_loader_get_input_stream($!sfl);
  }

  method get_location {
    gtk_source_file_loader_get_location($!sfl);
  }

  method get_newline_type {
    gtk_source_file_loader_get_newline_type($!sfl);
  }

  method get_type {
    gtk_source_file_loader_get_type();
  }

  multi method load_async (
    Int() $io_priority,
    &callback,
    &progress_callback = -> $, $, $ { },
    GCancellable $cancellable = Pointer,
    gpointer $progress_callback_data = Pointer,
    GDestroyNotify $progress_callback_notify = Pointer,
    gpointer $user_data = Pointer
  ) {
    samewith(
      $io_priority,
      $cancellable,
      &progress_callback,
      $progress_callback_data,
      $callback,
      $user_data
    );
  }
  multi method load_async (
    Int() $io_priority,
    GCancellable $cancellable,
    &progress_callback,
    gpointer $progress_callback_data,
    GDestroyNotify $progress_callback_notify,
    &callback,
    gpointer $user_data = Pointer
  ) {
    my gint $ip = self.RESOLVE-INT($io_priority);
    gtk_source_file_loader_load_async(
      $!sfl,
      $ip,
      $cancellable,
      &progress_callback,
      $progress_callback_data,
      $progress_callback_notify,
      $callback,
      $user_data
    );
  }

  multi method load_finish (GAsyncResult $result) {
    my $error = CArray[Pointer[GError]].new;

    samewith($result, $error);
  }
  multi method load_finish (
    GAsyncResult $result,
    CArray[Pointer[GError]] $error = gerror()
  ) {
    $ERROR = Nil;
    gtk_source_file_loader_load_finish($!sfl, $result, $error);
    $ERROR = $error[0] with $error[0];
  }

  method set_candidate_encodings (GSList() $candidate_encodings) {
    gtk_source_file_loader_set_candidate_encodings(
      $!sfl,
      $candidate_encodings
    );
  }

}
