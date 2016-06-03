accessing
lastValues
	^ LastValues
		ifNil: [ {#package -> 'Unclassified'.
			#classPrefix -> ''.
			#alwaysUsePrefix -> false.
			#addAccessors -> true.
			#overrideMethods -> true.
			#initializationType -> #lazy} asDictionary ]