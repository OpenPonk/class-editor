ui hooks
applyAutoLayout
	| classes inheritance associations |
	classes := self controllers
		select: [ :ctrl | ctrl isKindOf: DCUmlClassController ]
		thenCollect: #figure.
	(Smalltalk globals includesKey: #DCGraphVizLayout) & true
		ifTrue:
			[ inheritance := self controllers
				select: [ :ctrl | ctrl isKindOf: DCUmlInheritanceController ]
				thenCollect: #figure.
			associations := self controllers
				select: [ :ctrl | ctrl isKindOf: DCUmlAssociationController ]
				thenCollect: #figure.
			#DCGraphVizLayout asClass new
				on: classes
				directed: inheritance
				undirected: associations.
			^ self ].
	^ RTGridLayout new
		gapSize: 140;
		on: classes
	"DCUmlBasicLayout new onController: self "