use v6.c;

use Method::Also;

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
    $drawer ?? self.bless(:$drawer) !! Nil;
  }
  multi method new {
    my $drawer = gtk_source_space_drawer_new();

    $drawer ?? self.bless(:$drawer) !! Nil;
  }

  method SourceViewGTK::Raw::Definitions::GtkSourceSpaceDrawer
    is also<GtkSourceSpaceDrawer>
  { $!ssd }

  method enable_matrix is rw is also<enable-matrix> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_source_space_drawer_get_enable_matrix($!ssd);
      },
      STORE => sub ($, Int() $enable_matrix is copy) {
        my uint32 $em = $enable_matrix;

        gtk_source_space_drawer_set_enable_matrix($!ssd, $em);
      }
    );
  }

  # GVariant
  method matrix (:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $v = gtk_source_space_drawer_get_matrix($!ssd);

        $v ??
          ( $raw ?? $v !! GLib::Variant.new($v) )
          !!
          Nil;
      },
      STORE => sub ($, GVariant() $matrix is copy) {
        gtk_source_space_drawer_set_matrix($!ssd, $matrix);
      }
    );
  }

  method bind_matrix_setting (
    GSettings() $settings,
    Str() $key,
    Int() $flag
  )
    is also<bind-matrix-setting>
  {
    my uint32 $f = $flag;
    gtk_source_space_drawer_bind_matrix_setting($!ssd, $settings, $key, $f);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gtk_source_space_drawer_get_type,
      $n,
      $t
    );
  }

  method get_types_for_locations (Int() $locations)
    is also<get-types-for-locations>
  {
    my guint $l = $locations;

    gtk_source_space_drawer_get_types_for_locations($!ssd, $l);
  }

  method set_types_for_locations (Int() $locations, Int() $types)
    is also<set-types-for-locations>
  {
    my uint32 ($l, $t) = $locations, $types;

    gtk_source_space_drawer_set_types_for_locations($!ssd, $l, $t);
  }

}
