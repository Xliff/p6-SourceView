use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::Value;

use GTK::Raw::Types;
use SourceViewGTK::Raw::Types;
use SourceViewGTK::Raw::CompletionWords;

use GTK::Roles::Properties;
use SourceViewGTK::Roles::CompletionProvider;

class SourceViewGTK::Completion::Words {
  also does GTK::Roles::Properties;
  also does SourceViewGTK::Roles::CompletionProvider;
  
  has GtkSourceCompletionWords $!scw;
  
  submethod BUILD (:$words) {
    # SourceViewGTK::Roles::CompletionProvider
    self!setObject(
      $!scp = nativecast(GtkSourceCompletionWords, $!scw = $words)
    );
  }
  
  method SourceViewGTK::Raw::Types::GtkSourceCompletionWords { $!scw }
  
  method new (GdkPixbuf() $icon) {
    gtk_source_completion_words_new($icon);
  }
  
  # Type: uint32 (GtkSourceCompletionActivation)
  method activation is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
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
  method icon is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
          self.prop_get('icon', $gv)
        );
        GTK::Compat::Pixbuf.new( $gv.object );
      },
      STORE => -> $, GdkPixbuf $val is copy {
        $gv.object = $val;
        self.prop_set('icon', $gv);
      }
    );
  }

  # Type: gint
  method interactive-delay is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
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
  method minimum-word-size is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
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
    my GTK::Compat::Value $gv .= new( G_TYPE_STRING );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
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
    my GTK::Compat::Value $gv .= new( G_TYPE_INT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
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
  method proposals-batch-size is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
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
  method scan-batch-size is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
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

  method get_type {
    gtk_source_completion_words_get_type();
  }

  method register (GtkTextBuffer() $buffer) {
    gtk_source_completion_words_register($!scw, $buffer);
  }

  method unregister (GtkTextBuffer() $buffer) {
    gtk_source_completion_words_unregister($!scw, $buffer);
  }

}
