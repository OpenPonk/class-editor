initialization
defaultOptions
	self package: #Unclassified.
	self prefix: ''.
	alwaysUsePrefix := false.
	self accessorsStyle: #simple.
	self withProgressBar.
	self withAccessors.
	self doNotOverrideMethods.
	self useLazyInitialization