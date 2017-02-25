toolbar
toolbarMenu: aBuilder
	<opEditorToolbarMenu: #OPUmlClassPlugin>
	(aBuilder item: 'DSL Editor')
		action: [ OPDslEditor new
				parser: OPUmlDslParser new;
				exporter: OPUmlDslExporter new;
				modelClass: MooseModel;
				model: aBuilder model diagramController model;
				openWithSpec ]