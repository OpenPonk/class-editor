toolbar
canvasToolbarFor: aBuilder
	<opCanvasToolbar: #OPUmlOldClassPlugin>
	(aBuilder item: 'Layout') action: [  ].
	aBuilder model diagramController addLayoutMenu: aBuilder parent: 'Layout'