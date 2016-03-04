toolbar
toolbarMenu: aBuilder
	(aBuilder item: 'DSL Editor')
		action: [ DCUmlDslEditor new
				model: aBuilder model diagramController model;
				openWithSpec ].
	(aBuilder item: 'Generate Code...')
		action: [ DCUmlCodeGeneratorWindow new
				model: aBuilder model diagramController model;
				openWithSpec ]