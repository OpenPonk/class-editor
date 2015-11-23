accessing
famixClass
	^ dslName ==> [ :nodes | (FAMIXClass named: nodes first) isAbstract: nodes second ]