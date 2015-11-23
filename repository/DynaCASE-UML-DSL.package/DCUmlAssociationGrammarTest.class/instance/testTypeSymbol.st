tests
testTypeSymbol
	self parse: '-' rule: #typeSymbol.
	self parse: '<>' rule: #typeSymbol.
	self parse: '<*>' rule: #typeSymbol