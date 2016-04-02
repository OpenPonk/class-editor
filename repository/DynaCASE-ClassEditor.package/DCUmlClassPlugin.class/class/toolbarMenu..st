toolbar
toolbarMenu: aBuilder
	<dcEditorToolbarMenu: #DCUmlClassPlugin>
	(aBuilder item: 'DSL Editor')
		action: [ DCUmlDslEditor new
				model: aBuilder model diagramController model;
				openWithSpec ].
	(aBuilder item: 'Generate Code...')
		withSeparatorAfter;
		action: [ DCUmlCodeGeneratorWindow new
				model: aBuilder model diagramController model;
				openWithSpec ]