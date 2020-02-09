use v6.c;

use NativeCall;

use SourceViewGTK::Raw::Types;

unit package SourceViewGTK::Raw::UndoManager;

sub gtk_source_undo_manager_begin_not_undoable_action (
  GtkSourceUndoManager $manager
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_undo_manager_can_redo (GtkSourceUndoManager $manager)
  returns uint32
  is native(sourceview)
  is export
  { * }

sub gtk_source_undo_manager_can_redo_changed (GtkSourceUndoManager $manager)
  is native(sourceview)
  is export
  { * }

sub gtk_source_undo_manager_can_undo (GtkSourceUndoManager $manager)
  returns uint32
  is native(sourceview)
  is export
  { * }

sub gtk_source_undo_manager_can_undo_changed (GtkSourceUndoManager $manager)
  is native(sourceview)
  is export
  { * }

sub gtk_source_undo_manager_end_not_undoable_action (
  GtkSourceUndoManager $manager
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_undo_manager_get_type ()
  returns GType
  is native(sourceview)
  is export
  { * }

sub gtk_source_undo_manager_redo (GtkSourceUndoManager $manager)
  is native(sourceview)
  is export
  { * }

sub gtk_source_undo_manager_undo (GtkSourceUndoManager $manager)
  is native(sourceview)
  is export
  { * }
