toolbar
canvasToolbarFor: aBuilder
	<dcCanvasToolbar: #OPUmlClassPlugin>
	(aBuilder item: 'Layout') action: [  ].
	aBuilder model diagramController addLayoutMenu: aBuilder parent: 'Layout'