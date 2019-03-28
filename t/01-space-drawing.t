use v6.c;

use GTK::Raw::Types;
use SourceViewGTK::Raw::Types;

use GTK::Compat::Binding;

use GTK::Application;
use GTK::CheckButton;
use GTK::Grid;
use GTK::ScrolledWindow;

use SourceViewGTK::SpaceDrawer;
use SourceViewGTK::View;

sub fill_buffer($buffer, $tag) {
  $buffer.text = '';
  
  my $i = $buffer.get_start_iter;
  $buffer.insert($i, qq:to/TEXT/);
---
\tText without draw-spaces tag.
\tNon-breaking whitespace:\t.
\tTrailing spaces.     
---
TEXT

  $buffer.insert_with_tag($i, qq:to/TEXT/, $tag);
---
\tText with draw-spaces tag.
\tNon-breaking whitespace:\t.
\tTrailing spaces.     
---
TEXT
  
}

my $a = GTK::Application.new( title => 'org.genex.sourceview.space_drawing' );

$a.activate.tap({ 
  $a.window.set_default_size(800, 600);
  
  my $hgrid = GTK::Grid.new;
  $hgrid.orientation = GTK_ORIENTATION_HORIZONTAL;
  
  my $view = SourceViewGTK::View.new;
  $view.monospace = True;
  $view.expand = True;
  
  my $buffer = $view.buffer;
  my $tag = $buffer.create_source_tag(Str, 'draw-spaces', False);
  
  fill_buffer($buffer, $tag);
  
  my $space-drawer = SourceViewGTK::SpaceDrawer.new;
  $space-drawer.set_types_for_locations(
    GTK_SOURCE_SPACE_LOCATION_ALL, GTK_SOURCE_SPACE_TYPE_NBSP
  );
  $space-drawer.set_types_for_locations(
    GTK_SOURCE_SPACE_LOCATION_TRAILING, GTK_SOURCE_SPACE_TYPE_ALL
  );
  
  my $panel-grid = GTK::Grid.new;
  $panel-grid.orientation = GTK_ORIENTATION_VERTICAL;
  $hgrid.add($panel-grid);
  
  $panel-grid.row_spacing = 6;
  $panel-grid.margin = 6;
  
  my %check-buttons;
  
  %check-buttons<matrix> = GTK::CheckButton.new_with_label(
    'GtkSourceSpaceDrawer enable-matrix'
  );
  $panel-grid.add(%check-buttons<matrix>);
  %check-buttons<matrix>.active = True;
  GTK::Compat::Binding.bind(
    %check-buttons<matrix>, 'active', $space-drawer, 'enable-matrix'
  );
  
  %check-buttons<tag-set> = GTK::CheckButton.new_with_label(
    'GtkSourceTag draw-spaces-set'
  );
  $panel-grid.add(%check-buttons<tag-set>);
  %check-buttons<tag-set>.active = True;
  GTK::Compat::Binding.bind(
    %check-buttons<tag-set>, 'active', $tag, 'draw-spaces-set'
  );
  
  %check-buttons<tag> = GTK::CheckButton.new_with_label(
    'GtkSourceTag draw-spaces'
  );
  $panel-grid.add(%check-buttons<tag>);
  %check-buttons<tag>.active = True;
  GTK::Compat::Binding.bind(
    %check-buttons<tag>, 'active', $tag, 'draw-spaces'
  );

  %check-buttons<implicit> = GTK::CheckButton.new_with_label(
    'Implicit trailing newline'
  );
  $panel-grid.add(%check-buttons<implicit>);
  %check-buttons<implicit>.active = True;
  GTK::Compat::Binding.bind(
    %check-buttons<implicit>, 'active', $buffer, 'implicit-trailing-newline'
  );
  
  my $sw = GTK::ScrolledWindow.new;
  $sw.add($view);
  
  $hgrid.add($sw);
  $a.window.add($hgrid);
  $a.window.show-all;
      
});

$a.run;
