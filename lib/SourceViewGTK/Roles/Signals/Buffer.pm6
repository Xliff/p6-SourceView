use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::SourceView::Raw::Types;

role SourceViewGTK::Roles::Buffer {
  has %!signals-sb;
  
  # GtkSourceBuffer, GtkTextIter, GtkSourceBracketMatchType, gpointer
  method connect-bracket-matched (
    $obj,
    $signal = 'bracket-matched',
    &handler?
  ) {
    my $hid;
    %!signals-sb //= do {
      my $s = Supplier.new;
      $hid = g-connect-bracket-matched($obj, $signal,
        -> $, $gtir, $gsbmte, $ud {
          CATCH {
            default { $s.quit($_) }
          }
          
          $s.emit( [self, $gtir, $gsbmte, $ud ] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-sb{$signal}[0].tap(&handler) with &handler;
    %!signals-sb{$signal}[0];
  }

  # GtkSourceBuffer, GtkTextIter, GtkTextIter, gpointer
  method connect-highlight-updated (
    $obj,
    $signal = 'highlight-updated',
    &handler?
  ) {
    my $hid;
    %!signals-sb //= do {
      my $s = Supplier.new;
      $hid = g-connect-highlight-updated($obj, $signal,
        -> $, $gtir1, $gtir2, $ud {
          CATCH {
            default { $s.quit($_) }
            
           $s.emit( [self, $gtir1, $gtir2, $ud] );
          }
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-sb{$signal}[0].tap(&handler) with &handler;
    %!signals-sb{$signal}[0];
  }

  # GtkSourceBuffer, GtkTextMark, gpointer
  method connect-source-mark-updated (
    $obj,
    $signal = 'source-mark-updated',
    &handler?
  ) {
    my $hid;
    %!signals-sb //= do {
      my $s = Supplier.new;
      $hid = g-connect-source-mark-updated($obj, $signal,
        -> $, $gtmk, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          $s.emit( [self, $gtmk, $ud] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-sb{$signal}[0].tap(&handler) with &handler;
    %!signals-sb{$signal}[0];
  }
  
}

# GtkSourceBuffer, GtkTextIter, GtkSourceBracketMatchType, gpointer
sub g-connect-bracket-matched(
  Pointer $app,
  Str $name,
  &handler (Pointer, GtkTextIter, GtkSourceBracketMatchType, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }

# GtkSourceBuffer, GtkTextIter, GtkTextIter, gpointer
sub g-connect-highlight-updated(
  Pointer $app,
  Str $name,
  &handler (Pointer, GtkTextIter, GtkTextIter, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }

# GtkSourceBuffer, GtkTextMark, gpointer
sub g-connect-source-mark-updated(
  Pointer $app,
  Str $name,
  &handler (Pointer, GtkTextMark, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
