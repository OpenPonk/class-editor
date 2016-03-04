grammar
rightEnd
	^ endSymbol trim
		,
			(((endName , #space asParser plus , umlClassName)
				==> [ :nodes | 
					{nodes first.
					nodes last} ]) / umlClassName) , multiplicity