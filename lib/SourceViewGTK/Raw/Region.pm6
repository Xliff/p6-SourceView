use v6.c;

use NativeCall;


use GTK::Raw::Types;
use SourceViewGTK::Raw::Types;

unit package SourceViewGTK::Raw::Region;

sub gtk_source_region_add_region (
  GtkSourceRegion $region, 
  GtkSourceRegion $region_to_add
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_region_add_subregion (
  GtkSourceRegion $region, 
  GtkTextIter $start, 
  GtkTextIter $end
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_region_get_bounds (
  GtkSourceRegion $region, 
  GtkTextIter $start, 
  GtkTextIter $end
)
  returns uint32
  is native(sourceview)
  is export
  { * }

sub gtk_source_region_get_buffer (GtkSourceRegion $region)
  returns GtkTextBuffer
  is native(sourceview)
  is export
  { * }

sub gtk_source_region_get_start_region_iter (
  GtkSourceRegion $region, 
  GtkSourceRegionIter $iter
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_region_intersect_region (
  GtkSourceRegion $region1, 
  GtkSourceRegion $region2
)
  returns GtkSourceRegion
  is native(sourceview)
  is export
  { * }

sub gtk_source_region_intersect_subregion (
  GtkSourceRegion $region, 
  GtkTextIter $start, 
  GtkTextIter $end
)
  returns GtkSourceRegion
  is native(sourceview)
  is export
  { * }

sub gtk_source_region_is_empty (GtkSourceRegion $region)
  returns uint32
  is native(sourceview)
  is export
  { * }

sub gtk_source_region_iter_get_subregion (
  GtkSourceRegionIter $iter, 
  GtkTextIter $start, 
  GtkTextIter $end
)
  returns uint32
  is native(sourceview)
  is export
  { * }

sub gtk_source_region_iter_is_end (GtkSourceRegionIter $iter)
  returns uint32
  is native(sourceview)
  is export
  { * }

sub gtk_source_region_iter_next (GtkSourceRegionIter $iter)
  returns uint32
  is native(sourceview)
  is export
  { * }

sub gtk_source_region_new (GtkTextBuffer $buffer)
  returns GtkSourceRegion
  is native(sourceview)
  is export
  { * }

sub gtk_source_region_subtract_region (
  GtkSourceRegion $region, 
  GtkSourceRegion $region_to_subtract
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_region_subtract_subregion (
  GtkSourceRegion $region, 
  GtkTextIter $start, 
  GtkTextIter $end
)
  is native(sourceview)
  is export
  { * }

sub gtk_source_region_to_string (GtkSourceRegion $region)
  returns Str
  is native(sourceview)
  is export
  { * }
