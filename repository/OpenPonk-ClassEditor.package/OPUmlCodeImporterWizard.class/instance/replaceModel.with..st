actions
replaceModel: aModel with: aNewModel
	aModel entityStorage removeAll.
	aModel addAll: aNewModel entityStorage.
	^ aModel