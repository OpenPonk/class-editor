accessing
typeSymbol
	^ super typeSymbol
		==>
			[ :symbol | 
			Array
				with:
					({($- -> DCUmlAggregationKind none).
					('<>' -> DCUmlAggregationKind shared).
					('<*>' -> DCUmlAggregationKind composite)} asDictionary at: symbol)
				with: false ]