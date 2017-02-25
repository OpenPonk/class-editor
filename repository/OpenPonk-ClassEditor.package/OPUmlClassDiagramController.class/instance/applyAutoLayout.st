ui hooks
applyAutoLayout
	| classes inheritance associations |
	classes := self controllers
		select: [ :ctrl | ctrl isKindOf: OPUmlClassController ]
		thenCollect: #figure.
	(Smalltalk globals includesKey: #OPGraphVizLayout) & true
		ifTrue:
			[ inheritance := self controllers
				select: [ :ctrl | ctrl isKindOf: OPUmlInheritanceController ]
				thenCollect: #figure.
			associations := self controllers
				select: [ :ctrl | ctrl isKindOf: OPUmlAssociationController ]
				thenCollect: #figure.
			#OPGraphVizLayout asClass new
				on: classes
				directed: inheritance
				undirected: associations.
			^ self ].
	^ RTGridLayout new
		gapSize: 140;
		on: classes
	"DCUmlBasicLayout new onController: self "