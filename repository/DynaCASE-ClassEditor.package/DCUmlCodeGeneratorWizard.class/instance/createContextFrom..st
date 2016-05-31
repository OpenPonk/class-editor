actions
createContextFrom: aDictionary
	| context |
	context := DCUmlCodeGeneratorContext new.
	context
		package: (aDictionary at: #package);
		prefix: (aDictionary at: #classPrefix);
		conflictPrefix: (aDictionary at: #conflictPrefix).
	(aDictionary at: #addAccessors)
		ifTrue: [ context withAccessors ]
		ifFalse: [ context withoutAccessors ].
	(aDictionary at: #initializationType) = #lazy
		ifTrue: [ context useLazyInitialization ].
	(aDictionary at: #initializationType) = #eager
		ifTrue: [ context useEagerInitialization ].
	(aDictionary at: #overrideMethods)
		ifTrue: [ context overrideMethods ]
		ifFalse: [ context doNotOverrideMethods ].
	context withProgressBar.
	^ context