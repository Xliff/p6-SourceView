use v6.c;

use GTK::Compat::Types;
use GTK::Raw::Types;
use SourceViewGTK::Raw::CompletionProvider;
use SourceViewGTK::Raw::Types;

role SourceViewGTK::Roles::CompletionProvider {
  has GtkSourceCompletionProvider $!scp;
  
  method SourceViewGTK::Raw::TYpes::GtkSourceCompletionProvider { $!scp }
  
  method activate_proposal (
    GtkSourceCompletionProposal() $proposal, 
    GtkTextIter() $iter
  ) {
    gtk_source_completion_provider_activate_proposal(
      $!scp, 
      $proposal, 
      $iter
    );
  }

  method get_activation {
    gtk_source_completion_provider_get_activation($!scp);
  }
  
  # method get_gicon {
  #   gtk_source_completion_provider_get_gicon($!scp);
  # }

  method get_icon {
    gtk_source_completion_provider_get_icon($!scp);
  }

  method get_icon_name {
    gtk_source_completion_provider_get_icon_name($!scp);
  }

  method get_info_widget (GtkSourceCompletionProposal() $proposal) {
    gtk_source_completion_provider_get_info_widget($!scp, $proposal);
  }

  method get_interactive_delay {
    gtk_source_completion_provider_get_interactive_delay($!scp);
  }

  method get_name {
    gtk_source_completion_provider_get_name($!scp);
  }

  method get_priority {
    gtk_source_completion_provider_get_priority($!scp);
  }

  method get_start_iter (
    GtkSourceCompletionContext() $context, 
    GtkSourceCompletionProposal() $proposal, 
    GtkTextIter() $iter
  ) {
    gtk_source_completion_provider_get_start_iter(
      $!scp, 
      $context, 
      $proposal, 
      $iter
    );
  }

  method get_type {
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
  ) {
    gtk_source_completion_provider_update_info($!scp, $proposal, $info);
  }
  
}
