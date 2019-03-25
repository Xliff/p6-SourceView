use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;
use SourceViewGTK::Raw::Types;

use GTK::Roles::Signals::Generic;

role SourceViewGTK::Roles::Signals::View {
  also does GTK::Roles::Signals::Generic;
  
  has %!signals-sv;

  # GtkSourceView, GtkTextIter, GdkEvent, gpointer
  method connect-line-mark-activated (
    $obj,
    $signal = 'line-mark-activated',
    &handler?
  ) {
    my $hid;
    %!signals-sv //= do {
      my $s = Supplier.new;
      $hid = g-connect-line-mark-activated($obj, $signal,
        -> $, $gtir, $get, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          $s.emit( [self, $gtir, $get, $ud ] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-sv{$signal}[0].tap(&handler) with &handler;
    %!signals-sv{$signal}[0];
  }

  # GtkSourceView, GtkTextIter, gint, gpointer
  method connect-smart-home-end (
    $obj,
    $signal = 'smart-home-end',
    &handler?
  ) {
    my $hid;
    %!signals-sv //= do {
      my $s = Supplier.new;
      $hid = g-connect-smart-home-end($obj, $signal,
        -> $, $gtir, $gt, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          $s.emit( [self, $gtir, $gt, $ud ] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-sv{$signal}[0].tap(&handler) with &handler;
    %!signals-sv{$signal}[0];
  }

}

# GtkSourceView, GtkTextIter, GdkEvent, gpointer
sub g-connect-line-mark-activated(
  Pointer $app,
  Str $name,
  &handler (Pointer, GtkTextIter, GdkEvent, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }


# GtkSourceView, GtkTextIter, gint, gpointer
sub g-connect-smart-home-end(
  Pointer $app,
  Str $name,
  &handler (Pointer, GtkTextIter, gint, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
