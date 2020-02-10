use v6.c;

use Method::Also;

use NativeCall;

use SourceViewGTK::Raw::Types;
use SourceViewGTK::Raw::Completion;

use GLib::GList;
use GLib::Value;
use SourceViewGTK::CompletionContext;
use SourceViewGTK::CompletionInfo;
use SourceViewGTK::View;

use GLib::Roles::Object;
use SourceViewGTK::Roles::Signals::Completion;

class SourceViewGTK::Completion {
  also does GLib::Roles::Object;
  also does SourceViewGTK::Roles::Signals::Completion;

  has GtkSourceCompletion $!sc;

  submethod BUILD (:$completion) {
    self!setObject($!sc = $completion);
  }

  method SourceViewGTK::Raw::Types::GtkSourceCompletion
    is also<GtkSourceCompletion>
  { $!sc }

  # Is originally:
  # GtkSourceCompletion, gpointer --> void
  method activate-proposal is also<activate_proposal> {
    self.connect($!sc, 'activate-proposal');
  }

  # Is originally:
  # GtkSourceCompletion, gpointer --> void
  method hide {
    self.connect($!sc, 'hide');
  }

  # Is originally:
  # GtkSourceCompletion, GtkScrollStep, gint, gpointer --> void
  method move-cursor is also<move_cursor> {
    self.connect-move-cursor($!sc);
  }

  # Is originally:
  # GtkSourceCompletion, GtkScrollStep, gint, gpointer --> void
  method move-page is also<move_page> {
    self.connect-move-page($!sc);
  }

  # Is originally:
  # GtkSourceCompletion, GtkSourceCompletionContext, gpointer --> void
  method populate-context is also<populate_context> {
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
  method auto-complete-delay is rw  is also<auto_complete_delay> {
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
  method proposal-page-size is rw  is also<proposal_page_size> {
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
  method provider-page-size is rw  is also<provider_page_size> {
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
  method remember-info-visibility is rw  is also<remember_info_visibility> {
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
  method select-on-show is rw  is also<select_on_show> {
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
  method show-headers is rw  is also<show_headers> {
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
  method show-icons is rw  is also<show_icons> {
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
    CArray[Pointer[GError]] $error = gerror
  )
    is also<add-provider>
  {
    clear_error;
    my $rv = so gtk_source_completion_add_provider($!sc, $provider, $error);
    set_error($error);
    $rv;s
  }

  method block_interactive is also<block-interactive> {
    gtk_source_completion_block_interactive($!sc);
  }

  method create_context (GtkTextIter() $position, :$raw = False)
    is also<create-context>
  {
    my $cc = gtk_source_completion_create_context($!sc, $position);

    $cc ??
      ( $raw ?? $cc !! SourceViewGTK::CompletionContext.new($cc) )
      !!
      Nil;
  }

  method error_quark is also<error-quark> {
    gtk_source_completion_error_quark();
  }

  method get_info_window (:$raw = False) is also<get-info-window> {
    my $ci = gtk_source_completion_get_info_window($!sc);

    $ci ??
      ( $raw ?? $ci !! SourceViewGTK::CompletionInfo.new($ci) )
      !!
      Nil;
  }

  method get_providers (:$glist = False, :$raw = False)
    is also<get-providers>
  {
    my $pl = gtk_source_completion_get_providers($!sc);

    return Nil unless $pl;
    return $pl if $glist;

    $pl = GLib::GList.new($pl) but
      GLib::Roles::ListData[GtkSourceCompletionProvider];

    constant C = SourceViewGTK::Roles::CompletionProvider;
    $raw ?? $pl.Array !! $pl.Array.map({ C.new-completionprovider-obj($_) });
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_source_completion_get_type, $n, $t );
  }

  method get_view (:$raw = False) is also<get-view> {
    my $v = gtk_source_completion_get_view($!sc);

    $v ??
      ( $raw ?? $v !! SourceViewGTK::View.new($v) )
      !!
      Nil;
  }

  # Renamed to avoid conflict with the signal 'hide'
  method hide-window is also<hide_window> {
    gtk_source_completion_hide($!sc);
  }

  method remove_provider (
    GtkSourceCompletionProvider() $provider,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<remove-provider>
  {
    clear_error;
    my $rv = so gtk_source_completion_remove_provider($!sc, $provider, $error);
    set_error($error);
    $rv;
  }

  multi method start (@providers, $context) {
    samewith( GLib::GList.new(@providers), $context );
  }
  multi method start (
    $providers is copy,
    GtkSourceCompletionContext() $context
  ) {
    my $compatible = $providers ~~ GList;
    my $coercible  = $providers.^lookup('GList');

    die '$providers must be GList-compatible!'
      unless $compatible || $coercible;

    $providers .= GList if $coercible;

    so gtk_source_completion_start($!sc, $providers, $context);
  }

  method unblock_interactive is also<unblock-interactive> {
    gtk_source_completion_unblock_interactive($!sc);
  }

}
