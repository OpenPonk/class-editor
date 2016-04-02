postprocessing
processClassSideFor: aClass
	aClass attributes
		do: [ :each | 
			(each name beginsWith: SmalltalkImporter CIVString)
				ifTrue: [ each name: (each name withoutPrefix: SmalltalkImporter CIVString).
					each isStatic: true ] ].
	aClass methods do: [ :each | each isStatic: each hasClassScope ]