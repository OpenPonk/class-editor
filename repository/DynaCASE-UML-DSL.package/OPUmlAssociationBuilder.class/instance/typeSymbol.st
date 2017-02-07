accessing
typeSymbol
	^ super typeSymbol
		==>
			[ :symbol | 
			Array
				with:
					({($- -> OPUmlAggregationKind none).
					('<>' -> OPUmlAggregationKind shared).
					('<*>' -> OPUmlAggregationKind composite)} asDictionary at: symbol)
				with: false ]