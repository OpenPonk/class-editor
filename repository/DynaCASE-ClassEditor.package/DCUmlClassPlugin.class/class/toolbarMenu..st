toolbar
toolbarMenu: aBuilder
	<dcEditorToolbarMenu: #DCUmlClassPlugin>
	(aBuilder item: 'DSL Editor')
		action: [ DCDslEditor new
				parser: DCUmlDslParser new;
				exporter: DCUmlDslExporter new;
				modelClass: MooseModel;
				model: aBuilder model diagramController model;
				openWithSpec ].
	(aBuilder item: 'Generate Code...')
		withSeparatorAfter;
		action: [ DCUmlCodeGeneratorWindow new
				model: aBuilder model diagramController model;
				openWithSpec ]