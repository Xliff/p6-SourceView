use v6.c;

use SourceViewGTK::Raw::Types;

use GLib::Value;
use GTK::TextTag;

our subset SourceTagAncestry is export
  where GtkSourceTag | GtkTextTag;

class SourceViewGTK::Tag is GTK::TextTag {
  has GtkSourceTag $!st;

  submethod BUILD (:$sourcetag) {
    given $sourcetag {
      when SourceTagAncestry {
        my $to-parent;
        $!st = do {
          when GtkSourceTag {
            $to-parent = cast(GtkTextTag, $_);
            $_;
          }

          default {
            $to-parent = $_;
            cast(GtkSourceTag, $_);
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

  multi method new (SourceTagAncestry $sourcetag) {
    $sourcetag ?? self.bless(:$sourcetag) !! Nil;
  }
  multi method new (Str() $name) {
    my $sourcetag = gtk_source_tag_new($name);

    $sourcetag ?? self.bless(:$sourcetag) !! Nil;
  }

  # Type: gboolean
  method draw-spaces is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
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
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
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
