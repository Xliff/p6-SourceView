use v6.c;

use Method::Also;
use NativeCall;

use SourceViewGTK::Raw::Types;
use SourceViewGTK::Raw::FileLoader;

use GIO::InputStream;
use SourceViewGTK::Buffer;
use SourceViewGTK::Encoding;
use SourceViewGTK::File;

use GLib::Roles::Object;
use GIO::Roles::GFile;

class SourceViewGTK::FileLoader {
  also does GLib::Roles::Object;

  has GtkSourceFileLoader $!sfl;

  submethod BUILD (:$loader) {
    self!setObject($!sfl = $loader);
  }

  method SourceViewGTK::Raw::Definitions::GtkSourceFileLoader
    is also<
      FileLoader
      GtrkSourceFileLoader
    >
  { $!sfl }

  method new (GtkSourceBuffer() $buffer, GtkSourceFile() $file) {
    my $loader = gtk_source_file_loader_new($buffer, $file);

    $loader ?? self.bless( :$loader ) !! Nil;
  }

  method new_from_stream (
    GtkSourceBuffer() $buffer,
    GtkSourceFile() $file,
    GInputStream() $stream
  )
    is also<new-from-stream>
  {
    my $loader = gtk_source_file_loader_new_from_stream(
      $buffer,
      $file,
      $stream
    );

    $loader ?? self.bless( :$loader ) !! Nil;
  }

  method error_quark is also<error-quark> {
    gtk_source_file_loader_error_quark();
  }

  method get_buffer (:$raw = False)
    is also<
      get-buffer
      buffer
    >
  {
    my $b = gtk_source_file_loader_get_buffer($!sfl);

    $b ??
      ( $raw ?? $b !! SourceViewGTK::Buffer.new($b) )
      !!
      Nil;
  }

  method get_compression_type
    is also<
      get-compression-type
      compression_type
      compression-type
    >
  {
    GtkSourceCompressionTypeEnum(
      gtk_source_file_loader_get_compression_type($!sfl)
    );
  }

  method get_encoding (:$raw = False)
    is also<
      get-encoding
      encoding
    >
  {
    my $e = gtk_source_file_loader_get_encoding($!sfl);

    $e ??
      ( $raw ?? $e !! SourceViewGTK::Encoding.new($e) )
      !!
      Nil;
  }

  method get_file (:$raw = False)
    is also<
      get-file
      file
    >
  {
    my $f = gtk_source_file_loader_get_file($!sfl);

    $f ??
      ( $raw ?? $f !! SourceViewGTK::File.new($f) )
      !!
      Nil;
  }

  method get_input_stream (:$raw = False)
    is also<
      get-input-stream
      input_stream
      input-stream
    >
  {
    my $is = gtk_source_file_loader_get_input_stream($!sfl);

    $is ??
      ( $raw ?? $is !! GIO::InputStream.new($is) )
      !!
      Nil;
  }

  method get_location (:$raw = False)
    is also<
      get-location
      location
    >
  {
    my $l = gtk_source_file_loader_get_location($!sfl);

    $l ??
      ( $raw ?? $l !! GIO::Roles::GFile.new-file-obj($l) )
      !!
      Nil;
  }

  method get_newline_type
    is also<
      get-newline-type
      newline_type
      newline-type
    >
  {
    GtkSourceNewlineTypeEnum( gtk_source_file_loader_get_newline_type($!sfl) );
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
    &progress_callback                       = Callable,
    gpointer $progress_callback_data         = Pointer,
    GDestroyNotify $progress_callback_notify = Pointer,
    gpointer $user_data                      = Pointer
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
    my gint $ip = $io_priority;

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


  multi method load_finish (
    GAsyncResult() $result,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<load-finished>
  {
    clear_error;
    gtk_source_file_loader_load_finish($!sfl, $result, $error);
    set_error($error);
  }

  proto method set_candidate_encodings (|)
    is also<set-candidate-encodings>
  { * }

  multi method set_candidate_encodings (@candidate_encodings) {
    samewith( GLib::GSList.new(@candidate_encodings) );
  }
  multi method set_candidate_encodings ($candidate_encodings is copy) {
    my $compatible = $candidate_encodings ~~ GSList;
    my $coercible  = $candidate_encodings.^lookup('GSList');
    die '$candidate_encodings must be a GSList-compatible object'
      unless $compatible || $coercible;

    $candidate_encodings .= GSList if $coercible;

    gtk_source_file_loader_set_candidate_encodings(
      $!sfl,
      $candidate_encodings
    );
  }

}
