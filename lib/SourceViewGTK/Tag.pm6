use v6.c;

use NativeCall;

use GTK::Compat::Value;

use GTK::Compat::Types;
use GTK::Raw::Types;
use SourceViewGTK::Raw::Types;

use GTK::TextTag;

our subset SourceTagAncestry is export
  where GtkSourceTag | GtkTextTag;

class SourceViewGTK::Tag is GTK::TextTag {
  has GtkSourceTag $!st;
  
  submethod BUILD (:$tag) {
    given $tag {
      when SourceTagAncestry {
        my $to-parent;
        $!st = do {
          when GtkSourceTag {
            $to-parent = nativecast(GtkTextTag, $_);
            $_;
          }
          default {
            $to-parent = $_;
            nativecast(GtkSourceTag, $_);
          }
        }
        self.setTextTag($to-parent);
      }
      when SourceViewGTK::Tag {
      }
      default {
      }
    }
  }
  
  method new (Str() $name) {
    self.bless( tag => gtk_source_tag_new($name) );
  }
  
  # Type: gboolean
  method draw-spaces is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('draw-spaces', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('draw-spaces', $gv);
      }
    );
  }

  # Type: gboolean
  method draw-spaces-set is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('draw-spaces-set', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('draw-spaces-set', $gv);
      }
    );
  }
    
}

sub gtk_source_tag_new (Str $name)
  returns GtkSourceTag
  is native(sourceview)
  is export
  { * }
