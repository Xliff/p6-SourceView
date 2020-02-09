use v6.c;


use SourceViewGTK::Raw::Types;
use SourceViewGTK::Raw::SearchSettings;

use GLib::Roles::Object;
use GTK::Roles::Types;

class SourceViewGTK::SearchSettings {
  also does GLib::Roles::Object;
  also does GTK::Roles::Types;
  
  has GtkSourceSearchSettings $!sss;
  
  submethod BUILD (:$settings) {
    self!setObject($!sss = $settings);
  }
  
  method SourceViewGTK::Raw::Types::GtkSourceSearchSettings { $!sss }
  
  multi method new (GtkSourceSearchSettings $settings) {
    self.bless(:$settings);
  }
  multi method new {
    self.bless( settings => gtk_source_search_settings_new() );
  }
  
  method at_word_boundaries is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_source_search_settings_get_at_word_boundaries($!sss);
      },
      STORE => sub ($, Int() $at_word_boundaries is copy) {
        my gboolean $awb = self.RESOLVE-BOOL($at_word_boundaries);
        gtk_source_search_settings_set_at_word_boundaries($!sss, $awb);
      }
    );
  }

  method case_sensitive is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_source_search_settings_get_case_sensitive($!sss);
      },
      STORE => sub ($, $case_sensitive is copy) {
        my gboolean $cs = self.RESOLVE-BOOL($case_sensitive);
        gtk_source_search_settings_set_case_sensitive($!sss, $cs);
      }
    );
  }

  method regex_enabled is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_source_search_settings_get_regex_enabled($!sss);
      },
      STORE => sub ($, Int() $regex_enabled is copy) {
        my gboolean $re = self.RESOLVE-BOOL($regex_enabled);
        gtk_source_search_settings_set_regex_enabled($!sss, $re);
      }
    );
  }

  method search_text is rw {
    Proxy.new(
      FETCH => sub ($) {
        gtk_source_search_settings_get_search_text($!sss);
      },
      STORE => sub ($, Str() $search_text is copy) {
        gtk_source_search_settings_set_search_text($!sss, $search_text);
      }
    );
  }

  method wrap_around is rw {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_source_search_settings_get_wrap_around($!sss);
      },
      STORE => sub ($, Int() $wrap_around is copy) {
        my gboolean $wa = self.RESOLVE-BOOL($wrap_around);
        gtk_source_search_settings_set_wrap_around($!sss, $wa);
      }
    );
  }
  
  method get_type {
    gtk_source_search_settings_get_type();
  }
  
}
