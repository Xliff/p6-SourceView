use v6.c;

class SourceViewGTK::Builder::Registry {

  method register {
    %(
      'GTK::SourceStyleSchemeChooserWidget' => 'SourceViewGTK::StyleSchemeChooserWidget',
      'GTK::SourceStyleSchemeChooserButton' => 'SourceViewGTK::StyleSchemeChooserButton',
      'GTK::SourceView'                     => 'SourceViewGTK::View',
      'GTK::SourceStyleChooserWidget'       => 'SourceViewGTK::StyleChooserWidget',
      'GTK::SourceCompletionInfo'           => 'SourceViewGTK::CompletionInfo',
      'GTK::SourceMap'                      => 'SourceViewGTK::Map'
    );
  }
  
}
