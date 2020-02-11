use v6.c;

use Method::Also;

use SourceViewGTK::Raw::CompletionProvider;
use SourceViewGTK::Raw::Types;

use GDK::Pixbuf;
use GTK::Widget;

role SourceViewGTK::Roles::CompletionProvider {
  has GtkSourceCompletionProvider $!scp;

  method SourceViewGTK::Raw::Definitions::GtkSourceCompletionProvider
    is also<GtkSourceCompletionProvider>
  { $!scp }

  method activate_proposal (
    GtkSourceCompletionProposal() $proposal,
    GtkTextIter() $iter
  )
    is also<activate-proposal>
  {
    so gtk_source_completion_provider_activate_proposal(
      $!scp,
      $proposal,
      $iter
    );
  }

  method get_activation is also<get-activation> {
    GtkSourceCompletionActivationEnum(
      gtk_source_completion_provider_get_activation($!scp)
    );
  }

  # method get_gicon {
  #   gtk_source_completion_provider_get_gicon($!scp);
  # }

  method get_icon (:$raw = False) is also<get-icon> {
    my $p = gtk_source_completion_provider_get_icon($!scp);

    $p ??
      ( $raw ?? $p !! GDK::Pixbuf.new($p) )
      !!
      Nil;
  }

  method get_icon_name is also<get-icon-name> {
    gtk_source_completion_provider_get_icon_name($!scp);
  }

  method get_info_widget (
    GtkSourceCompletionProposal() $proposal,
    :$raw = False,
    :$widget = False
  )
    is also<get-info-widget>
  {
    my $w = gtk_source_completion_provider_get_info_widget($!scp, $proposal);

    ReturnWidget($w, $raw, $widget);
  }

  method get_interactive_delay is also<get-interactive-delay> {
    gtk_source_completion_provider_get_interactive_delay($!scp);
  }

  method get_name is also<get-name> {
    gtk_source_completion_provider_get_name($!scp);
  }

  method get_priority is also<get-priority> {
    gtk_source_completion_provider_get_priority($!scp);
  }

  proto method get_start_iter (|)
    is also<get-start-iter>
  { * }

  multi method get_start_iter (
    GtkSourceCompletionContext() $context,
    GtkSourceCompletionProposal() $proposal,
    :$raw = False
  ) {
    my $i = GtkTextIter.new;
    samewith($context, $proposal, $i, :$raw);
  }
  multi method get_start_iter (
    GtkSourceCompletionContext() $context,
    GtkSourceCompletionProposal() $proposal,
    GtkTextIter() $iter,
    :$raw = False
  ) {
    my $rv = so gtk_source_completion_provider_get_start_iter(
      $!scp,
      $context,
      $proposal,
      $iter
    );

    $rv ??
      ( $raw ?? $iter !! GTK::TextIter.new($iter) )
      !!
      Nil
  }

  method completionprovider_get_type is also<completionprovider-get-type> {
    gtk_source_completion_provider_get_type();
  }

  method match (GtkSourceCompletionContext() $context) {
    gtk_source_completion_provider_match($!scp, $context);
  }

  method populate (GtkSourceCompletionContext() $context) {
    gtk_source_completion_provider_populate($!scp, $context);
  }

  method update_info (
    GtkSourceCompletionProposal() $proposal,
    GtkSourceCompletionInfo() $info
  )
    is also<update-info>
  {
    gtk_source_completion_provider_update_info($!scp, $proposal, $info);
  }

}
