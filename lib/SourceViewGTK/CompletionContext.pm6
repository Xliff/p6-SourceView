use v6.c;

use Method::Also;

use SourceViewGTK::Raw::Types;
use SourceViewGTK::Raw::CompletionContext;

use GTK::Roles::Types;

use GTK::TextIter;

class SourceViewGTK::CompletionContext {
  also does GTK::Roles::Types;
  
  has GtkSourceViewCompletionContext $!scc;
  
  submethod BUILD (:$context) {
    $!scc = $context;
  }
  
  method new (GtkSourceCompletionContext $context) {
    self.bless(:$context);
  }
  
    # Type: GtkSourceCompletionActivation
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

  # Type: GtkSourceCompletion
  method completion is rw  {
    my GTK::Compat::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
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
    my GTK::Compat::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GTK::Compat::Value.new(
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

  method add_proposals is also<add-proposals> (
    GtkSourceCompletionProvider $provider, 
    GList $proposals, 
    gboolean $finished
  ) {
    gtk_source_completion_context_add_proposals(
      $!scc, 
      $provider, 
      $proposals, 
      $finished
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
