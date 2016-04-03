postprocessing
processClassSideFor: aClass
	aClass attributes
		select: [ :each | each name beginsWith: SmalltalkImporter CIVString ]
		thenDo: [ :each | 
			each name: (each name withoutPrefix: SmalltalkImporter CIVString).
			each isStatic: true ].
	aClass methods do: [ :each | each isStatic: each hasClassScope ]