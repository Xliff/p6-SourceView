use v6.c;

use Method::Also;

use GTK::Raw::Types;

use SourceViewGTK::Raw::Types;
use SourceViewGTK::Raw::CompletionInfo;

use GTK::Window;

our subset CompletionInfoAncestry 
  where GtkSourceCompletionInfo | WindowAncestry;

class SourceViewGTK::CompletionInfo is GTK::Window {
  has GtkSourceCompletionInfo $!sci;
  
  method bless(*%attrinit) {
    my $o = self.CREATE.BUILDALL(Empty, %attrinit);
    $o.setType(self.^name);
    $o;
  }
  
  submethod BUILD (:$info) {
    given $info {
      when CompletionInfoAncestry {
        self.setWindow( $!sci = $info );
      }
      when SourceViewGTK::CompletionInfo {
      }
      default {
      }
    }
  }
  
  method SourceViewGTK::Raw::Types::GtkSourceCompletionInfo 
    is also<SourceCompletionInfo>
    { $!sci }
  
  multi method new (GtkSourceCompletionInfo $info) {
    self.bless(:$info);
  }
  
  multi method new {
    self.bless( info => gtk_source_completion_info_new() );
  }
  
  method get_type is also<get-type> {
    state ($n, $t);
    GTK::Widget.unstable_get_type(
      &gtk_source_completion_info_get_type,
      $n,
      $t
    )
  }

  method move_to_iter (GtkTextView() $view, GtkTextIter() $iter) 
    is also<move-to-iter>
  {
    gtk_source_completion_info_move_to_iter($!sci, $view, $iter);
  }

}
