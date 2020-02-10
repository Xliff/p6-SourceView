use v6.c;

use Method::Also;

use SourceViewGTK::Raw::Types;
use SourceViewGTK::Raw::Map;

use SourceViewGTK::View;

our subset SourceMapAncestry is export
  where GtkSourceMap | SourceViewAncestry;

class SourceViewGTK::Map is SourceViewGTK::View {
  has GtkSourceMap $!sm;

  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType(self.^name);
    $o;
  }

  submethod BUILD (:$map) {
    given $map {
      when SourceMapAncestry {
        my $to-parent;
        $!sm = do {
          when GtkSourceMap {
            $to-parent = cast(GtkSourceView, $_);
            $_;
          }
          default {
            $to-parent = $_;
            cast(GtkSourceMap, $_);
          }
        }
        self.setSourceView($to-parent);
      }
    }
  }

  multi method new (SourceMapAncestry $map, :$ref = True) {
    my $o = self.bless(:$map);
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $map = gtk_source_map_new();

    $map ?? self.bless($map) !! Nil;
  }

  method view (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $v = gtk_source_map_get_view($!sm);

        $v ??
          ( $raw ?? $v !! SourceViewGTK::View.new($v) )
          !!
          Nil;
      },
      STORE => sub ($, GtkSourceView() $view is copy) {
        gtk_source_map_set_view($!sm, $view);
      }
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    GTK::Widget.unstable_get_type( &gtk_source_map_get_type, $n, $t );
  }

}
