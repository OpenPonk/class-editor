removing
removeModelElement: aModelElement
	"Remove self as target of aModelElement"

	aModelElement isAttribute
		ifTrue: [ self model attributes remove: aModelElement ifAbsent: [ self error ] ].
	aModelElement isMethod
		ifTrue: [ self model methods remove: aModelElement ifAbsent: [ self error ] ].

	self diagramController removeControllerOf: aModelElement.
	self diagramController updateView