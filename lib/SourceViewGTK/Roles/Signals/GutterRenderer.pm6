use v6.c;

use NativeCall;

use GTK::Raw::ReturnedValue;

use GTK::Compat::Types;
use GTK::Raw::Types;
use SourceViewGTK::Raw::Types;

use GTK::Roles::Signals::Generic;

role SourceViewGTK::Roles::Signals::GutterRenderer {
  also does GTK::Roles::Signals::Generic;
  
  has %!signals-sgr;
  
    # GtkSourceGutterRenderer, GtkTextIter, GdkRectangle, GdkEvent, gpointer
  method connect-activate (
    $obj,
    $signal = 'activate',
    &handler?
  ) {
    my $hid;
    %!signals-sgr{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-activate($obj, $signal,
        -> $, $gtir, $gre, $get, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          my $r = ReturnedValue.new;
          $s.emit( [self, $gtir, $gre, $get, $ud, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-sgr{$signal}[0].tap(&handler) with &handler;
    %!signals-sgr{$signal}[0];
  }

  # GtkSourceGutterRenderer, GtkTextIter, GdkRectangle, GdkEvent, gpointer --> gboolean
  method connect-query-activatable (
    $obj,
    $signal = 'query-activatable',
    &handler?
  ) {
    my $hid;
    %!signals-sgr{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-query-activatable($obj, $signal,
        -> $, $gtir, $gre, $get, $ud --> gboolean {
          CATCH {
            default { $s.quit($_) }
          }

          my $r = ReturnedValue.new;
          $s.emit( [self, $gtir, $gre, $get, $ud, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-sgr{$signal}[0].tap(&handler) with &handler;
    %!signals-sgr{$signal}[0];
  }

  # GtkSourceGutterRenderer, GtkTextIter, GtkTextIter, GtkSourceGutterRendererState, gpointer
  method connect-query-data (
    $obj,
    $signal = 'query-data',
    &handler?
  ) {
    my $hid;
    %!signals-sgr{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-query-data($obj, $signal,
        -> $, $gtir1, $gtir2, $gsgrse, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          $s.emit( [self, $gtir1, $gtir2, $gsgrse, $ud ] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-sgr{$signal}[0].tap(&handler) with &handler;
    %!signals-sgr{$signal}[0];
  }

  # GtkSourceGutterRenderer, GtkTextIter, GdkRectangle, gint, gint, GtkTooltip, gpointer --> gboolean
  method connect-query-tooltip (
    $obj,
    $signal = 'query-tooltip',
    &handler?
  ) {
    my $hid;
    %!signals-sgr{$signal} //= do {
      my $s = Supplier.new;
      $hid = g-connect-query-tooltip($obj, $signal,
        -> $, $gtir, $gre, $gt1, $gt2, $gtp, $ud --> gboolean {
          CATCH {
            default { $s.quit($_) }
          }

          my $r = ReturnedValue.new;
          $s.emit( [self, $gtir, $gre, $gt1, $gt2, $gtp, $ud, $r] );
          $r.r;
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-sgr{$signal}[0].tap(&handler) with &handler;
    %!signals-sgr{$signal}[0];
  }

}

# GtkSourceGutterRenderer, GtkTextIter, GdkRectangle, GdkEvent, gpointer
sub g-connect-activate(
  Pointer $app,
  Str $name,
  &handler (Pointer, GtkTextIter, GdkRectangle, GdkEvent, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }

# GtkSourceGutterRenderer, GtkTextIter, GdkRectangle, GdkEvent, gpointer --> gboolean
sub g-connect-query-activatable(
  Pointer $app,
  Str $name,
  &handler (Pointer, GtkTextIter, GdkRectangle, GdkEvent, Pointer --> gboolean),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }

# GtkSourceGutterRenderer, GtkTextIter, GtkTextIter, GtkSourceGutterRendererState, gpointer
sub g-connect-query-data(
  Pointer $app,
  Str $name,
  &handler (Pointer, GtkTextIter, GtkTextIter, uint32, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }

# GtkSourceGutterRenderer, GtkTextIter, GdkRectangle, gint, gint, GtkTooltip, gpointer --> gboolean
sub g-connect-query-tooltip(
  Pointer $app,
  Str $name,
  &handler (Pointer, GtkTextIter, GdkRectangle, gint, gint, GtkTooltip, Pointer --> gboolean),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
