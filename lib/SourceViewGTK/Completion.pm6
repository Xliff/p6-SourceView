use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Raw::Types;
use SourceViewGTK::Raw::Types;

use SourceViewGTK::Raw::Completion;

use GTK::Roles::Properties;
use GTK::Roles::Types;
use SourceViewGTK::Roles::Signals::Completion;

use GTK::Compat::GList;
use GLib::Value;
use SourceViewGTK::CompletionContext;
use SourceViewGTK::CompletionInfo;
use SourceViewGTK::View;

class SourceViewGTK::Completion {
  also does GTK::Roles::Properties;
  also does GTK::Roles::Types;
  also does SourceViewGTK::Roles::Signals::Completion;
  
  has GtkSourceCompletion $!sc;
  
  submethod BUILD (:$completion) {
    self!setObject($!sc = $completion); 
  }
  
  method SourceViewGTK::Raw::Types::GtkSourceCompletion { $!sc }
  
  # Is originally:
  # GtkSourceCompletion, gpointer --> void
  method activate-proposal {
    self.connect($!sc, 'activate-proposal');
  }

  # Is originally:
  # GtkSourceCompletion, gpointer --> void
  method hide {
    self.connect($!sc, 'hide');
  }

  # Is originally:
  # GtkSourceCompletion, GtkScrollStep, gint, gpointer --> void
  method move-cursor {
    self.connect-move-cursor($!sc);
  }

  # Is originally:
  # GtkSourceCompletion, GtkScrollStep, gint, gpointer --> void
  method move-page {
    self.connect-move-page($!sc);
  }

  # Is originally:
  # GtkSourceCompletion, GtkSourceCompletionContext, gpointer --> void
  method populate-context {
    self.connect-populate-context($!sc);
  }

  # Is originally:
  # GtkSourceCompletion, gpointer --> void
  method show {
    self.connect($!sc, 'show');
  }
  
  # Type: guint
  method accelerators is rw  {
    my GLib::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('accelerators', $gv)
        );
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('accelerators', $gv);
      }
    );
  }

  # Type: guint
  method auto-complete-delay is rw  {
    my GLib::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('auto-complete-delay', $gv)
        );
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('auto-complete-delay', $gv);
      }
    );
  }

  # Type: guint
  method proposal-page-size is rw  {
    my GLib::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('proposal-page-size', $gv)
        );
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('proposal-page-size', $gv);
      }
    );
  }

  # Type: guint
  method provider-page-size is rw  {
    my GLib::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('provider-page-size', $gv)
        );
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('provider-page-size', $gv);
      }
    );
  }

  # Type: gboolean
  method remember-info-visibility is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('remember-info-visibility', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('remember-info-visibility', $gv);
      }
    );
  }

  # Type: gboolean
  method select-on-show is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('select-on-show', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('select-on-show', $gv);
      }
    );
  }

  # Type: gboolean
  method show-headers is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('show-headers', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('show-headers', $gv);
      }
    );
  }

  # Type: gboolean
  method show-icons is rw  {
    my GLib::Value $gv .= new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('show-icons', $gv)
        );
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('show-icons', $gv);
      }
    );
  }

  # Type: GtkSourceView
  method view is rw  {
    my GLib::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('view', $gv)
        );
        SourceViewGTK::View.new( nativecast(GtkSourceView, $gv.object) );
      },
      STORE => -> $, GtkSourceView() $val is copy {
        $gv.object = $val;
        self.prop_set('view', $gv);
      }
    );
  }
  
  method add_provider (
    GtkSourceCompletionProvider() $provider, 
    CArray[Pointer[GError]] $error
  ) {
    so gtk_source_completion_add_provider($!sc, $provider, $error);
  }

  method block_interactive {
    gtk_source_completion_block_interactive($!sc);
  }

  method create_context (GtkTextIter() $position) {
    SourceViewGTK::CompletionContext.new(
      gtk_source_completion_create_context($!sc, $position)
    );
  }

  method error_quark {
    gtk_source_completion_error_quark();
  }

  method get_info_window {
    SourceViewGTK::CompletionInfo.new( 
      gtk_source_completion_get_info_window($!sc)
    );
  }

  method get_providers {
    GTK::Compat::GList.new( gtk_source_completion_get_providers($!sc) );
  }

  method get_type {
    gtk_source_completion_get_type();
  }

  method get_view {
    SourceViewGTK::View.new( gtk_source_completion_get_view($!sc) );
  }

  # Renamed to avoid conflict with the signal 'hide'
  method hide-window {
    gtk_source_completion_hide($!sc);
  }

  method remove_provider (
    GtkSourceCompletionProvider() $provider, 
    CArray[Pointer[GError]] $error
  ) {
    so gtk_source_completion_remove_provider($!sc, $provider, $error);
  }

  method start (
    GList() $providers, 
    GtkSourceCompletionContext() $context
  ) {
    so gtk_source_completion_start($!sc, $providers, $context);
  }

  method unblock_interactive {
    gtk_source_completion_unblock_interactive($!sc);
  }

}
