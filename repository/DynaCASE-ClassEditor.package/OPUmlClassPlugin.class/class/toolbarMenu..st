toolbar
toolbarMenu: aBuilder
	<dcEditorToolbarMenu: #OPUmlClassPlugin>
	(aBuilder item: 'DSL Editor')
		action: [ OPDslEditor new
				parser: OPUmlDslParser new;
				exporter: OPUmlDslExporter new;
				modelClass: MooseModel;
				model: aBuilder model diagramController model;
				openWithSpec ].
	(aBuilder item: 'Generate VW Code...')
		action: [ CECMVWGeneratorWizard openOn: aBuilder model diagramController model ]
	"	(aBuilder item: 'Generate Code...')
		action: [ DCUmlCodeGeneratorWizard openOn: aBuilder model diagramController model ].
	(aBuilder item: 'Import Code...')
		action: [ DCUmlCodeImporterWizard openOn: aBuilder model diagramController model ]"