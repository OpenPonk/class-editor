removing
removeModelElement: aModelElement
	"Remove self as target of aModelElement"

	aModelElement isAttribute
		ifTrue: [ self model attributes remove: aModelElement ].
	aModelElement isMethod
		ifTrue: [ self model methods remove: aModelElement ].
	aModelElement isInheritance
		ifTrue:
			[ 
			aModelElement superclass subInheritances remove: aModelElement.
			aModelElement subclass superInheritances remove: aModelElement ].
	aModelElement isBinaryAssociation
		ifTrue:
			[ 
			aModelElement from outgoingAssociations remove: aModelElement.
			aModelElement to incomingAssociations remove: aModelElement ].

	self diagramController removeControllerOf: aModelElement.
	self diagramController ensureNotInModel: aModelElement.

	self diagramController updateView