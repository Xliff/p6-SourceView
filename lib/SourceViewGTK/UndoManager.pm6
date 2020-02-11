use v6.c;

use Method::Also;

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
    $manager ?? self.bless(:$manager) !! Nil;
  }
  multi method new {
    die qq:to/DIE/.chomp;
      SourceViewGTK::UndoManager.new must take a GtkSourceUndoManager object{
      } as its only parameter.
      DIE
  }

  # Is originally:
  # GtkSourceUndoManager, gpointer --> void
  method can-redo-changed is also<can_redo_changed> {
    self.connect($!sum, 'can-redo-changed');
  }

  # Is originally:
  # GtkSourceUndoManager, gpointer --> void
  method can-undo-changed is also<can_undo_changed> {
    self.connect($!sum, 'can-undo-changed');
  }

  method begin_not_undoable_action is also<begin-not-undoable-action> {
    gtk_source_undo_manager_begin_not_undoable_action($!sum);
  }

  method can_redo is also<can-redo> {
    so gtk_source_undo_manager_can_redo($!sum);
  }

  method emit_can_redo_changed is also<emit-can-redo-changed> {
    gtk_source_undo_manager_can_redo_changed($!sum);
  }

  method can_undo is also<can-undo> {
    so gtk_source_undo_manager_can_undo($!sum);
  }

  method emit_can_undo_changed is also<emit-can-undo-changed> {
    gtk_source_undo_manager_can_undo_changed($!sum);
  }

  method end_not_undoable_action is also<end-not-undoable-action> {
    gtk_source_undo_manager_end_not_undoable_action($!sum);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gtk_source_undo_manager_get_type, $n, $t );
  }

  method redo {
    gtk_source_undo_manager_redo($!sum);
  }

  method undo {
    gtk_source_undo_manager_undo($!sum);
  }

}
