ui hooks
applyAutoLayout
	| classes inheritance associations |
	classes := self controllers
		select: [ :ctrl | ctrl isKindOf: OPUmlOldClassController ]
		thenCollect: #figure.
	(Smalltalk globals includesKey: #OPGraphVizLayout) & true
		ifTrue:
			[ inheritance := self controllers
				select: [ :ctrl | ctrl isKindOf: OPUmlOldInheritanceController ]
				thenCollect: #figure.
			associations := self controllers
				select: [ :ctrl | ctrl isKindOf: OPUmlOldAssociationController ]
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