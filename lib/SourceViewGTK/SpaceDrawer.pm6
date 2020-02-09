use v6.c;



use SourceViewGTK::Raw::Types;
use SourceViewGTK::Raw::SpaceDrawer;

use GLib::Roles::Object;
use GTK::Roles::Types;

class SourceViewGTK::SpaceDrawer {
  also does GLib::Roles::Object;
  also does GTK::Roles::Types;
  
  has GtkSourceSpaceDrawer $!ssd;
  
  submethod BUILD (:$drawer) {
    self!setObject($!ssd = $drawer);
  }
  
  multi method new (GtkSourceSpaceDrawer $drawer) {
    self.bless(:$drawer);
  }
  multi method new {
    self.bless( drawer => gtk_source_space_drawer_new() );
  }
  
  method SourceViewGTK::Raw::Types::GtkSourceSpaceDrawer { $!ssd }
  
  method enable_matrix is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_source_space_drawer_get_enable_matrix($!ssd);
      },
      STORE => sub ($, Int() $enable_matrix is copy) {
        my uint32 $em = self.RESOLVE-BOOL($enable_matrix);
        gtk_source_space_drawer_set_enable_matrix($!ssd, $em);
      }
    );
  }
  
  # GVariant
  method matrix is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_source_space_drawer_get_matrix($!ssd);
      },
      STORE => sub ($, $matrix is copy) {
        gtk_source_space_drawer_set_matrix($!ssd, $matrix);
      }
    );
  }
  
  method bind_matrix_setting (
    GSettings() $settings, 
    Str() $key, 
    Int() $flag
  ) {
    my uint32 $f = self.RESOLVE-UINT($flag);
    gtk_source_space_drawer_bind_matrix_setting($!ssd, $settings, $key, $f);
  }

  method get_type {
    gtk_source_space_drawer_get_type();
  }

  method get_types_for_locations (Int() $locations) {
    my guint $l = self.RESOLVE-UINT($locations);
    gtk_source_space_drawer_get_types_for_locations($!ssd, $l);
  }

  method set_types_for_locations (Int() $locations, Int() $types) {
    my uint32 ($l, $t) = self.RESOLVE-UINT($locations, $types);
    gtk_source_space_drawer_set_types_for_locations($!ssd, $l, $t);
  }

}
