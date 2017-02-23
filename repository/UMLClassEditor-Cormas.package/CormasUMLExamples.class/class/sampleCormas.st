as yet unclassified
sampleCormas
	^ OPUmlDslParser
		parse:
			'
MyECEC <<CormasModel>> {
	
}

/Forager <<Agent>> {
	_catabolicRate = 2
	_fertilityThreshold = 100
	_harvestRate
	energy = 50
}

Restrained >> Forager;

MyECEC --> theRestraineds Restrained[*];'