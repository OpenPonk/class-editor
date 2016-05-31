as yet unclassified
testCreateContext
	| dict context |
	dict := {#package -> 'Target'.
	#addAccessors -> true.
	#overrideMethods -> true.
	#classPrefix -> 'Cls'.
	#conflictPrefix -> 'X'.
	#initializationType -> #lazy} asDictionary.
	context := DCUmlCodeGeneratorWizard new createContextFrom: dict.
	self assert: context package equals: 'Target'.
	self assert: context shouldAddAccessors.
	self assert: context shouldOverrideMethods.
	self assert: context prefix equals: 'Cls'.
	self assert: context conflictPrefix equals: 'X'.
	self assert: context shouldUseLazyInitialization.
	self deny: context shouldUseEagerInitialization