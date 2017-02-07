visitor
visitXmiExtension: anElement
	anElement @ #extender = 'DynaCASE Class Editor'
		ifFalse: [ ^ self ].
	anElement elements
		select: [ :each | each @ #xmi:type = 'uml:Class' ]
		thenDo: [ :cls | cls elements select: [ :each | each @ #xmi:type = 'uml:Stereotype' ] thenDo: [ :each | self visit: each ] ]