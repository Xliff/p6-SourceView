use v6.c;

use GLib::Raw::Definitions;

unit package SourceViewGTK::Raw::Enums;

constant GtkSourceBracketMatchType is export := guint32;
our enum GtkSourceBracketMatchTypeEnum is export <
  GTK_SOURCE_BRACKET_MATCH_NONE
  GTK_SOURCE_BRACKET_MATCH_OUT_OF_RANGE
  GTK_SOURCE_BRACKET_MATCH_NOT_FOUND
  GTK_SOURCE_BRACKET_MATCH_FOUND
>;

constant GtkSourceBackgroundPatternType is export := guint32;
our enum GtkSourceBackgroundPatternTypeEnum is export <
  GTK_SOURCE_BACKGROUND_PATTERN_TYPE_NONE
  GTK_SOURCE_BACKGROUND_PATTERN_TYPE_GRID
>;

constant GtkSourceChangeCaseType is export := guint32;
our enum GtkSourceChangeCaseTypeEnum is export <
  GTK_SOURCE_CHANGE_CASE_LOWER
  GTK_SOURCE_CHANGE_CASE_UPPER
  GTK_SOURCE_CHANGE_CASE_TOGGLE
  GTK_SOURCE_CHANGE_CASE_TITLE
>;

constant GtkSourceCompletionActivation is export := guint32;
our enum GtkSourceCompletionActivationEnum is export (
  GTK_SOURCE_COMPLETION_ACTIVATION_NONE           =>  0,
  GTK_SOURCE_COMPLETION_ACTIVATION_INTERACTIVE    =>  1 +< 0,
  GTK_SOURCE_COMPLETION_ACTIVATION_USER_REQUESTED =>  1 +< 1,
);

constant GtkSourceCompletionError is export := guint32;
our enum GtkSourceCompletionErrorEnum is export (
  GTK_SOURCE_COMPLETION_ERROR_ALREADY_BOUND =>  0,
  'GTK_SOURCE_COMPLETION_ERROR_NOT_BOUND'
);

constant GtkSourceCompressionType is export := guint32;
our enum GtkSourceCompressionTypeEnum is export <
  GTK_SOURCE_COMPRESSION_TYPE_NONE
  GTK_SOURCE_COMPRESSION_TYPE_GZIP
>;

constant GtkSourceFileLoaderError is export := guint32;
our enum GtkSourceFileLoaderErrorEnum is export <
  GTK_SOURCE_FILE_LOADER_ERROR_TOO_BIG
  GTK_SOURCE_FILE_LOADER_ERROR_ENCODING_AUTO_DETECTION_FAILED
  GTK_SOURCE_FILE_LOADER_ERROR_CONVERSION_FALLBACK
>;

constant GtkSourceFileSaverError is export := guint32;
our enum GtkSourceFileSaverErrorEnum is export <
  GTK_SOURCE_FILE_SAVER_ERROR_INVALID_CHARS
  GTK_SOURCE_FILE_SAVER_ERROR_EXTERNALLY_MODIFIED
>;

constant GtkSourceFileSaverFlags is export := guint32;
our enum GtkSourceFileSaverFlagsEnum is export (
  GTK_SOURCE_FILE_SAVER_FLAGS_NONE                     =>  0,
  GTK_SOURCE_FILE_SAVER_FLAGS_IGNORE_INVALID_CHARS     =>  1 +< 0,
  GTK_SOURCE_FILE_SAVER_FLAGS_IGNORE_MODIFICATION_TIME =>  1 +< 1,
  GTK_SOURCE_FILE_SAVER_FLAGS_CREATE_BACKUP            =>  1 +< 2,
);

constant GtkSourceGutterRendererAlignmentMode is export := guint32;
our enum GtkSourceGutterRendererAlignmentModeEnum is export <
  GTK_SOURCE_GUTTER_RENDERER_ALIGNMENT_MODE_CELL
  GTK_SOURCE_GUTTER_RENDERER_ALIGNMENT_MODE_FIRST
  GTK_SOURCE_GUTTER_RENDERER_ALIGNMENT_MODE_LAST
>;

constant GtkSourceGutterRendererState is export := guint32;
our enum GtkSourceGutterRendererStateEnum is export (
  GTK_SOURCE_GUTTER_RENDERER_STATE_NORMAL   =>  0,
  GTK_SOURCE_GUTTER_RENDERER_STATE_CURSOR   =>  1 +< 0,
  GTK_SOURCE_GUTTER_RENDERER_STATE_PRELIT   =>  1 +< 1,
  GTK_SOURCE_GUTTER_RENDERER_STATE_SELECTED =>  1 +< 2
);

constant GtkSourceNewlineType is export := guint32;
our enum GtkSourceNewlineTypeEnum is export <
  GTK_SOURCE_NEWLINE_TYPE_LF
  GTK_SOURCE_NEWLINE_TYPE_CR
  GTK_SOURCE_NEWLINE_TYPE_CR_LF
>;

constant GtkSourceSortFlags is export := guint32;
our enum GtkSourceSortFlagsEnum is export (
  GTK_SOURCE_SORT_FLAGS_NONE              =>  0,
  GTK_SOURCE_SORT_FLAGS_CASE_SENSITIVE    =>  1 +< 0,
  GTK_SOURCE_SORT_FLAGS_REVERSE_ORDER     =>  1 +< 1,
  GTK_SOURCE_SORT_FLAGS_REMOVE_DUPLICATES =>  1 +< 2,
);

constant GtkSourceSmartHomeEndType is export := guint32;
our enum GtkSourceSmartHomeEndTypeEnum is export <
  GTK_SOURCE_SMART_HOME_END_DISABLED
  GTK_SOURCE_SMART_HOME_END_BEFORE
  GTK_SOURCE_SMART_HOME_END_AFTER
  GTK_SOURCE_SMART_HOME_END_ALWAYS
>;

constant GtkSourceSpaceLocationFlags is export := guint32;
our enum GtkSourceSpaceLocationFlagsEnum is export (
  GTK_SOURCE_SPACE_LOCATION_NONE          => 0,
  GTK_SOURCE_SPACE_LOCATION_LEADING       => 1,
  GTK_SOURCE_SPACE_LOCATION_INSIDE_TEXT   => 1 +< 1,
  GTK_SOURCE_SPACE_LOCATION_TRAILING      => 1 +< 2,
  GTK_SOURCE_SPACE_LOCATION_ALL           => 0x7
);

constant GtkSourceSpaceTypeFlags is export := guint32;
our enum GtkSourceSpaceTypeFlagsEnum is export (
  GTK_SOURCE_SPACE_TYPE_NONE      => 0,
  GTK_SOURCE_SPACE_TYPE_SPACE     => 1,
  GTK_SOURCE_SPACE_TYPE_TAB       => 1 +< 1,
  GTK_SOURCE_SPACE_TYPE_NEWLINE   => 1 +< 2,
  GTK_SOURCE_SPACE_TYPE_NBSP      => 1 +< 3,
  GTK_SOURCE_SPACE_TYPE_ALL       => 0xf
);

constant GtkSourceViewGutterPosition is export := gint32;
our enum GtkSourceViewGutterPositionEnum is export (
    GTK_SOURCE_VIEW_GUTTER_POSITION_LINES =>  -30,
    GTK_SOURCE_VIEW_GUTTER_POSITION_MARKS =>  -20,
);
