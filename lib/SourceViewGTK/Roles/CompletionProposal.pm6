use v6.c;

use GTK::Compat::Types;
use SourceViewGTK::Raw::CompletionProposal;

use GTK::Compat::Pixbuf:

role SourceViewGTK::Roles::CompletionProposal {
  has GtkSourceCompletionProposal $!scp;
  
  method emit-changed {
    gtk_source_completion_proposal_changed($!scp);
  }

  method equal (GtkSourceCompletionProposal() $other) {
    gtk_source_completion_proposal_equal($!scp, $other);
  }

  # method get_gicon {
  #   gtk_source_completion_proposal_get_gicon($!scp);
  # }

  method get_icon {
    GTK::Compat::Pixbuf.new( 
      gtk_source_completion_proposal_get_icon($!scp)
    );
  }

  method get_icon_name {
    gtk_source_completion_proposal_get_icon_name($!scp);
  }

  method get_info {
    gtk_source_completion_proposal_get_info($!scp)
  }

  method get_label {
    gtk_source_completion_proposal_get_label($!scp);
  }

  method get_markup {
    gtk_source_completion_proposal_get_markup($!scp);
  }

  method get_text {
    gtk_source_completion_proposal_get_text($!scp);
  }

  method get_type {
    gtk_source_completion_proposal_get_type();
  }

  method hash {
    gtk_source_completion_proposal_hash($!scp);
  }

}
