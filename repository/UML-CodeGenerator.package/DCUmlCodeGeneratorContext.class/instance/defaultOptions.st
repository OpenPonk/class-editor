initialization
defaultOptions
	self package: #Unclassified.
	self prefix: ''.
	self conflictPrefix: ''.
	self withProgressBar.
	self withAccessors.
	self doNotOverrideMethods.
	self useLazyInitialization