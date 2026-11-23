"
Tests view model representations, containment semantics, and headers for UML packages.
"
Class {
	#name : 'OPUmlPackageViewModelTest',
	#superclass : 'OPAbstractViewModelTest',
	#category : 'OpenPonk-ClassEditor-Tests-ViewModels',
	#package : 'OpenPonk-ClassEditor-Tests',
	#tag : 'ViewModels'
}

{ #category : 'constants' }
OPUmlPackageViewModelTest >> modelClass [

	^ OPUMLPackage
]

{ #category : 'initialization' }
OPUmlPackageViewModelTest >> newModel [

	^ OPUMLPackage new
		  name: 'SubPackage';
		  yourself
]

{ #category : 'initialization' }
OPUmlPackageViewModelTest >> newRootModel [

	^ OPUMLPackage new
		  name: 'RootPackage';
		  yourself
]

{ #category : 'tests' }
OPUmlPackageViewModelTest >> testAllPackagesInRecursively [

	| childPackage grandChildPackage allNested |
	childPackage := OPUMLPackage new name: 'Child'.
	grandChildPackage := OPUMLPackage new name: 'GrandChild'.
	childPackage packagedElements add: grandChildPackage.
	model packagedElements add: childPackage.

	allNested := viewModel allPackagesIn: model.
	self assertCollection: allNested hasSameElements: {
			childPackage.
			grandChildPackage }
]

{ #category : 'tests' }
OPUmlPackageViewModelTest >> testAllTypeElementsWithGeneralizationSet [

	| testProject package genSet types packageViewModel testRegistry |
	testProject := OPProject new.
	package := OPUMLPackage new.
	package name: 'RootPackage'.
	testProject addModel: package.

	genSet := OPUMLGeneralizationSet new.
	genSet name: 'PowerTypeSet'.
	package packagedElements add: genSet.

	testRegistry := OPViewModelRegistry forProject: testProject.
	packageViewModel := testRegistry viewModelFor: package.

	types := packageViewModel allTypeElements.
	self assertEmpty: types
]

{ #category : 'tests' }
OPUmlPackageViewModelTest >> testAllTypeElementsWithNestedPackageAndTypes [

	| testProject rootPackage subPackage classA classB genSet types packageViewModel testRegistry |
	testProject := OPProject new.
	rootPackage := OPUMLPackage new.
	rootPackage name: 'RootPackage'.
	testProject addModel: rootPackage.

	classA := OPUMLClass new.
	classA name: 'ClassA'.
	rootPackage packagedElements add: classA.

	subPackage := OPUMLPackage new.
	subPackage name: 'SubPackage'.
	classB := OPUMLClass new.
	classB name: 'ClassB'.
	genSet := OPUMLGeneralizationSet new.
	genSet name: 'PowerTypeSet'.
	subPackage packagedElements add: classB.
	subPackage packagedElements add: genSet.
	rootPackage packagedElements add: subPackage.

	testRegistry := OPViewModelRegistry forProject: testProject.
	packageViewModel := testRegistry viewModelFor: rootPackage.

	types := packageViewModel allTypeElements.
	self assertCollection: types hasSameElements: {
			classA.
			classB }
]

{ #category : 'tests' }
OPUmlPackageViewModelTest >> testBasicRemoveModelFromParentPackageAndProject [

	| rootPackageViewModel |
	viewModel removeModel.
	self denyCollection: rootModel packagedElements includesAny: { model }.

	rootPackageViewModel := registry viewModelFor: rootModel.
	rootPackageViewModel removeModel.
	self denyCollection: project models includesAny: { rootModel }
]

{ #category : 'tests' }
OPUmlPackageViewModelTest >> testDependentElementsIncludesImportsFromSiblingProfile [

	| ownerProfile targetPackage importingProfile packageImport testProject testRegistry packageViewModel |
	ownerProfile := OPUMLProfile new name: 'OwnerProfile'.
	targetPackage := OPUMLPackage new name: 'TargetPackage'.
	importingProfile := OPUMLProfile new name: 'ImportingProfile'.
	packageImport := OPUMLPackageImport new
		                 importingNamespace: importingProfile;
		                 importedPackage: targetPackage;
		                 yourself.
	ownerProfile packagedElements add: targetPackage.
	ownerProfile packagedElements add: importingProfile.

	testProject := OPProject new.
	testProject addModel: ownerProfile.
	testRegistry := OPViewModelRegistry forProject: testProject.
	packageViewModel := testRegistry viewModelFor: targetPackage.

	self assertCollection: packageViewModel dependentElements includesAll: { packageImport }
]

{ #category : 'tests' }
OPUmlPackageViewModelTest >> testDescriptionAppliedProfilesDoesNotDuplicateExistingApplication [

	| profile description |
	profile := ClClockProfileFactory profile.
	description := viewModel descriptionAppliedProfiles.

	description accessor write: { profile } to: viewModel.
	description accessor write: { profile } to: viewModel.

	self assert: model profileApplications size equals: 1.
	self assert: model profileApplications first appliedProfile identicalTo: profile
]

{ #category : 'tests' }
OPUmlPackageViewModelTest >> testDescriptionAppliedProfilesForProfileAndPackage [

	| profileViewModel description clockProfile profileAppliedCount rebuildCount |
	profileViewModel := OPUmlProfileViewModel new model: (OPUMLProfile new
			                     name: 'MyProfile';
			                     yourself).
	self
		assert: profileViewModel descriptionAppliedProfiles isNil
		description: 'Profile itself must not expose Applied Profiles description'.

	clockProfile := ClClockProfileFactory profile.
	profileAppliedCount := 0.
	rebuildCount := 0.
	viewModel announcer when: OPUmlProfileApplied do: [ profileAppliedCount := profileAppliedCount + 1 ] for: self.
	viewModel announcer when: OPElementFormNeedsRebuild do: [ rebuildCount := rebuildCount + 1 ] for: self.

	description := viewModel descriptionAppliedProfiles.
	description accessor write: { clockProfile } to: viewModel.
	self assertCollection: (description accessor read: viewModel) hasSameElements: { clockProfile }.
	self assert: profileAppliedCount equals: 1.
	self assert: rebuildCount equals: 1.

	description accessor write: #(  ) to: viewModel.
	self assertEmpty: (description accessor read: viewModel).
	self assertEmpty: model profileApplications
]

{ #category : 'tests' }
OPUmlPackageViewModelTest >> testDescriptionGeneralizationSets [
	"Verifies that descriptionGeneralizationSets provides read-only to-many description with correct label"

	| umlPackage packageViewModel description |
	umlPackage := OPUMLPackage new name: 'TestPackage'.
	packageViewModel := OPUmlPackageViewModel new model: umlPackage.

	description := packageViewModel descriptionGeneralizationSets.

	self assert: description label equals: 'Generalization Sets'.
	self assert: description isReadOnly description: 'Generalization Sets description must be read-only'.
	self assert: description priority equals: 20
]

{ #category : 'tests' }
OPUmlPackageViewModelTest >> testDescriptionGeneralizationSetsReadAndWriteError [

	| genSet description |
	genSet := OPUMLGeneralizationSet new name: 'MySet'.
	model packagedElements add: genSet.
	description := viewModel descriptionGeneralizationSets.

	self assertCollection: (description accessor read: viewModel) hasSameElements: { genSet }.
	self should: [ description accessor write: #(  ) to: viewModel ] raise: Error
]

{ #category : 'tests' }
OPUmlPackageViewModelTest >> testIsSystemElementCases [

	| commonPackage commonViewModel |
	self deny: viewModel isSystemElement description: 'Regular package is not a system element'.

	commonPackage := OPUMLPackage new name: OPUmlCommonTypesFactory commonTypesPackageName.
	commonViewModel := OPUmlPackageViewModel new model: commonPackage.
	self deny: commonViewModel isSystemElement description: 'Empty CommonTypes package is not a system element'.

	commonPackage packagedElements add: (OPUMLClass new
			 name: 'NotADataType';
			 yourself).
	self deny: commonViewModel isSystemElement description: 'CommonTypes containing a Class is not a system element'.

	commonPackage packagedElements removeAll.
	commonPackage packagedElements add: (OPUMLDataType new
			 name: 'CustomOnlyType';
			 yourself).
	self deny: commonViewModel isSystemElement description: 'CommonTypes without known common type names is not a system element'.

	commonPackage packagedElements add: (OPUMLDataType new
			 name: OPUmlCommonTypesFactory typeNames anyOne;
			 yourself).
	self assert: commonViewModel isSystemElement description: 'CommonTypes with known common DataType is a system element'
]

{ #category : 'tests' }
OPUmlPackageViewModelTest >> testRegisterModelInPackageAndProject [

	| newPackage newViewModel targetPackage targetProject |
	newPackage := OPUMLPackage new name: 'RegisteredPkg'.
	newViewModel := OPUmlPackageViewModel new model: newPackage.
	targetPackage := OPUMLPackage new name: 'TargetPkg'.
	targetProject := OPProject new.

	newViewModel registerModelIn: targetPackage.
	self assertCollection: targetPackage packagedElements includesAll: { newPackage }.

	newViewModel registerModelIn: targetProject.
	self assertCollection: targetProject models includesAll: { newPackage }
]

{ #category : 'tests' }
OPUmlPackageViewModelTest >> testRegisterModelInRejectsUnsupportedParent [

	| unsupportedParent |
	unsupportedParent := Object new.
	self should: [ viewModel registerModelIn: unsupportedParent ] raise: AssertionFailure
]

{ #category : 'tests' }
OPUmlPackageViewModelTest >> testVisitorBuildsGeneralizationSetsEditButtonForPackageViewModel [
	"Verifies that OPPropertiesFormMagritteVisitor produces Edit Generalization Sets button for OPUmlPackageViewModel description"

	| umlPackage packageViewModel form visitor editButton |
	umlPackage := OPUMLPackage new name: 'TestPackage'.
	packageViewModel := OPUmlPackageViewModel new model: umlPackage.

	form := OPPropertiesForm new.
	visitor := OPPropertiesFormMagritteVisitor new.
	visitor form: form.
	visitor viewModel: packageViewModel.

	visitor visitToManyRelationDescription: packageViewModel descriptionGeneralizationSets.

	editButton := form components
		              detect: [ :eachComponent |
		              eachComponent class == SpButtonPresenter and: [ eachComponent label = 'Edit Generalization Sets' ] ]
		              ifNone: [ nil ].

	self assert: editButton class equals: SpButtonPresenter.
	self assert: editButton label equals: 'Edit Generalization Sets'
]

{ #category : 'constants' }
OPUmlPackageViewModelTest >> viewModelClass [

	^ OPUmlPackageViewModel
]
