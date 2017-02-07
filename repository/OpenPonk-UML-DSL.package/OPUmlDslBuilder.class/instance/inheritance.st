accessing
inheritance
	^ (umlClassName , ('>>' asParser / 'extends' asParser) trim , umlClassName , $; asParser)
		==>
			[ :nodes | 
			FAMIXInheritance
				subclass: (FAMIXClass named: nodes first)
				superclass: (FAMIXClass named: nodes third) ]