toolbar
canvasToolbarFor: aBuilder
	<opCanvasToolbar: #OPUmlClassPlugin>
	(aBuilder item: 'Layout') action: [  ].
	aBuilder model diagramController addLayoutMenu: aBuilder parent: 'Layout'