use v6.c;

use Method::Also;

use SourceViewGTK::Raw::Types;
use SourceViewGTK::Raw::SearchSettings;

use GLib::Roles::Object;

class SourceViewGTK::SearchSettings {
  also does GLib::Roles::Object;

  has GtkSourceSearchSettings $!sss;

  submethod BUILD (:$settings) {
    self!setObject($!sss = $settings);
  }

  method SourceViewGTK::Raw::Definitions::GtkSourceSearchSettings
    is also<GtkSourceSearchSettings>
  { $!sss }

  multi method new (GtkSourceSearchSettings $settings) {
    $settings ?? self.bless(:$settings) !! Nil
  }
  multi method new {
    my $settings = gtk_source_search_settings_new();

    $settings ?? self.bless(:$settings) !! Nil
  }

  method at_word_boundaries is rw is also<at-word-boundaries> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_source_search_settings_get_at_word_boundaries($!sss);
      },
      STORE => sub ($, Int() $at_word_boundaries is copy) {
        my gboolean $awb = $at_word_boundaries.so.Int;

        gtk_source_search_settings_set_at_word_boundaries($!sss, $awb);
      }
    );
  }

  method case_sensitive is rw is also<case-sensitive> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_source_search_settings_get_case_sensitive($!sss);
      },
      STORE => sub ($, $case_sensitive is copy) {
        my gboolean $cs = $case_sensitive.so.Int;

        gtk_source_search_settings_set_case_sensitive($!sss, $cs);
      }
    );
  }

  method regex_enabled is rw is also<regex-enabled> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_source_search_settings_get_regex_enabled($!sss);
      },
      STORE => sub ($, Int() $regex_enabled is copy) {
        my gboolean $re = $regex_enabled.so.Int;

        gtk_source_search_settings_set_regex_enabled($!sss, $re);
      }
    );
  }

  method search_text is rw is also<search-text> {
    Proxy.new(
      FETCH => sub ($) {
        gtk_source_search_settings_get_search_text($!sss);
      },
      STORE => sub ($, Str() $search_text is copy) {
        gtk_source_search_settings_set_search_text($!sss, $search_text);
      }
    );
  }

  method wrap_around is rw is also<wrap-around> {
    Proxy.new(
      FETCH => sub ($) {
        so gtk_source_search_settings_get_wrap_around($!sss);
      },
      STORE => sub ($, Int() $wrap_around is copy) {
        my gboolean $wa = $wrap_around.so.Int;

        gtk_source_search_settings_set_wrap_around($!sss, $wa);
      }
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gtk_source_search_settings_get_type,
      $n,
      $t
    );
  }

}
