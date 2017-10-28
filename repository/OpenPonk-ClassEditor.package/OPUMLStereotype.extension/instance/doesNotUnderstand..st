*OpenPonk-ClassEditor
doesNotUnderstand: aMessage
	| selector |
	aMessage numArgs > 1
		ifTrue: [ ^ super doesNotUnderstand: aMessage ].
	selector := aMessage selector withoutSuffix: ':'.
	(aMessage selector beginsWith: 'base_')
		ifTrue: [ ^ aMessage hasArguments
				ifTrue: [ self appliedTo: aMessage argument ]
				ifFalse: [ self appliedTo ] ].
	"How will this work if the ownedAttributes includes something that the class already implements?"
	self ownedAttributes
		detect: [ :each | each name = selector ]
		ifFound: [ ^ aMessage hasArguments
				ifTrue: [ self tagAt: selector put: aMessage argument ]
				ifFalse: [ self tagAt: selector ] ].
	^ super doesNotUnderstand: aMessage