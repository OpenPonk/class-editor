transforming - accessors
removerFor: aFamixEntity
	^ FAMIXMethod new
		name: 'remove' , aFamixEntity name asEnglishSingular capitalized , ':';
		protocol: 'adding/removing';
		sourceAnchor: (self removerSourceFor: aFamixEntity)