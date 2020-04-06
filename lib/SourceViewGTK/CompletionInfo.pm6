use v6.c;

use Method::Also;

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
      when CompletionInfoAncestry        { self.setCompletionInfo($info) }
      when SourceViewGTK::CompletionInfo { }
      default                            { }
    }
  }

  method setCompletionInfo (CompletionInfoAncestry $_) {
    my $to-parent;
    $!sci = do {
      when GtkSourceCompletionInfo {
        $to-parent = cast(GtkWindow, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GtkSourceCompletionInfo, $_);
      }
    }
    self.setWindow($to-parent);
  }

  method SourceViewGTK::Raw::Definitions::GtkSourceCompletionInfo
    is also<SourceCompletionInfo>
  { $!sci }

  multi method new (GtkSourceCompletionInfo $info, :$ref = True) {
    return Nil unless $info;

    my $o = self.bless(:$info);
    $o.ref if $ref;
    $o;
  }

  multi method new {
    my $info = gtk_source_completion_info_new();

    $info ?? self.bless($info) !! Nil;
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
