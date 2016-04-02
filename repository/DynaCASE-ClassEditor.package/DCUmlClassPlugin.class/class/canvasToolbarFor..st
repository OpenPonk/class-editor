toolbar
canvasToolbarFor: aBuilder
	<dcCanvasToolbar: #DCUmlClassPlugin>
	(aBuilder item: 'Layout') action: [  ].
	aBuilder model diagramController addLayoutMenu: aBuilder parent: 'Layout'