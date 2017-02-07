accessing
lastValues
	^ LastValues
		ifNil: [ {#package -> 'Unclassified'.
			#classPrefix -> ''.
			#alwaysUsePrefix -> false.
			#addAccessors -> true.
			#accessorsStyle -> #simple.
			#overrideMethods -> true.
			#initializationType -> #lazy} asDictionary ]