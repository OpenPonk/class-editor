actions
importWith: aDictionary
	| pkgs allClasses filtered newModel |
	pkgs := (aDictionary at: #packagesSelected) collect: #asPackage.
	allClasses := pkgs flatCollect: #regularClasses.
	filtered := allClasses reject: [ :each | each isKindOf: TestCase ].
	newModel := DCCormasVWImporter new importFromClasses: filtered.
	self replaceModel: model with: newModel.
	model announcer announce: (DCModelContentReplaced model: model)