use v6.c;

use GTK::Raw::ReturnedValue;

use GTK::Compat::Types;
use SourceViewGTK::Raw::Types;

use GTK::Roles::Signals::Generic;

role SourceViewGTK::Roles::Signals::View {
  also does GTK::Roles::Signals::Generic;
  
  has %!signals-sv;
  
   # GtkSourceView, uint32, gpointer
  method connect-change-case (
    $obj,
    $signal = 'change-case',
    &handler?
  ) {
    my $hid;
    %!signals-sv //= do {
      my $s = Supplier.new;
      $hid = g-connect-uint($obj, $signal,
        -> $, $gsccte, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          $s.emit( [self, $gsccte, $ud ] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-sv{$signal}[0].tap(&handler) with &handler;
    %!signals-sv{$signal}[0];
  }

  # GtkSourceView, gint, gpointer
  method connect-change-number (
    $obj,
    $signal = 'change-number',
    &handler?
  ) {
    my $hid;
    %!signals-sv //= do {
      my $s = Supplier.new;
      $hid = g-connect-int($obj, $signal,
        -> $, $gt, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          $s.emit( [self, $gt, $ud ] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-sv{$signal}[0].tap(&handler) with &handler;
    %!signals-sv{$signal}[0];
  }

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

  # GtkSourceView, gboolean, gpointer
  method connect-move-lines (
    $obj,
    $signal = 'move-lines',
    &handler?
  ) {
    my $hid;
    %!signals-sv //= do {
      my $s = Supplier.new;
      $hid = g-connect-uint($obj, $signal,
        -> $, $gn, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          $s.emit( [self, $gn, $ud ] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-sv{$signal}[0].tap(&handler) with &handler;
    %!signals-sv{$signal}[0];
  }

  # GtkSourceView, gboolean, gpointer
  method connect-move-to-matching-bracket (
    $obj,
    $signal = 'move-to-matching-bracket',
    &handler?
  ) {
    my $hid;
    %!signals-sv //= do {
      my $s = Supplier.new;
      $hid = g-connect-uint($obj, $signal,
        -> $, $gn, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          $s.emit( [self, $gn, $ud ] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-sv{$signal}[0].tap(&handler) with &handler;
    %!signals-sv{$signal}[0];
  }

  # GtkSourceView, gint, gpointer
  method connect-move-words (
    $obj,
    $signal = 'move-words',
    &handler?
  ) {
    my $hid;
    %!signals-sv //= do {
      my $s = Supplier.new;
      $hid = g-connect-int($obj, $signal,
        -> $, $gt, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          $s.emit( [self, $gt, $ud ] );
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
