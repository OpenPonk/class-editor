postprocessing
processClassSide: aModel
	aModel allModelClasses do: [ :each | self processClassSideFor: each ].