use v6.c;

use GTK::Raw::Utils;

use SourceViewGTK::Raw::Version;

class SourceViewGTK::Version {

  method new {
    die "SourceViewGTK::Version is not an instantiable class.";
  }
    
  method check_version (Int() $major, Int() $minor, Int() $micro) {
    my uint32 ($mj, $mn, $mc) = self.RESOLVE-UINT($major, $minor, $micro);
    gtk_source_check_version($mj, $mn, $mc);
  }
  
  method Str { 
    "v{ self.get_major_version }.{ self.get_minor_version }.{ 
        self.get_micro_version }";
  }
  
  method Version {
    Version.new(~self);
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
