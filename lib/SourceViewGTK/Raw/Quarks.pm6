use v6.c;

use NativeCall;

use SourceViewGTK::Raw::Completion;
use SourceViewGTK::Raw::FileLoader;
use SourceViewGTK::Raw::FileSaver;

unit package SourceViewGTK::Raw::Quarks;

our $GTK_SOURCE_FILE_LOADER_ERROR is export;
our $GTK_SOURCE_FILE_SAVER_ERROR is export;
our $GTK_SOUCE_COMPLETION_ERROR is export;

BEGIN {
  $GTK_SOUCE_COMPLETION_ERROR   = gtk_source_completion_error_quark();
  $GTK_SOURCE_FILE_LOADER_ERROR = gtk_source_file_loader_error_quark();
  $GTK_SOURCE_FILE_SAVER_ERROR  = gtk_source_file_saver_error_quark();
}
