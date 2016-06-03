as yet unclassified
testCreateContext
	| dict context |
	dict := {#package -> 'Target'.
	#alwaysUsePrefix -> true.
	#addAccessors -> true.
	#overrideMethods -> true.
	#classPrefix -> 'Cls'.
	#initializationType -> #lazy} asDictionary.
	context := DCUmlCodeGeneratorWizard new createContextFrom: dict.
	self assert: context package equals: 'Target'.
	self assert: context shouldAddAccessors.
	self assert: context shouldOverrideMethods.
	self assert: context prefix equals: 'Cls'.
	self assert: context shouldAlwaysUsePrefix.
	self assert: context shouldUseLazyInitialization.
	self deny: context shouldUseEagerInitialization