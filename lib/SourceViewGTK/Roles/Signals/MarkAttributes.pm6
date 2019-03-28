use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;
use GTK::Raw::ReturnedValue;
use SourceViewGTK::Raw::Types;

role SourceViewGTK::Roles::Signals::MarkAttributes {
  has %!signals-sma;
  
  # GtkSourceMarkAttributes, GtkSourceMark, gpointer --> Str
  method connect-query-tooltip-markup (
    $obj,
    $signal = 'query-tooltip-markup',
    &handler?
  ) {
    my $hid;
    %!signals-sma{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-query-tooltip-markup($obj, $signal,
        -> $, $gsmk, $ud --> Str {
          CATCH {
            default { $s.quit($_) }
          }

          my $r = ReturnedValue.new;
          $s.emit( [self, $gsmk, $ud, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-sma{$signal}[0].tap(&handler) with &handler;
    %!signals-sma{$signal}[0];
  }

  # GtkSourceMarkAttributes, GtkSourceMark, gpointer --> Str
  method connect-query-tooltip-text (
    $obj,
    $signal = 'query-tooltip-text',
    &handler?
  ) {
    my $hid;
    %!signals-sma{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-query-tooltip-text($obj, $signal,
        -> $, $gsmk, $ud --> Str {
          CATCH {
            default { $s.quit($_) }
          }

          my $r = ReturnedValue.new;
          $s.emit( [self, $gsmk, $ud, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-sma{$signal}[0].tap(&handler) with &handler;
    %!signals-sma{$signal}[0];
  }
  
}

# GtkSourceMarkAttributes, GtkSourceMark, gpointer --> Str
sub g-connect-query-tooltip-markup(
  Pointer $app,
  Str $name,
  &handler (Pointer, GtkSourceMark, Pointer --> Str),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }

# GtkSourceMarkAttributes, GtkSourceMark, gpointer --> Str
sub g-connect-query-tooltip-text(
  Pointer $app,
  Str $name,
  &handler (Pointer, GtkSourceMark, Pointer --> Str),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
