use v6.c;

use Method::Also;
use NativeCall;

use SourceViewGTK::Raw::Types;
use SourceViewGTK::Raw::CompletionWords;

use GLib::Value;

use GLib::Roles::Object;
use SourceViewGTK::Roles::CompletionProvider;

class SourceViewGTK::Completion::Words {
  also does GLib::Roles::Object;
  also does SourceViewGTK::Roles::CompletionProvider;

  has GtkSourceCompletionWords $!scw is implementor;

  submethod BUILD (:$words) {
    # SourceViewGTK::Roles::CompletionProvider
    self!setObject(
      $!scp = nativecast(GtkSourceCompletionWords, $!scw = $words)
    );
  }

  method SourceViewGTK::Raw::Definitions::GtkSourceCompletionWords
    is also<GtkSourceCompletionWords>
  { $!scw }

  multi method new (GtkSourceCompletionWords $words) {
    $words ?? self.bless( :$words ) !! Nil;
  }
  multi method new (Str() $name, GdkPixbuf() $icon) {
    my $words = gtk_source_completion_words_new($name, $icon);

    $words ?? self.bless( :$words ) !! Nil;
  }

  # Type: uint32 (GtkSourceCompletionActivation)
  method activation is rw  {
    my GLib::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('activation', $gv)
        );
        GtkSourceCompletionActivation( $gv.uint );
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('activation', $gv);
      }
    );
  }

  # Type: GdkPixbuf
  method icon (:$raw = False) is rw  {
    my GLib::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('icon', $gv)
        );
        return Nil unless $gv.object;

        my $i = cast(GdkPixbuf, $gv.object);

        $raw ?? $i !! GDK::Pixbuf.new($i);
      },
      STORE => -> $, GdkPixbuf() $val is copy {
        $gv.object = $val;

        self.prop_set('icon', $gv);
      }
    );
  }

  # Type: gint
  method interactive-delay is rw  is also<interactive_delay> {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('interactive-delay', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('interactive-delay', $gv);
      }
    );
  }

  # Type: guint
  method minimum-word-size is rw  is also<minimum_word_size> {
    my GLib::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('minimum-word-size', $gv)
        );
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('minimum-word-size', $gv);
      }
    );
  }

  # Type: gchar
  method name is rw  {
    my GLib::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('name', $gv)
        );
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('name', $gv);
      }
    );
  }

  # Type: gint
  method priority is rw  {
    my GLib::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('priority', $gv)
        );
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('priority', $gv);
      }
    );
  }

  # Type: guint
  method proposals-batch-size is rw  is also<proposals_batch_size> {
    my GLib::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('proposals-batch-size', $gv)
        );
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('proposals-batch-size', $gv);
      }
    );
  }

  # Type: guint
  method scan-batch-size is rw  is also<scan_batch_size> {
    my GLib::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        $gv = GLib::Value.new(
          self.prop_get('scan-batch-size', $gv)
        );
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('scan-batch-size', $gv);
      }
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gtk_source_completion_words_get_type,
      $n,
      $t
    );
  }

  method register (GtkTextBuffer() $buffer) {
    gtk_source_completion_words_register($!scw, $buffer);
  }

  method unregister (GtkTextBuffer() $buffer) {
    gtk_source_completion_words_unregister($!scw, $buffer);
  }

}
