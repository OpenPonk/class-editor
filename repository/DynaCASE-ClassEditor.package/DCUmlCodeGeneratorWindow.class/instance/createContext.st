actions
createContext
	| context |
	context := DCUmlCodeGeneratorContext new.
	context
		category: self categoryInput text;
		prefix: self prefixInput text;
		clashPrefix: self clashPrefixInput text.
	self accessorsCheckbox state
		ifTrue: [ context withAccessors ]
		ifFalse: [ context withoutAccessors ].
	self lazyInitialization state
		ifTrue: [ context useLazyInitialization ]
		ifFalse: [ context useEagerInitialization ].
	self methodsCheckbox state
		ifTrue: [ context overrideMethods ]
		ifFalse: [ context doNotOverrideMethods ].
	context withProgressBar.
	^ context