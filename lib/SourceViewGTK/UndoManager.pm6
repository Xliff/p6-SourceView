use v6.c;

use SourceViewGTK::Raw::Types;
use SourceViewGTK::Raw::UndoManager;

use GTK::Roles::Signals::Generic;

class SourceViewGTK::UndoManager {
  also does GTK::Roles::Signals::Generic;
  
  has GtkSourceUndoManager $!sum;
  
  submethod BUILD (:$manager) {
    $!sum = $manager;
  }
  
  multi method new (GtkSourceUndoManager $manager) {
    self.bless(:$manager);
  }
  multi method new {
    die qq:to/DIE/.chomp;
      SourceViewGTK::UndoManager.new must take a GtkSourceUndoManager object{
      } as its only parameter.
      DIE
  }
  
  # Is originally:
  # GtkSourceUndoManager, gpointer --> void
  method can-redo-changed {
    self.connect($!sum, 'can-redo-changed');
  }

  # Is originally:
  # GtkSourceUndoManager, gpointer --> void
  method can-undo-changed {
    self.connect($!sum, 'can-undo-changed');
  }
  
  method begin_not_undoable_action {
    gtk_source_undo_manager_begin_not_undoable_action($!sum);
  }

  method can_redo {
    so gtk_source_undo_manager_can_redo($!sum);
  }

  method can_redo_changed {
    so gtk_source_undo_manager_can_redo_changed($!sum);
  }

  method can_undo {
    gtk_source_undo_manager_can_undo($!sum);
  }

  method can_undo_changed {
    gtk_source_undo_manager_can_undo_changed($!sum);
  }

  method end_not_undoable_action {
    gtk_source_undo_manager_end_not_undoable_action($!sum);
  }

  method get_type {
    gtk_source_undo_manager_get_type();
  }

  method redo {
    gtk_source_undo_manager_redo($!sum);
  }

  method undo {
    gtk_source_undo_manager_undo($!sum);
  }

}
