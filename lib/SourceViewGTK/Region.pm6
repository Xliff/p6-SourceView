use v6.c;

use Method::Also;

use SourceViewGTK::Raw::Types;
use SourceViewGTK::Raw::Region;

use GTK::TextBuffer;

class SourceViewGTK::RegionIter { ... }

class SourceViewGTK::Region {
  has GtkSourceRegion $!sr;

  submethod BUILD (:$region) {
    $!sr = $region;
  }

  method SourceViewGTK::Raw::Definitions::GtkSourceRegion
    is also<
      Region
      GtkSourceRegion
    >
  { $!sr }

  method new (GtkTextBuffer() $buffer) {
    my $region = gtk_source_region_new($buffer);

    $region ?? self.bless(:$region) !! Nil;
  }

  method add_region (GtkSourceRegion() $region_to_add) is also<add-region> {
    gtk_source_region_add_region($!sr, $region_to_add);
  }

  method add_subregion (GtkTextIter() $start, GtkTextIter() $end)
    is also<add-subregion>
  {
    gtk_source_region_add_subregion($!sr, $start, $end);
  }

  proto method get_bounds (|)
    is also<get-bounds>
  { * }

  multi method get_bounds (:$raw = False)  {
    my ($start, $end) = GtkTextIter.new xx 2;

    samewith($start, $end);
    $raw ?? ($start, $end) !!
            ( GTK::TextIter.new($start), GTK::TextIter.new($end) );
  }
  multi method get_bounds (GtkTextIter() $start, GtkTextIter() $end) {
    so gtk_source_region_get_bounds($!sr, $start, $end);
  }

  method get_buffer (:$raw = False) is also<get-buffer> {
    my $tb = gtk_source_region_get_buffer($!sr);

    $tb ??
      ( $raw ?? $tb !! GTK::TextBuffer.new($tb) )
      !!
      Nil;
  }

  method get_start_region_iter (GtkSourceRegionIter() $iter, :$raw = False)
    is also<get-start-region-iter>
  {
    my $ri = gtk_source_region_get_start_region_iter($!sr, $iter);

    $ri ??
      ( $raw ?? $ri !! SourceViewGTK::RegionIter.new($ri) )
      !!
      Nil;
  }

  method intersect_region (GtkSourceRegion() $region2, :$raw = False)
    is also<intersect-region>
  {
    my $r = gtk_source_region_intersect_region($!sr, $region2);

    $r ??
      ( $raw ?? $r !! SourceViewGTK::Region.new($r) )
      !!
      Nil;
  }

  method intersect_subregion (
    GtkTextIter() $start,
    GtkTextIter() $end,
    :$raw = False
  )
    is also<intersect-subregion>
  {
    my $r = gtk_source_region_intersect_subregion($!sr, $start, $end);

    $r ??
      ( $raw ?? $r !! SourceViewGTK::Region.new($r) )
      !!
      Nil;
  }

  method is_empty is also<is-empty> {
    so gtk_source_region_is_empty($!sr);
  }

  method subtract_region (GtkSourceRegion() $region_to_subtract)
    is also<subtract-region>
  {
    gtk_source_region_subtract_region($!sr, $region_to_subtract);
  }

  method subtract_subregion (GtkTextIter() $start, GtkTextIter() $end)
    is also<subtract-subregion>
  {
    gtk_source_region_subtract_subregion($!sr, $start, $end);
  }

  method to_string is also<
    to-string
    Str
  > {
    gtk_source_region_to_string($!sr);
  }

}

class SourceViewGTK::RegionIter {
  has GtkSourceRegionIter $!sri;

  submethod BUILD (:$iter) {
    $!sri = $iter;
  }

  method SourceViewGTK::Raw::Definitions::GtkSourceRegionIter
    is also<
      RegionIter
      GtkSourceRegionIter
    >
  { $!sri }

  method new (GtkSourceRegionIter $iter) {
    $iter ?? self.bless(:$iter) !! Nil;
  }

  proto method get_subregion (|)
    is also<get-subregion>
  { * }

  multi method get_subregion (:$raw = False) {
    my ($start, $end) = GtkTextIter.new;

    samewith($start, $end);
    $raw ?? ($start, $end) !!
            ( GTK::TextIter.new($start), GtkTextIter.new($end) );
  }
  multi method get_subregion (GtkTextIter() $start, GtkTextIter() $end) {
    so gtk_source_region_iter_get_subregion($!sri, $start, $end);
  }

  method is_end is also<is-end> {
    so gtk_source_region_iter_is_end($!sri);
  }

  method next {
    so gtk_source_region_iter_next($!sri);
  }

}
