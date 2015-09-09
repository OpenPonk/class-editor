public
parametersToString: parameters
	^ (parameters collect: [ :p | p name , ' : ' , p declaredType name ]) joinUsing: ', '