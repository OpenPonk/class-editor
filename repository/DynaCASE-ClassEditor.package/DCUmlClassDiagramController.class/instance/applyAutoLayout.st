ui hooks
applyAutoLayout
	| classes inheritance associations |
	classes := self controllers
		select: [ :ctrl | ctrl isMemberOf: DCUmlClassController ]
		thenCollect: #figure.
	(Smalltalk globals includesKey: #DCGraphVizLayout) & true
		ifTrue:
			[ inheritance := self controllers
				select: [ :ctrl | ctrl isMemberOf: DCUmlInheritanceController ]
				thenCollect: #figure.
			associations := self controllers
				select: [ :ctrl | ctrl isMemberOf: DCUmlAssociationController ]
				thenCollect: #figure.
			#DCGraphVizLayout asClass new
				on: classes
				directed: inheritance
				undirected: associations.
			^ self ].
	^ RTGridLayout new
		gapSize: 80;
		on: classes
	"DCUmlBasicLayout new onController: self "