as yet unclassified
visitNameFor: aName
	^ ('visit' , (aName copyReplaceAll: ':' with: '') capitalized , ':') asSymbol