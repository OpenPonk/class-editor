transforming - accessors
setterFor: aFamixEntity
	^ FAMIXMethod new
		name: aFamixEntity name, ':';
		protocol: 'accessing';
		sourceAnchor: (self setterSourceFor: aFamixEntity)