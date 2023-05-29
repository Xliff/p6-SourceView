use v6.c;

use Method::Also;

use SourceViewGTK::Raw::Types;
use SourceViewGTK::Raw::SpaceDrawer;

use JSON::GLib::Variant;

use GLib::Roles::Object;
use GTK::Roles::Types;

our subset GtkSourceSpaceDrawerAncestry is export of Mu
  where GtkSourceSpaceDrawer | GObject;

class SourceViewGTK::SpaceDrawer {
  also does GLib::Roles::Object;
  also does GTK::Roles::Types;

  has GtkSourceSpaceDrawer $!ssd is implementor;

  submethod BUILD ( :$space-drawer ) {
    self.setGtkSourceSpaceDrawer($space-drawer) if $space-drawer
  }

  method setGtkSourceSpaceDrawer (GtkSourceSpaceDrawerAncestry $_) {
    my $to-parent;

    $!ssd = do {
      when GtkSourceSpaceDrawer {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkSourceSpaceDrawer, $_);
      }
    }
    self!setObject($to-parent);
  }

  method SourceViewGTK::Raw::Definitions::GtkSourceSpaceDrawer
    is also<GtkSourceSpaceDrawer>
  { $!ssd }

  multi method new (
     $space-drawer where * ~~ GtkSourceSpaceDrawerAncestry,

    :$ref = True
  ) {
    return unless $space-drawer;

    my $o = self.bless( :$space-drawer );
    $o.ref if $ref;
    $o;
  }
  multi method new ( *%a ) {
    my $drawer = gtk_source_space_drawer_new();

    my $o = $drawer ?? self.bless(:$drawer) !! Nil;
    $o.setAttributes(%a) if $o && +%a;
    $o;
  }

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
  method matrix (:$raw = False, :$variant = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $v = propReturnObject(
          gtk_source_space_drawer_get_matrix($!ssd),
          $raw,
          |GLib::Variant.getTypePair
        ) but JSON::GLib::Variant::Serialize;

        return $v if $variant;
        $v.json-node.Raku;
      },
      STORE => sub ($, GVariant() $matrix is copy) {
        gtk_source_space_drawer_set_matrix($!ssd, $matrix);
      }
    );
  }

  method bind_matrix_setting (
    GSettings() $settings,
    Str()       $key,
    Int()       $flag
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
