use v6.c;

unit package SourceViewGTK::Raw::Exports;

our @sourceview-exports is export;

BEGIN {
  @sourceview-exports = <
    SourceViewGTK::Raw::Definitions
    SourceViewGTK::Raw::Enums
  >;
}
