postprocessing
processClassSide: aModel
	aModel allClasses do: [ :each | self processClassSideFor: each ].