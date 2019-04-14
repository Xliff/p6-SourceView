use v6.c;

use Method::Also;
use NativeCall;

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
            $to-parent = nativecast(GtkSourceView, $_);
            $_;
          }
          default {
            $to-parent = $_;
            nativecast(GtkSourceMap, $_);
          }
        }
        self.setSourceView($to-parent);
      }
    }
  }
  
  multi method new (SourceMapAncestry $map) {
    my $o = self.bless(:$map);
    $o.upref;
    $o;
  }
  multi method new {
    self.bless( map => gtk_source_map_new() );
  }
  
  method view is rw {
    Proxy.new(
      FETCH => sub ($) {
        SourceViewGTK::View.new( gtk_source_map_get_view($!sm) );
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


            
            
