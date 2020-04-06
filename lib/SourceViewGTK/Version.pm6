use v6.c;

use SourceViewGTK::Raw::Version;

use GLib::Roles::StaticClass;

class SourceViewGTK::Version {
  also does GLib::Roles::StaticClass;

  method check_version (Int() $major, Int() $minor, Int() $micro) {
    my uint32 ($mj, $mn, $mc) = ($major, $minor, $micro);

    gtk_source_check_version($mj, $mn, $mc);
  }

  method Str {
    "v{ self.get_major_version }.{ self.get_minor_version }.{
        self.get_micro_version }";
  }

  method Version {
    Version.new( SourceViewGTK::Version.Str );
  }

  method get_major_version (SourceViewGTK::Version:U:) {
    gtk_source_get_major_version();
  }

  method get_micro_version (SourceViewGTK::Version:U:) {
    gtk_source_get_micro_version();
  }

  method get_minor_version (SourceViewGTK::Version:U:) {
    gtk_source_get_minor_version();
  }

}
