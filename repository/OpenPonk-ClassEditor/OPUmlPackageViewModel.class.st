"
I am the ViewModel for UML Packages. I manage contained elements, applied profiles, generalization sets, and hierarchical relationships within the model.
"
Class {
	#name : 'OPUmlPackageViewModel',
	#superclass : 'OPUmlElementViewModel',
	#traits : 'OPTUmlPackageableElementViewModel',
	#classTraits : 'OPTUmlPackageableElementViewModel classTrait',
	#category : 'OpenPonk-ClassEditor-ViewModels',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'ViewModels'
}

{ #category : 'accessing' }
OPUmlPackageViewModel class >> modelClass [ ^ OPUMLPackage
]

{ #category : 'enumerating' }
OPUmlPackageViewModel >> allGeneralizationSets [
	^ self allPackages flatCollectAsSet: [ :eachPackage |
		(eachPackage packagedElements select: [ :each | each oclIsKindOf: #GeneralizationSet ])
		, (((eachPackage packagedElements select: [ :any | any oclIsKindOf: #Classifier ]) 
				flatCollect: [ :eachClassifier | eachClassifier generalizations ])
					flatCollect: [ :each | each generalizationSets ]) ]
]

{ #category : 'enumerating' }
OPUmlPackageViewModel >> allPackages [
	^ (Set with: self model) , (self allPackagesIn: self model)
]

{ #category : 'enumerating' }
OPUmlPackageViewModel >> allPackagesIn: aPackage [
	| innerPackages |
	innerPackages := aPackage packagedElements select: [ :each | each oclIsKindOf: #Package ].
	^ innerPackages asSet , (innerPackages flatCollectAsSet: [ :each | self allPackagesIn: each ])
]

{ #category : 'enumerating' }
OPUmlPackageViewModel >> allTypeElements [
	| packagedElements nestedPackages types |
	packagedElements := self model packagedElements.
	types := (packagedElements select: [ :each | each oclIsKindOf: #Type ]) asSet.
	nestedPackages := packagedElements select: [ :each | each oclIsKindOf: #Package ].
	nestedPackages do: [ :eachPackage |
		types addAll: (self registry viewModelFor: eachPackage) allTypeElements ].
	^ types
]

{ #category : 'private' }
OPUmlPackageViewModel >> basicRemoveModel [
	self parentPackageViewModel
		ifNotNil: [ :packageViewModel |
			packageViewModel model ifNotNil: [ :packageModel |
				packageModel packagedElements remove: self model ifAbsent: [ ] ] ]
		ifNil: [
			self projectViewModel ifNotNil: [ :projectViewModel |
				projectViewModel model ifNotNil: [ :project |
					project removeModel: self model ] ] ]
]

{ #category : 'accessing' }
OPUmlPackageViewModel >> childrenModels [

	^ OrderedCollection streamContents: [ :s |
			  s nextPutAll: (self model packagedElements reject: [ :any |
					   any oclIsKindOf: #GeneralizationSet ]).
			  (self model respondsTo: #packageImports) ifTrue: [
				  s nextPutAll: self model packageImports ] ]
]

{ #category : 'construction' }
OPUmlPackageViewModel >> createModelIn: aParentModel [

	super createModelIn: aParentModel.
	self model name: (self model oclClassifierNameFrom: self model class).
	^ self model
]

{ #category : 'accessing' }
OPUmlPackageViewModel >> dependentElements [

	| deps rootViewModel |
	"super dependentElements correctly resolves through childrenModels down to packagedElements"
	deps := super dependentElements asSet reject: [ :any | any oclIsKindOf: #Association ].
	rootViewModel := self modelRootViewModel.
	(rootViewModel isKindOf: OPUmlPackageViewModel) ifTrue: [
			rootViewModel allPackages do: [ :eachPackage |
				deps addAll: (eachPackage packageImports select: [ :import | import importedPackage = self model ]) ] ].
	^ deps asArray
]

{ #category : 'forms' }
OPUmlPackageViewModel >> descriptionAppliedProfiles [

	<magritteDescription>
	| profiles options |
	(self model oclIsKindOf: #Profile) ifTrue: [ ^ nil ].
	profiles := OPUmlCustomProfile allSubclasses collect: #profile.
	options := profiles collect: [ :each | each -> each name ].
	^ MAMultipleOptionDescription new
		  optionsAndLabels: options;
		  distinct: true;
		  reference: MAStringDescription new;
		  accessor:
			  (MAPluggableAccessor read: [ :me | me model profileApplications collect: #appliedProfile ] write: [ :me :selectedProfiles |
						   me model profileApplications:
								   (me model profileApplications select: [ :any | selectedProfiles includes: any appliedProfile ]).
						   me model profileApplications: me model profileApplications , (selectedProfiles
										    select: [ :eachSelectedProfile |
												    me model profileApplications noneSatisfy: [ :eachExistingProfileApplication |
														    eachExistingProfileApplication appliedProfile = eachSelectedProfile ] ]
										    thenCollect: [ :each |
												    OPUMLProfileApplication new
													    appliedProfile: each;
													    yourself ]).
						   self announcer announce: OPUmlProfileApplied new.
						   self announcer announce: OPElementFormNeedsRebuild new.
						   self modelChanged ]);
		  label: 'Applied Profiles';
		  priority: 10;
		  beSorted;
		  yourself
]

{ #category : 'forms' }
OPUmlPackageViewModel >> descriptionGeneralizationSets [
	<magritteDescription>
	^ MAToManyRelationDescription new
		readOnly: true;
		accessor: (MAPluggableAccessor
			read: [ :me | self allGeneralizationSets ]
			write: [ :me :newValue | self error: 'Direct manipulation only via ', OPUmlAllGeneralizationSetsEditor name ]);
		label: 'Generalization Sets';
		priority: 20;
		yourself
]

{ #category : 'forms' }
OPUmlPackageViewModel >> descriptionStereotype [

	<magritteDescription>
	^ self descriptionStereotypeContent
]

{ #category : 'accessing' }
OPUmlPackageViewModel >> icon [ ^ OPUmlIcons packageIcon
]

{ #category : 'testing' }
OPUmlPackageViewModel >> isSystemElement [
	self model name = OPUmlCommonTypesFactory commonTypesPackageName
		ifFalse: [ ^ false ].
	self model packagedElements ifEmpty: [ ^ false ].
	(self model packagedElements allSatisfy: [ :eachModelElement |
		eachModelElement oclIsTypeOf: #DataType ])
			ifFalse: [ ^ false ].
	^ self model packagedElements anySatisfy: [ :eachModelElement |
		OPUmlCommonTypesFactory typeNames includes: eachModelElement name ]
]

{ #category : 'actions' }
OPUmlPackageViewModel >> openEditorWithApplication: anApplication undoManager: anUndoManager [
	| editor |
	editor := OPUmlAllGeneralizationSetsEditor new.
	anApplication ifNotNil: [ :activeApplication | editor application: activeApplication ].
	anUndoManager ifNotNil: [ :activeUndoManager | editor undoManager: activeUndoManager ].
	editor viewModel: self.
	editor openModal.
	self modelChanged
]

{ #category : 'accessing' }
OPUmlPackageViewModel >> packageViewModel [

	^ self
]
