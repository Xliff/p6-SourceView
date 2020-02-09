use v6.c;

use Method::Also;
use NativeCall;



use GTK::Raw::Types;
use SourceViewGTK::Raw::Types;
use SourceViewGTK::Raw::CompletionContext;

use GLib::Value;
use GTK::Roles::Properties;
use GTK::Roles::Types;

use GTK::TextIter;

class SourceViewGTK::CompletionContext {
  also does GTK::Roles::Properties;
  also does GTK::Roles::Types;

  has GtkSourceCompletionContext $!scc;

  submethod BUILD (:$context) {
    self!setObject($!scc = $context);
  }

  method SourceViewGTK::Raw::Types::GtkSourceViewCompletionContext
    #is also<CompletionContext>
    { $!scc }

  method new (GtkSourceCompletionContext $context) {
    self.bless(:$context);
  }

    # Type: GtkSourceCompletionActivation
  method activation is rw  {
    my GLib::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => -> $ {
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

  # Type: GtkSourceCompletion
  method completion is rw  {
    my GLib::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('completion', $gv)
        );
        ::('SourceViewGTK::Completion').new(
          nativecast(GtkSourceCompletion, $gv.object)
        )
      },
      STORE => -> $, GtkSourceCompletion() $val is copy {
        $gv.object = $val;
        self.prop_set('completion', $gv);
      }
    );
  }

  # Type: GtkTextIter
  method iter is rw  {
    my GLib::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('iter', $gv)
        );
        GTK::TextIter.new( nativecast(GtkTextIter, $gv.object) );
      },
      STORE => -> $, GtkTextIter() $val is copy {
        $gv.object = $val;
        self.prop_set('iter', $gv);
      }
    );
  }

  proto method add_proposals (|)
    is also<add-proposals>
    { * }

  multi method add_proposals (
    GtkSourceCompletionProvider() $provider,
    @proposals,
    Int() $finished
  ) {
    # List of GtkSourceCompletionItem
    my $proposals = GLib::GList.new(@proposals);
    samewith(
      $provider,
      $proposals,
      $finished
    );
  }
  multi method add_proposals (
    GtkSourceCompletionProvider() $provider,
    GList() $proposals,
    Int() $finished
  ) {
    my gboolean $f = self.RESOLVE-BOOL($finished);
    gtk_source_completion_context_add_proposals(
      $!scc,
      $provider,
      $proposals,
      $f
    );
  }

  method get_activation is also<get-activation> {
    GtkSourceCompletionActivation(
      gtk_source_completion_context_get_activation($!scc)
    );
  }

  proto method get_iter (|)
     is also<get-iter>
     { * }

  multi method get_iter {
    my $iter = GtkTextIter.new;
    my $rc = samewith($iter);
    ($iter, $rc);
  }
  multi method get_iter (GtkTextIter() $iter) {
    so gtk_source_completion_context_get_iter($!scc, $iter);
  }

  method get_type is also<get-type> {
    gtk_source_completion_context_get_type();
  }

}
