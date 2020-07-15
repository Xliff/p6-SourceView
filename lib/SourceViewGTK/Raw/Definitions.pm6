use v6.c;

use GLib::Roles::Pointers;

unit package SourceViewGTK::Raw::Definitions;

# Number of times I've had to force compile the entire project
my constant forced = 23;

constant sourceview is export = 'gtksourceview-4',v0;

class GtkSourceBuffer                             is repr('CPointer') is export does GLib::Roles::Pointers { }
class GtkSourceCompletion                         is repr('CPointer') is export does GLib::Roles::Pointers { }
class GtkSourceCompletionContext                  is repr('CPointer') is export does GLib::Roles::Pointers { }
class GtkSourceCompletionInfo                     is repr('CPointer') is export does GLib::Roles::Pointers { }
class GtkSourceCompletionItem                     is repr('CPointer') is export does GLib::Roles::Pointers { }
class GtkSourceCompletionProposal                 is repr('CPointer') is export does GLib::Roles::Pointers { }
class GtkSourceCompletionProvider                 is repr('CPointer') is export does GLib::Roles::Pointers { }
class GtkSourceCompletionWords                    is repr('CPointer') is export does GLib::Roles::Pointers { }
class GtkSourceEncoding                           is repr('CPointer') is export does GLib::Roles::Pointers { }
class GtkSourceFile                               is repr('CPointer') is export does GLib::Roles::Pointers { }
class GtkSourceFileLoader                         is repr('CPointer') is export does GLib::Roles::Pointers { }
class GtkSourceFileSaver                          is repr('CPointer') is export does GLib::Roles::Pointers { }
class GtkSourceGutter                             is repr('CPointer') is export does GLib::Roles::Pointers { }
class GtkSourceGutterRenderer                     is repr('CPointer') is export does GLib::Roles::Pointers { }
class GtkSourceGutterRendererPixbuf               is repr('CPointer') is export does GLib::Roles::Pointers { }
class GtkSourceGutterRendererText                 is repr('CPointer') is export does GLib::Roles::Pointers { }
class GtkSourceLanguage                           is repr('CPointer') is export does GLib::Roles::Pointers { }
class GtkSourceLanguageManager                    is repr('CPointer') is export does GLib::Roles::Pointers { }
class GtkSourceMap                                is repr('CPointer') is export does GLib::Roles::Pointers { }
class GtkSourceMark                               is repr('CPointer') is export does GLib::Roles::Pointers { }
class GtkSourceMarkAttributes                     is repr('CPointer') is export does GLib::Roles::Pointers { }
class GtkSourcePrintCompositor                    is repr('CPointer') is export does GLib::Roles::Pointers { }
class GtkSourceRegion                             is repr('CPointer') is export does GLib::Roles::Pointers { }
class GtkSourceRegionIter                         is repr('CPointer') is export does GLib::Roles::Pointers { }
class GtkSourceSearchContext                      is repr('CPointer') is export does GLib::Roles::Pointers { }
class GtkSourceSearchSettings                     is repr('CPointer') is export does GLib::Roles::Pointers { }
class GtkSourceSpaceDrawer                        is repr('CPointer') is export does GLib::Roles::Pointers { }
class GtkSourceStyle                              is repr('CPointer') is export does GLib::Roles::Pointers { }
class GtkSourceStyleChooserWidget                 is repr('CPointer') is export does GLib::Roles::Pointers { }
class GtkSourceStyleScheme                        is repr('CPointer') is export does GLib::Roles::Pointers { }
class GtkSourceStyleSchemeChooser                 is repr('CPointer') is export does GLib::Roles::Pointers { }
class GtkSourceStyleSchemeChooserButton           is repr('CPointer') is export does GLib::Roles::Pointers { }
class GtkSourceStyleSchemeChooserWidget           is repr('CPointer') is export does GLib::Roles::Pointers { }
class GtkSourceStyleSchemeManager                 is repr('CPointer') is export does GLib::Roles::Pointers { }
class GtkSourceSyleSchemeChooserButton            is repr('CPointer') is export does GLib::Roles::Pointers { }
class GtkSourceTag                                is repr('CPointer') is export does GLib::Roles::Pointers { }
class GtkSourceUndoManager                        is repr('CPointer') is export does GLib::Roles::Pointers { }
class GtkSourceView                               is repr('CPointer') is export does GLib::Roles::Pointers { }
class GtkSourceViewCompletionContext              is repr('CPointer') is export does GLib::Roles::Pointers { }
class GtkSourceViewCompletionInfo                 is repr('CPointer') is export does GLib::Roles::Pointers { }
class GtkSourceViewLanguage                       is repr('CPointer') is export does GLib::Roles::Pointers { }
class GtkSourceViewUndoManager                    is repr('CPointer') is export does GLib::Roles::Pointers { }