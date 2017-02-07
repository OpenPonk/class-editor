visitor
visitMethod: aMethod
	| attrs |
	attrs := Dictionary
		with: #xmi:type -> 'uml:Property'
		with: #xmi:id -> aMethod uuid asString
		with: #name -> aMethod name.
	aMethod isAbstract
		ifTrue: [ attrs at: #isAbstract put: true asString ].
	aMethod isStatic
		ifTrue: [ attrs at: #isStatic put: true asString ].
	writer
		tag: #ownedOperation
		attributes: attrs
		with: [ aMethod parameters do: [ :each | each accept: self ] ]