ui hooks
addLayoutMenu: builder parent: aParent
	| classes inheritance associations centerY |
	classes := self controllers
		select: [ :ctrl | ctrl isMemberOf: DCUmlClassController ]
		thenCollect: #figure.
	inheritance := self controllers
		select: [ :ctrl | ctrl isMemberOf: DCUmlInheritanceController ]
		thenCollect: #figure.
	associations := self controllers
		select: [ :ctrl | ctrl isMemberOf: DCUmlAssociationController ]
		thenCollect: #figure.
	(Smalltalk globals includesKey: #DCGraphVizLayout)
		ifTrue: [ (builder item: 'GraphViz')
				parent: aParent;
				action: [ #DCGraphVizLayout asClass new
						on: classes
						directed: inheritance
						undirected: associations.
					self view signalUpdate ] ].
	(builder item: 'Grid')
		parent: aParent;
		action: [ RTGridLayout new
				gapSize: 140;
				on: classes.
			self view signalUpdate ].
	(builder item: 'Sugiyama')
		parent: aParent;
		action: [ RTSugiyamaLayout new
				doNotAttachPoint;
				verticalGap: 100;
				horizontalGap: 100;
				on: classes edges: inheritance.
			centerY := classes asGroup encompassingRectangle center y.
			classes do: [ :each | each translateBy: 0 @ 2 * (centerY - each position y) ].
			self view signalUpdate ].
	(builder item: 'Tree')
		parent: aParent;
		action: [ RTTreeLayout new
				doNotAttachPoint;
				verticalGap: 100;
				horizontalGap: 100;
				on: classes edges: inheritance.
			centerY := classes asGroup encompassingRectangle center y.
			classes do: [ :each | each translateBy: 0 @ 2 * (centerY - each position y) ].
			self view signalUpdate ].
	(builder item: 'Circle')
		parent: aParent;
		action: [ RTWeightedCircleLayout new on: classes.
			self view signalUpdate ]