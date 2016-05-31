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
		action: [ DCUmlCodeGeneratorWizard openOn: aBuilder model diagramController model ].
	(aBuilder item: 'Import Code...')
		action: [ DCUmlCodeImporterWizard openOn: aBuilder model diagramController model ]