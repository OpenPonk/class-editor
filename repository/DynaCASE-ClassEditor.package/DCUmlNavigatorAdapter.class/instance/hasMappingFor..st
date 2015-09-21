accessing
hasMappingFor: anObject
	^ (anObject className beginsWith: 'DCUml') | (anObject isKindOf: MooseEntity)