use v6.c;

use NativeCall;

use GTK::Raw::Types;
use SourceViewGTK::Raw::Types;

use SourceViewGTK::Raw::Region;

use GTK::TextBuffer;

class SourceViewGTK::RegionIter { ... }

class SourceViewGTK::Region {
  has GtkSourceRegion $!sr;
  
  submethod BUILD (:$region) {
    $!sr = $region;
  }
  
  method SourceViewGTK::Raw::Types::GtkSourceRegion
    #is also<Region>
    { $!sr }
  
  method new (GtkTextBuffer() $buffer) {
    self.bless( region => gtk_source_region_new($buffer) );
  }
  
  method add_region (GtkSourceRegion() $region_to_add) {
    gtk_source_region_add_region($!sr, $region_to_add);
  }

  method add_subregion (GtkTextIter() $start, GtkTextIter() $end) {
    gtk_source_region_add_subregion($!sr, $_start, $_end);
  }

  multi method get_bounds {
    my ($start, $end) = GtkTextIter.new xx 2;
    samewith($start, $end);
  }
  multi method get_bounds (GtkTextIter() $start, GtkTextIter() $end) {
    so gtk_source_region_get_bounds($!sr, $start, $end);
  }

  method get_buffer {
    GTK::TextBuffer.new( gtk_source_region_get_buffer($!sr) );
  }

  method get_start_region_iter (GtkSourceRegionIter() $iter) {
    SourceViewGTK::RegionIter.new(
      gtk_source_region_get_start_region_iter($!sr, $iter)
    );
  }

  method intersect_region (GtkSourceRegion() $region2) {
    SourceViewGTK::Region.new(
      gtk_source_region_intersect_region($!sr, $region2)
    );
  }

  method intersect_subregion (GtkTextIter() $start, GtkTextIter() $end) {
    SourceViewGTK::Region.new(
      gtk_source_region_intersect_subregion($!sr, $_start, $_end)
    );
  }

  method is_empty {
    so gtk_source_region_is_empty($!sr);
  }

  method subtract_region (GtkSourceRegion() $region_to_subtract) {
    gtk_source_region_subtract_region($!sr, $region_to_subtract);
  }

  method subtract_subregion (GtkTextIter() $start, GtkTextIter() $end) {
    gtk_source_region_subtract_subregion($!sr, $_start, $_end);
  }

  method to_string {
    gtk_source_region_to_string($!sr);
  }

}

class SourceViewGTK::RegionIter { 
  has GtkSourceRegionIter $!sri;
  
  submethod BUILD (:$iter) {
    $!sri = $iter;
  }
  
  method SourceViewGTK::Raw::Types::GtkSourceRegionIter 
    #is also<RegionIter>
    { $!sri }
  
  method new (GtkSourceRegionIter $iter) {
    self.bless(:$iter);
    
  method get_subregion (GtkTextIter() $start, GtkTextIter() $end) {
    so gtk_source_region_iter_get_subregion($!sr, $start, $end);
  }

  method is_end {
    so gtk_source_region_iter_is_end($!sr);
  }

  method next {
    gtk_source_region_iter_next($!sr);
  }
  
}
