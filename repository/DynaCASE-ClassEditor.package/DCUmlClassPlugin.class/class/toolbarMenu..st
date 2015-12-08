toolbar
toolbarMenu: aBuilder
	(aBuilder item: 'Generate Code...')
		action:
			[ DCUmlCodeGeneratorWindow new
				model: aBuilder model diagramController model;
				openWithSpec ]