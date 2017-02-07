removing
removeModelElement: aModelElement
	aModelElement isClass
		ifTrue:
			[ 
			aModelElement attributes copy do: [ :each | self removeFromModel: each ].
			aModelElement methods copy do: [ :each | self removeFromModel: each ].
			aModelElement superInheritances copy do: [ :each | self removeFromModel: each ].
			aModelElement subInheritances copy do: [ :each | self removeFromModel: each ].
			aModelElement outgoingAssociations copy do: [ :each | self removeFromModel: each ].
			aModelElement incomingAssociations copy do: [ :each | self removeFromModel: each ] ].

	self removeControllerOf: aModelElement.
	self ensureNotInModel: aModelElement.

	self updateView