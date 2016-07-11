actions
createContextFrom: aDictionary
	| context |
	context := UPGGeneratorContext new.
	context
		package: (aDictionary at: #package);
		prefix: (aDictionary at: #classPrefix).
	aDictionary
		at: #alwaysUsePrefix
		ifPresent: [ :bool | 
			bool
				ifTrue: [ context alwaysUsePrefix ] ].
	(aDictionary at: #addAccessors)
		ifTrue: [ context withAccessors ]
		ifFalse: [ context withoutAccessors ].
	context accessorsStyle: (aDictionary at: #accessorsStyle).
	(aDictionary at: #initializationType) = #lazy
		ifTrue: [ context useLazyInitialization ].
	(aDictionary at: #initializationType) = #eager
		ifTrue: [ context useEagerInitialization ].
	(aDictionary at: #overrideMethods)
		ifTrue: [ context overrideMethods ]
		ifFalse: [ context doNotOverrideMethods ].
	context withProgressBar.
	^ context