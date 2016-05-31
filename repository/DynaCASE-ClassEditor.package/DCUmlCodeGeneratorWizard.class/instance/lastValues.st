accessing
lastValues
	^ LastValues
		ifNil: [ {#package -> 'Unclassified'.
			#classPrefix -> ''.
			#conflictPrefix -> ''.
			#addAccessors -> true.
			#overrideMethods -> true.
			#initializationType -> #lazy} asDictionary ]