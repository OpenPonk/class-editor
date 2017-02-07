visitor
visitNameFor: aName
	^ ('visit' , (aName copyReplaceAll: ':' with: '') capitalized , ':') asSymbol