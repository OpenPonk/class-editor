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

	| packagedElements |
	packagedElements := self model packagedElements.
	^ (packagedElements select: [ :each | each oclIsKindOf: #Type ])
	  , packagedElements flatCollectAsSet: [ :each |
		  (self registry viewModelFor: each) allTypeElements ]
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
	| deps rootModel |
	"super dependentElements correctly resolves through childrenModels down to packagedElements"
	deps := super dependentElements asSet.
	
	rootModel := self model owner.
	[ rootModel isNotNil and: [ (rootModel isKindOf: OPUMLPackage) not ] ] whileTrue: [
		rootModel := rootModel owner ].
	
	rootModel ifNotNil: [
		rootModel packagedElements do: [ :each |
			((#(OPUMLPackage OPUMLProfile OPUMLModel) anySatisfy: [ :type | each isKindOf: (Smalltalk at: type) ])
				and: [ each respondsTo: #packageImports ])
				ifTrue: [
					deps addAll: (each packageImports select: [ :import |
						import importedPackage = self model ]) ] ]
	].
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
		accessor: (MAPluggableAccessor
			read: [ :me | me model profileApplications collect: #appliedProfile ]
			write: [ :me :selectedProfiles |
				me model profileApplications: (me model profileApplications select: [ :any | selectedProfiles includes: any appliedProfile ]).
				me model profileApplications: me model profileApplications , (selectedProfiles
					select: [ :eachSelectedProfile |
						me model profileApplications noneSatisfy: [ :eachExistingProfileApplication |
							eachExistingProfileApplication = eachSelectedProfile ] ]
					thenCollect: [ :each | OPUMLProfileApplication new appliedProfile: each yourself ]).
				
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
OPUmlPackageViewModel >> essentialChildrenModels [
	| queue priority |
	"Only return inner elements if this package is acting as the root model/diagram"
	self modelRootViewModel == self ifFalse: [ ^ #() ].
	
	queue := OrderedCollection new.
	priority := { (OPUMLPackage -> 1). (OPUMLProfile -> 1). (OPUMLClass -> 2). (OPUMLStereotype -> 3). (OPUMLEnumeration -> 4) } asDictionary.
	
	queue addAll: (self model packagedElements reject: [ :each | each oclIsKindOf: #Association ]).
	
	self model packagedElements select: [ :each | each oclIsKindOf: #Package ] thenDo: [ :each |
		each packageImports do: [ :import | queue addIfNotPresent: import importedPackage. queue add: import ] ].
				
	self model packagedElements select: [ :each | (each isKindOf: OPUMLClass) | (each isKindOf: OPUMLStereotype) ] thenDo: [ :each |
		each generalizations do: [ :gen | queue addIfNotPresent: gen general. queue add: gen ].
		(each ownedAttributes select: [ :attr | (attr isKindOf: OPUMLProperty) and: [ attr association isNotNil ] ])
			do: [ :attr | queue addIfNotPresent: attr association ] ].
				
	self model packagedElements select: [ :each | each isKindOf: OPUMLStereotype ] thenDo: [ :each |
		each ownedAttributes select: [ :attr | attr association isNotNil and: [ attr association isKindOf: OPUMLExtension ] ]
			thenDo: [ :attr | queue add: attr type ] ].
				
	^ (queue asSet asArray sorted: [ :a :b |
		(priority at: a class ifAbsent: [ 100 ]) < (priority at: b class ifAbsent: [ 100 ]) ])
]

{ #category : 'accessing' }
OPUmlPackageViewModel >> icon [ ^ OPUmlIcons packageIcon
]

{ #category : 'accessing' }
OPUmlPackageViewModel >> packageViewModel [

	^ self
]

{ #category : 'construction' }
OPUmlPackageViewModel >> registerModelIn: aParentModel [

	aParentModel packagedElements add: self model
]
