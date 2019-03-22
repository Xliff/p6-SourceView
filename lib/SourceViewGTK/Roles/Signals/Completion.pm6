use v6.c;

use NativeCall;

use GTK::Compat::Types;
use SourceViewGTK::Raw::Types;

role SourceViewGTK::Roles::Signals::Completion {
  has %!signals-sc;
  
  # GtkSourceCompletion, GtkScrollStep, gint, gpointer
  method connect-move-cursor (
    $obj,
    $signal = 'move-cursor',
    &handler?
  ) {
    my $hid;
    %!signals-sc //= do {
      my $s = Supplier.new;
      $hid = g-connect-move($obj, $signal,
        -> $, $gssp, $gt, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          $s.emit( [self, $gssp, $gt, $ud ] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-sc{$signal}[0].tap(&handler) with &handler;
    %!signals-sc{$signal}[0];
  }

  # GtkSourceCompletion, GtkScrollStep, gint, gpointer
  method connect-move-page (
    $obj,
    $signal = 'move-page',
    &handler?
  ) {
    my $hid;
    %!signals-sc //= do {
      my $s = Supplier.new;
      $hid = g-connect-move($obj, $signal,
        -> $, $gssp, $gt, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          $s.emit( [self, $gssp, $gt, $ud ] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-sc{$signal}[0].tap(&handler) with &handler;
    %!signals-sc{$signal}[0];
  }

  # GtkSourceCompletion, GtkSourceCompletionContext, gpointer
  method connect-populate-context (
    $obj,
    $signal = 'populate-context',
    &handler?
  ) {
    my $hid;
    %!signals-sc //= do {
      my $s = Supplier.new;
      $hid = g-connect-populate-context($obj, $signal,
        -> $, $gscct, $ud {
          CATCH {
            default { $s.quit($_) }
          }

          $s.emit( [self, $gscct, $ud ] );
        },
        Pointer, 0
      );
      [ $s.Supply, $obj, $hid];
    };
    %!signals-sc{$signal}[0].tap(&handler) with &handler;
    %!signals-sc{$signal}[0];
  }

}

# GtkSourceCompletion, GtkScrollStep, gint, gpointer
sub g-connect-move(
  Pointer $app,
  Str $name,
  &handler (Pointer, uint32, gint, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }

# GtkSourceCompletion, GtkSourceCompletionContext, gpointer
sub g-connect-populate-context(
  Pointer $app,
  Str $name,
  &handler (Pointer, GtkSourceCompletionContext, Pointer),
  Pointer $data,
  uint32 $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
  { * }
