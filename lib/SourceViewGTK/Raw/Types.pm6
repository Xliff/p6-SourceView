use v6.c;

use GTK::Compat::Types;

use GTK::Roles::Pointers;

unit package SourceViewGTK::Raw::Types;

# Number of times I've had to force compile the entire project
our constant forced = 0;

constant sourceview is export = 'gtksourceview-4',v0;

class GtkSourceBuffer                             is repr('CPointer') is export does GTK::Roles::Pointers { }
class GtkSourceCompletion                         is repr('CPointer') is export does GTK::Roles::Pointers { }
class GtkSourceCompletionContext                  is repr('CPointer') is export does GTK::Roles::Pointers { }
class GtkSourceCompletionInfo                     is repr('CPointer') is export does GTK::Roles::Pointers { }
class GtkSourceCompletionItem                     is repr("CPointer") is export does GTK::Roles::Pointers { }
class GtkSourceCompletionProposal                 is repr("CPointer") is export does GTK::Roles::Pointers { }
class GtkSourceCompletionProvider                 is repr('CPointer') is export does GTK::Roles::Pointers { }
class GtkSourceCompletionWords                    is repr("CPointer") is export does GTK::Roles::Pointers { }
class GtkSourceEncoding                           is repr("CPointer") is export does GTK::Roles::Pointers { }
class GtkSourceFile                               is repr("CPointer") is export does GTK::Roles::Pointers { }
class GtkSourceFileLoader                         is repr("CPointer") is export does GTK::Roles::Pointers { }
class GtkSourceGutter                             is repr('CPointer') is export does GTK::Roles::Pointers { }
class GtkSourceLanguage                           is repr('CPointer') is export does GTK::Roles::Pointers { }
class GtkSourceLanguageManager                    is repr('CPointer') is export does GTK::Roles::Pointers { }
class GtkSourceMark                               is repr('CPointer') is export does GTK::Roles::Pointers { }
class GtkSourceMarkAttributes                     is repr('CPointer') is export does GTK::Roles::Pointers { }
class GtkSourceSpaceDrawer                        is repr('CPointer') is export does GTK::Roles::Pointers { }
class GtkSourceStyle                              is repr('CPointer') is export does GTK::Roles::Pointers { }
class GtkSourceStyleChooserWidget                 is repr('CPointer') is export does GTK::Roles::Pointers { }
class GtkSourceStyleScheme                        is repr('CPointer') is export does GTK::Roles::Pointers { }
class GtkSourceStyleSchemeChooser                 is repr('CPointer') is export does GTK::Roles::Pointers { }
class GtkSourceStyleSchemeChooserButton           is repr('CPointer') is export does GTK::Roles::Pointers { }
class GtkSourceStyleSchemeChooserWidget           is repr("CPointer") is export does GTK::Roles::Pointers { }
class GtkSourceStyleSchemeManager                 is repr('CPointer') is export does GTK::Roles::Pointers { }
class GtkSourceSyleSchemeChooserButton            is repr('CPointer') is export does GTK::Roles::Pointers { }
class GtkSourceUndoManager                        is repr('CPointer') is export does GTK::Roles::Pointers { }
class GtkSourceView                               is repr('CPointer') is export does GTK::Roles::Pointers { }
class GtkSourceViewCompletionContext              is repr("CPointer") is export does GTK::Roles::Pointers { }
class GtkSourceViewCompletionInfo                 is repr("CPointer") is export does GTK::Roles::Pointers { }
class GtkSourceViewLanguage                       is repr("CPointer") is export does GTK::Roles::Pointers { }
class GtkSourceViewUndoManager                    is repr("CPointer") is export does GTK::Roles::Pointers { }

our enum GtkSourceFileLoaderError is export <
  GTK_SOURCE_FILE_LOADER_ERROR_TOO_BIG 
  GTK_SOURCE_FILE_LOADER_ERROR_ENCODING_AUTO_DETECTION_FAILED 
  GTK_SOURCE_FILE_LOADER_ERROR_CONVERSION_FALLBACK 
>;

our enum GtkSourceCompressionType is export <
  GTK_SOURCE_COMPRESSION_TYPE_NONE 
  GTK_SOURCE_COMPRESSION_TYPE_GZIP 
>;

