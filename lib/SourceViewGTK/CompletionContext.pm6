use v6.c;

use Method::Also;

use SourceViewGTK::Raw::Types;
use SourceViewGTK::Raw::CompletionContext;

use GLib::Value;
use GLib::Roles::Object;
use GTK::Roles::Types;

use GTK::TextIter;

class SourceViewGTK::CompletionContext {
  also does GLib::Roles::Object;
  also does GTK::Roles::Types;

  has GtkSourceCompletionContext $!scc;

  submethod BUILD (:$context) {
    self!setObject($!scc = $context);
  }

  method SourceViewGTK::Raw::Types::GtkSourceViewCompletionContext
    is also<
      CompletionContext
      GtkSourceViewCompletionContext
    >
  { $!scc }

  method new (GtkSourceCompletionContext $context) {
    $context ?? self.bless(:$context) !! Nil;
  }

    # Type: GtkSourceCompletionActivation
  method activation is rw  {
    my GLib::Value $gv .= new( G_TYPE_UINT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('activation', $gv)
        );
        GtkSourceCompletionActivationEnum( $gv.uint );
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('activation', $gv);
      }
    );
  }

  # Type: GtkSourceCompletion
  method completion (:$raw = False) is rw  {
    my GLib::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('completion', $gv)
        );

        return Nil unless $gv.object;

        my $c = cast(GtkSourceCompletion, $gv.object)

        $raw ?? $c !! ::('SourceViewGTK::Completion').new($c)
      },
      STORE => -> $, GtkSourceCompletion() $val is copy {
        $gv.object = $val;
        self.prop_set('completion', $gv);
      }
    );
  }

  # Type: GtkTextIter
  method iter (:$raw = False) is rw  {
    my GLib::Value $gv .= new( G_TYPE_OBJECT );
    Proxy.new(
      FETCH => -> $ {
        $gv = GLib::Value.new(
          self.prop_get('iter', $gv)
        );

        return Nil unless $gv.object;

        my $i = cast(GtkTextIter, $gv.object);

        $raw ?? $i !! GTK::TextIter.new($i);
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
    die '@proposals must only contain GtkSourceCompletionItem'
      unless @proposals.all ~~ GtkSourceCompletionItem;

    samewith(
      $provider,
      GLib::GList.new(@proposals),
      $finished
    );
  }
  multi method add_proposals (
    GtkSourceCompletionProvider() $provider,
    GList() $proposals,
    Int() $finished
  ) {
    my gboolean $f = $finished.so.Int;

    gtk_source_completion_context_add_proposals(
      $!scc,
      $provider,
      $proposals,
      $f
    );
  }

  method get_activation is also<get-activation> {
    GtkSourceCompletionActivationEnum(
      gtk_source_completion_context_get_activation($!scc)
    );
  }

  proto method get_iter (|)
    is also<get-iter>
  { * }

  multi method get_iter (:$raw = False) {
    my @r = samewith($, :all, :$raw);

    @r[0] ?? @r[1] !! Nil;
  }
  # cw: There is too much ambiguity here, and possibly across the entire
  #     codebase. The original intent is for C users to be able to stick
  #     in a NON-INITIALIZED value and get something useful out. Not
  #     for them to have to self-initialze. So what's the best way to
  #     handle things if they do?
  #
  #     In that case, the best thing to do is not to fuck with it.
  #     Also, the current defaults below better serve the user.
  #     *sigh* -- It's these type of situations where you want other
  #     heads to bang against.
  multi method get_iter ($iter is rw, :$all = True, :$raw = False) {
    if (my $i = $iter) {
      my ($compatible, $coercible);
      $compatible = $i ~~ GtkTextIter;
      $coercible  = $i.^lookup('GtkTextIter');

      die '$iter must be GtkTextIter-compatible'
        unless $compatible || $coercible;

      $i .= GtkTextIter if $coercible;
    } else {
      $i = GtkTextIter.new;
    }

    my $rv = so gtk_source_completion_context_get_iter($!scc, $i);

    $i = GTK::TextIter.new($i) unless $raw;

    $iter = $i unless $iter;

    $all.not ?? $rv !! ($rv, $i);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gtk_source_completion_context_get_type,
      $n,
      $t
    );
  }

}
