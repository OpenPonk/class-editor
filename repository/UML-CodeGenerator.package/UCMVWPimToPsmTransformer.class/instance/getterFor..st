transforming - accessors
getterFor: aFamixEntity
	^ FAMIXMethod new
		name: aFamixEntity name;
		protocol: 'accessing';
		sourceAnchor: (self getterSourceFor: aFamixEntity)