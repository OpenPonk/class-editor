transforming - accessors
adderFor: aFamixEntity
	^ FAMIXMethod new
		name: 'add' , aFamixEntity name asEnglishSingular capitalized , ':';
		protocol: 'adding/removing';
		sourceAnchor: (self adderSourceFor: aFamixEntity)