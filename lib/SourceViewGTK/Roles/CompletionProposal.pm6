use v6.c;

use Method::Also;

use SourceViewGTK::Raw::Types;
use SourceViewGTK::Raw::CompletionProposal;

use GDK::Pixbuf;

use GLib::Roles::Signals::Generic;

role SourceViewGTK::Roles::CompletionProposal {
  also does GLib::Roles::Signals::Generic;

  has GtkSourceCompletionProposal $!scp;

  method SourceViewGTK::Raw::Definitions::GtkSourceCompletionProposal
    is also<GtkSourceCompletionProvider>
  { $!scp }


  # Is originally:
  # GtkSourceCompletionProposal, gpointer --> void
  method changed {
    self.connect($!scp, 'changed');
  }

  method emit-changed is also<emit_changed> {
    gtk_source_completion_proposal_changed($!scp);
  }

  method equal (GtkSourceCompletionProposal() $other) {
    so gtk_source_completion_proposal_equal($!scp, $other);
  }

  # method get_gicon {
  #   gtk_source_completion_proposal_get_gicon($!scp);
  # }

  method get_icon (:$raw = False) is also<get-icon> {
    my $p = gtk_source_completion_proposal_get_icon($!scp);

    $p ??
      ( $raw ?? $p !! GDK::Pixbuf.new($p) )
      !!
      Nil;
  }

  method get_icon_name is also<get-icon-name> {
    gtk_source_completion_proposal_get_icon_name($!scp);
  }

  method get_info is also<get-info> {
    gtk_source_completion_proposal_get_info($!scp)
  }

  method get_label is also<get-label> {
    gtk_source_completion_proposal_get_label($!scp);
  }

  method get_markup is also<get-markup> {
    gtk_source_completion_proposal_get_markup($!scp);
  }

  method get_text is also<get-text> {
    gtk_source_completion_proposal_get_text($!scp);
  }

  method completionproposal_get_type is also<completionproposal-get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gtk_source_completion_proposal_get_type,
      $n,
      $t
    );
  }

  method hash {
    gtk_source_completion_proposal_hash($!scp);
  }

}
