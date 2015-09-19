events - registering
registerModelEvents: aModel
	aModel announcer
		when: MooseEntityRemoved
		do:
			[ :event | 
			self diagramController removeControllerOf: event element.
			self diagramController updateView ].
	aModel announcer
		when: MooseEntityRenamed
		do:
			[ :event | 
			aModel owner isNotNil & figure isNotNil
				ifTrue: [ self refreshFigure ] ]