our enum GtkSourceFileSaverFlags is export (
  GTK_SOURCE_FILE_SAVER_FLAGS_NONE                     =>  0,
  GTK_SOURCE_FILE_SAVER_FLAGS_IGNORE_INVALID_CHARS     =>  1 +< 0,
  GTK_SOURCE_FILE_SAVER_FLAGS_IGNORE_MODIFICATION_TIME =>  1 +< 1,
  GTK_SOURCE_FILE_SAVER_FLAGS_CREATE_BACKUP            =>  1 +< 2,
);

our enum GtkSourceBracketMatchType is export <
  GTK_SOURCE_BRACKET_MATCH_NONE 
  GTK_SOURCE_BRACKET_MATCH_OUT_OF_RANGE 
  GTK_SOURCE_BRACKET_MATCH_NOT_FOUND 
  GTK_SOURCE_BRACKET_MATCH_FOUND 
>;

our enum GtkSourceFileSaverError is export <
  GTK_SOURCE_FILE_SAVER_ERROR_INVALID_CHARS 
  GTK_SOURCE_FILE_SAVER_ERROR_EXTERNALLY_MODIFIED 
>;

our enum GtkSourceSortFlags is export (
  GTK_SOURCE_SORT_FLAGS_NONE              =>  0,
  GTK_SOURCE_SORT_FLAGS_CASE_SENSITIVE    =>  1 +< 0,
  GTK_SOURCE_SORT_FLAGS_REVERSE_ORDER     =>  1 +< 1,
  GTK_SOURCE_SORT_FLAGS_REMOVE_DUPLICATES =>  1 +< 2,
);

our enum GtkSourceGutterRendererState is export (
  GTK_SOURCE_GUTTER_RENDERER_STATE_NORMAL   =>  0,
  GTK_SOURCE_GUTTER_RENDERER_STATE_CURSOR   =>  1 +< 0,
  GTK_SOURCE_GUTTER_RENDERER_STATE_PRELIT   =>  1 +< 1,
  GTK_SOURCE_GUTTER_RENDERER_STATE_SELECTED =>  1 +< 2
);

our enum GtkSourceChangeCaseType is export <
  GTK_SOURCE_CHANGE_CASE_LOWER 
  GTK_SOURCE_CHANGE_CASE_UPPER 
  GTK_SOURCE_CHANGE_CASE_TOGGLE 
  GTK_SOURCE_CHANGE_CASE_TITLE 
>;

our enum GtkSourceNewlineType is export <
  GTK_SOURCE_NEWLINE_TYPE_LF 
  GTK_SOURCE_NEWLINE_TYPE_CR 
  GTK_SOURCE_NEWLINE_TYPE_CR_LF 
>;

our enum GtkSourceSmartHomeEndType is export <
  GTK_SOURCE_SMART_HOME_END_DISABLED 
  GTK_SOURCE_SMART_HOME_END_BEFORE 
  GTK_SOURCE_SMART_HOME_END_AFTER 
  GTK_SOURCE_SMART_HOME_END_ALWAYS 
>;

our enum GtkSourceGutterRendererAlignmentMode is export <
  GTK_SOURCE_GUTTER_RENDERER_ALIGNMENT_MODE_CELL 
  GTK_SOURCE_GUTTER_RENDERER_ALIGNMENT_MODE_FIRST 
  GTK_SOURCE_GUTTER_RENDERER_ALIGNMENT_MODE_LAST 
>;

our enum GtkSourceCompletionError is export (
  GTK_SOURCE_COMPLETION_ERROR_ALREADY_BOUND =>  0,
  'GTK_SOURCE_COMPLETION_ERROR_NOT_BOUND'
);

our enum GtkSourceCompletionActivation is export (
  GTK_SOURCE_COMPLETION_ACTIVATION_NONE           =>  0,
  GTK_SOURCE_COMPLETION_ACTIVATION_INTERACTIVE    =>  1 +< 0,
  GTK_SOURCE_COMPLETION_ACTIVATION_USER_REQUESTED =>  1 +< 1,
);

our enum GtkSourceBackgroundPatternType is export <
  GTK_SOURCE_BACKGROUND_PATTERN_TYPE_NONE 
  GTK_SOURCE_BACKGROUND_PATTERN_TYPE_GRID 
>;
