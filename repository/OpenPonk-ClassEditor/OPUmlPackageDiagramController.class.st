"
I am controller for managing the main class diagram presentation and handling items contained in the canvas.
"
Class {
	#name : 'OPUmlPackageDiagramController',
	#superclass : 'OPDiagramController',
	#traits : 'OPTUmlStereotypedElementController',
	#classTraits : 'OPTUmlStereotypedElementController classTrait',
	#category : 'OpenPonk-ClassEditor-Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Controllers'
}

{ #category : 'as yet unclassified' }
OPUmlPackageDiagramController >> allShowableElements [
	"Should return all elements that could be directly hidden on diagram"

	^ Array streamContents: [ :stream |
		  self allShowableElementsIn: self model on: stream ]
]

{ #category : 'as yet unclassified' }
OPUmlPackageDiagramController >> allShowableElementsIn: aPackage on: aCollectionStream [
	"Should return all elements that could be directly hidden on diagram"

	| elementsToShow |
	elementsToShow := self elementsToShowInside: aPackage.
	aCollectionStream nextPutAll: elementsToShow.
	elementsToShow
		select: [ :each | each oclIsKindOf: #Class ]
		thenDo: [ :each |
			aCollectionStream nextPutAll: each ownedAttributes.
			aCollectionStream nextPutAll: each ownedOperations ].
	elementsToShow
		select: [ :each | each oclIsKindOf: #Enumeration ]
		thenDo: [ :each | aCollectionStream nextPutAll: each ownedLiterals ].
	aCollectionStream nextPutAll:
		(aPackage packagedElements select: [ :each |
			 each oclIsKindOf: #Association ]).
	aPackage packagedElements
		select: [ :each | each oclIsKindOf: #Package ]
		thenDo: [ :each |
		self allShowableElementsIn: each on: aCollectionStream ]
]

{ #category : 'adding' }
OPUmlPackageDiagramController >> canBeTargetFor: aController [
	^ (super canBeTargetFor: aController)
		or: [ (aController isKindOf: OPUmlClassController)
				or: [ (aController isKindOf: OPUmlPackageController)
						or: [ aController isKindOf: OPUmlEnumerationController ] ] ]
]

{ #category : 'as yet unclassified' }
OPUmlPackageDiagramController >> commonModelClassPrefix [
	^ 'OPUML'
]

{ #category : 'adding' }
OPUmlPackageDiagramController >> controllerFactory [
	^ super controllerFactory
		register: OPUmlClassController forModel: OPUMLClass;
		register: OPUmlAttributeController forModel: OPUMLProperty;
		register: OPUmlOperationController forModel: OPUMLOperation;
		register: OPUmlGeneralizationController
			forModel: OPUMLGeneralization;
		register: OPUmlAssociationController forModel: OPUMLAssociation;
		register: OPUmlPackageController forModel: OPUMLPackage;
		register: OPUmlPackageController forModel: OPUMLProfile;
		register: OPUmlExtensionController forModel: OPUMLExtension;
		register: OPUmlAttributeController forModel: OPUMLExtensionEnd;
		register: OPUmlEnumerationController forModel: OPUMLEnumeration;
		register: OPUmlEnumerationLiteralController
			forModel: OPUMLEnumerationLiteral;
		register: OPUmlStereotypeController forModel: OPUMLStereotype;
		register: OPUmlPackageImportController forModel: OPUMLPackageImport
]

{ #category : 'forms' }
OPUmlPackageDiagramController >> descriptionAppliedProfiles [

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
				   read: [ :me |
					   me model profileApplications collect: #appliedProfile ]
				   write: [ :me :selectedProfiles |
					   me model profileApplications:
							   (me model profileApplications select: [ :any |
									    selectedProfiles includes: any appliedProfile ]).
					   me model profileApplications:
							   me model profileApplications , (selectedProfiles
									    select: [ :eachSelectedProfile |
										    me model profileApplications noneSatisfy: [
												    :eachExistingProfileApplication |
												    eachExistingProfileApplication = eachSelectedProfile ] ]
									    thenCollect: [ :each |
										    OPUMLProfileApplication new appliedProfile:
												    each yourself ]).
					   self rebuildPalette.
					   self diagramElement modelChanged ]);
		  label: 'Applied Profiles';
		  priority: 10;
		  beSorted;
		  yourself
]

{ #category : 'as yet unclassified' }
OPUmlPackageDiagramController >> descriptionStereotype [

	<magritteDescription>
	^ self descriptionStereotypeContent
]

{ #category : 'userinterface' }
OPUmlPackageDiagramController >> disableRefresh [
	| install |
	self flag: #todo.
	install := [ :cls | 
	| link |
	(cls includesSelector: #refreshFigure)
		ifTrue:
			[ link := MetaLink new
				metaObject: self;
				selector: #yourself;
				arguments: #();
				control: #instead.
			(cls >> #refreshFigure) ast link: link ] ].
	OPUmlElementController withAllSubAndSuperclassesDo: [ :each | install value: each ]
]

{ #category : 'figures' }
OPUmlPackageDiagramController >> elementsToShowInside [

	^ self elementsToShowInside: self model
]

{ #category : 'figures' }
OPUmlPackageDiagramController >> elementsToShowInside: aPackage [

	| queue priority |
	queue := OrderedCollection new.
	priority := {
		            (OPUMLPackage -> 1).
		            (OPUMLProfile -> 1).
		            (OPUMLClass -> 2).
		            (OPUMLStereotype -> 3).
		            (OPUMLEnumeration -> 4) } asDictionary.
	queue addAll: (aPackage packagedElements reject: [ :each |
			 each oclIsKindOf: #Association ]).
	aPackage packagedElements
		select: [ :each | each oclIsKindOf: #Package ]
		thenDo: [ :each |
			each packageImports do: [ :import |
				queue addIfNotPresent: import importedPackage.
				queue add: import ] ].
	aPackage packagedElements
		select: [ :each |
			(each isKindOf: OPUMLClass) | (each isKindOf: OPUMLStereotype) ]
		thenDo: [ :each |
			each generalizations do: [ :gen |
				queue addIfNotPresent: gen general.
				queue add: gen ].
			(each ownedAttributes select: [ :attr |
				 (attr isKindOf: OPUMLProperty) and: [ attr association isNotNil ] ])
				do: [ :attr | queue addIfNotPresent: attr association ] ].
	aPackage packagedElements
		select: [ :each | each isKindOf: OPUMLStereotype ]
		thenDo: [ :each |
			each ownedAttributes
				select: [ :attr |
					attr association isNotNil and: [
						attr association isKindOf: OPUMLExtension ] ]
				thenDo: [ :attr | queue add: attr type ] ].
	^ (queue asSet asArray sorted: [ :a :b |
		   (priority at: a class ifAbsent: [ 100 ])
		   < (priority at: b class ifAbsent: [ 100 ]) ]) select: [ :each |
		  self hasSupportForModel: each ]
]

{ #category : 'userinterface' }
OPUmlPackageDiagramController >> enableRefresh [
	| uninstall |
	self flag: #todo.
	uninstall := [ :cls | 
	(cls includesSelector: #refreshFigure)
		ifTrue: [ (cls >> #refreshFigure) ast links
				ifNotNil: [ :l | l asSet do: #uninstall ] ] ].
	OPUmlElementController
		withAllSubAndSuperclassesDo: [ :each | uninstall value: each ]
]

{ #category : 'palette' }
OPUmlPackageDiagramController >> initializePackagePalette: aPalette [
	aPalette newSeparator.
	(aPalette newConnectionCreationTool: [ OPUmlPackageImportController new ])
		label: 'Package Import';
		icon: OPUmlIcons directedAssociationIcon.
	(aPalette newCreationEntry: [ OPUmlPackageController new beForPackage ])
		label: 'Package';
		icon: OPUmlIcons packageIcon;
		whenCreatedSetup.
	(aPalette newCreationEntry: [ OPUmlPackageController new beForModel ])
		label: 'Model';
		icon: OPUmlIcons modelIcon;
		whenCreatedSetup.
	(aPalette newCreationEntry: [ OPUmlPackageController new beForProfile ])
		label: 'Profile';
		icon: OPUmlIcons profileIcon;
		whenCreatedSetup
]

{ #category : 'palette' }
OPUmlPackageDiagramController >> initializePalette: aPalette [
	(aPalette newCreationEntry: [ OPUmlClassController new ])
		label: 'Class';
		icon: OPUmlIcons classIcon;
		shortcut: $c asShortcut;
		whenCreatedSetup.
	(aPalette newCreationEntry: [ OPUmlAttributeController new ])
		label: 'Attribute';
		icon: OPUmlIcons attributeIcon;
		shortcut: $a asShortcut;
		whenCreatedSetup.
	(aPalette newCreationEntry: [ OPUmlOperationController new ])
		label: 'Operation';
		icon: OPUmlIcons operationIcon;
		shortcut: $o asShortcut;
		whenCreatedSetup.
	aPalette newSeparator.
	(aPalette newConnectionCreationTool: [ OPUmlAssociationController new ])
		label: 'Association';
		shortcut: $s asShortcut;
		icon: OPUmlIcons directedAssociationIcon.
	(aPalette newConnectionCreationTool: [ OPUmlGeneralizationController new ])
		label: 'Generalization';
		shortcut: $g asShortcut;
		icon: OPUmlIcons generalizationIcon.
	aPalette newSeparator.
	(aPalette newCreationEntry: [ OPUmlEnumerationController new ])
		label: 'Enumeration';
		icon: OPUmlIcons enumIcon;
		whenCreatedSetup.
	(aPalette newCreationEntry: [ OPUmlEnumerationLiteralController new ])
		label: 'Enumeration Literal';
		icon: OPUmlIcons literalIcon;
		whenCreatedSetup.
	self initializeProfileModelingPalette: aPalette.
	self initializeProfilesPalette: aPalette.
	self initializePackagePalette: aPalette
]

{ #category : 'palette' }
OPUmlPackageDiagramController >> initializeProfile: aProfile palette: aPalette [

	| stereotypes elements relationships isForRelationship isForClass |
	stereotypes := (aProfile ownedStereotype reject: #isAbstract) 
		               sorted: [ :a :b | a name < b name ].
	isForRelationship := [ :attr | 
	                     (OPUMLXMISpecsStorage metaClassNamed:
		                      attr type name) allParents anySatisfy: [ 
		                     :parent | parent name = 'Relationship' ] ].
	isForClass := [ :attr | 
	              | metaclass |
	              metaclass := OPUMLXMISpecsStorage metaClassNamed:
		                           attr type name.
	              metaclass name = 'Class' or: [ 
		              metaclass allParents anySatisfy: [ :parent | 
			              parent name = 'Class' ] ] ].
	elements := stereotypes select: [ :each | 
		            each allAttributes anySatisfy: [ :attr | 
			            (attr name beginsWith: 'base_') and: [ 
				            isForClass value: attr ] ] ].
	relationships := stereotypes select: [ :each | 
		                 each allAttributes anySatisfy: [ :attr | 
			                 (attr name beginsWith: 'base_') and: [ 
				                 isForRelationship value: attr ] ] ].
	elements ifNotEmpty: [ aPalette newSeparator ].
	elements do: [ :stereotype | 
		(aPalette newCreationEntry: [ OPUmlClassController new ])
			label: stereotype name;
			icon: OPUmlIcons classIcon;
			whenCreated: [ :ctrl | 
				ctrl model applyStereotype: stereotype implementationClass new.
				ctrl model name: stereotype name.
				ctrl diagramElement modelChanged.
				OPInitialSetElementCommand executeOn: ctrl.
				ctrl diagramElement modelChanged ] ].
	relationships ifNotEmpty: [ aPalette newSeparator ].
	relationships do: [ :stereotype | 
		(aPalette newConnectionCreationEntry: [ 
				 OPUmlAssociationController new ])
			label: stereotype name;
			icon: OPUmlIcons directedAssociationIcon;
			whenCreated: [ :ctrl | 
				ctrl model applyStereotype: stereotype implementationClass new.
				ctrl diagramElement modelChanged ] ]
]

{ #category : 'palette' }
OPUmlPackageDiagramController >> initializeProfileModelingPalette: aPalette [
	(self model oclIsKindOf: #Profile)
		ifFalse: [ ^ self ].
	aPalette newSeparator.
	(aPalette newCreationEntry: [ OPUmlStereotypeController new ])
		label: 'Stereotype';
		icon: OPUmlIcons stereotypeIcon;
		whenCreatedSetup.
	(aPalette newConnectionCreationTool: [ OPUmlExtensionController new ])
		label: 'Extension';
		icon: OPUmlIcons extensionIcon
]

{ #category : 'palette' }
OPUmlPackageDiagramController >> initializeProfilesPalette: aPalette [

	model profileApplications do: [ :each | 
		self initializeProfile: each appliedProfile palette: aPalette ]
]

{ #category : 'destruction' }
OPUmlPackageDiagramController >> packageRenderChanged [

	self propagatePackageRenderChangedIn: self model
]

{ #category : 'destruction' }
OPUmlPackageDiagramController >> propagateBlock: aBlock toNodeControllersIn: aPackage [

	aPackage packagedElements
		select: [ :each | each oclIsKindOf: #Classifier ]
		thenDo: [ :each |
			self
				controllerForModel: each
				ifFound: [ :aController | aBlock value: aController ] ].
	aPackage packagedElements
		select: [ :each | each oclIsKindOf: #Package ]
		thenDo: [ :each |
			self
				controllerForModel: each
				ifFound: [ :aController | aBlock value: aController ].
			self propagateBlock: aBlock toNodeControllersIn: each ]
]

{ #category : 'destruction' }
OPUmlPackageDiagramController >> propagatePackageRenderChangedIn: aPackage [

	self
		propagateBlock: [ :each | each packageRenderChanged ]
		toNodeControllersIn: aPackage
]

{ #category : 'actions' }
OPUmlPackageDiagramController >> pushBack [
	"do nothing"

	
]

{ #category : 'palette' }
OPUmlPackageDiagramController >> rebuildPalette [

	self editor palette createPaletteFor: self.
	self editor palette rebuildWidget
]

{ #category : 'as yet unclassified' }
OPUmlPackageDiagramController >> typeOfModel: aModel [
	^ OPModelObjectType
		named: (aModel umlClassName splitOnCapitals joinUsing: ' ')
		withSubtype:
			(aModel appliedStereotypes
				ifEmpty: [ OPModelObjectType named: '(without stereotype)' ]
				ifNotEmpty: [ OPModelObjectType
						named:
							(aModel appliedStereotypes first umlClassName splitOnCapitals
								joinUsing: ' ') ])
]
