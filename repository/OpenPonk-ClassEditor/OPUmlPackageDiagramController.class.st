"
I am controller for managing the main class diagram presentation and handling items contained in the canvas.
"
Class {
	#name : #OPUmlPackageDiagramController,
	#superclass : #OPDiagramController,
	#traits : 'OPTUmlBaseController',
	#classTraits : 'OPTUmlBaseController classTrait',
	#category : #'OpenPonk-ClassEditor-Controllers'
}

{ #category : #adding }
OPUmlPackageDiagramController >> addAsSourceFor: aController [
	self shouldBeImplemented
]

{ #category : #adding }
OPUmlPackageDiagramController >> addAsTargetFor: aClassController [
	self assert: (self canBeTargetFor: aClassController).
	aClassController createModelIn: self model andShowInDiagram: self
]

{ #category : #figures }
OPUmlPackageDiagramController >> allShowableElements [
	"Should return all elements that could be directly hidden on diagram"

	^ self elementsToShowInside , self diagram commonElements
		,
			((self model packagedElements
				select:
					[ :each | (each isKindOf: OPUMLClass) | (each isKindOf: OPUMLStereotype) ])
				flatCollect: [ :each | each ownedAttributes , each ownedOperations ])
		,
			((self model packagedElements
				select: [ :each | each isKindOf: OPUMLEnumeration ])
				flatCollect: [ :each | each ownedLiterals ])
]

{ #category : #adding }
OPUmlPackageDiagramController >> canBeTargetFor: aController [
	^ (super canBeTargetFor: aController)
		or: [ (aController isKindOf: OPUmlClassController)
				or: [ (aController isKindOf: OPUmlPackageController)
						or: [ aController isKindOf: OPUmlEnumerationController ] ] ]
]

{ #category : #'as yet unclassified' }
OPUmlPackageDiagramController >> commonModelClassPrefix [
	^ 'OPUML'
]

{ #category : #adding }
OPUmlPackageDiagramController >> controllerFactory [
	^ super controllerFactory
		register: OPUmlClassController forModel: OPUMLClass;
		register: OPUmlAttributeController forModel: OPUMLProperty;
		register: OPUmlOperationController forModel: OPUMLOperation;
		register: OPUmlGeneralizationController
			forModel: OPUMLGeneralization;
		register: OPUmlAssociationController forModel: OPUMLAssociation;
		register: OPUmlPackageController forModel: OPUMLPackage;
		register: OPUmlPackageController forModel: OPUMLModel;
		register: OPUmlPackageController forModel: OPUMLProfile;
		register: OPUmlExtensionController forModel: OPUMLExtension;
		register: OPUmlAttributeController forModel: OPUMLExtensionEnd;
		register: OPUmlEnumerationController forModel: OPUMLEnumeration;
		register: OPUmlEnumerationLiteralController
			forModel: OPUMLEnumerationLiteral;
		register: OPUmlStereotypeController forModel: OPUMLStereotype;
		register: OPUmlPackageImportController forModel: OPUMLPackageImport
]

{ #category : #forms }
OPUmlPackageDiagramController >> descriptionAppliedProfile [
	<magritteDescription>
	| profiles options |
	(self model oclIsKindOf: #Profile)
		ifTrue: [ ^ nil ].
	profiles := OPUmlCustomProfile allSubclasses collect: #profile.
	options := self isAppliedProfileInUse
		ifTrue: [ | current |
			current := model profileApplications first appliedProfile.
			{current -> current name} ]
		ifFalse: [ {nil -> ''} , (profiles collect: [ :each | each -> each name ]) ].
	^ MASingleOptionDescription new
		optionsAndLabels: options;
		reference: MAStringDescription new;
		accessor:
			(MAPluggableAccessor
				read: [ :me | 
					(me model profileApplications collect: #appliedProfile)
						ifEmpty: [ nil ]
						ifNotEmpty: #first ]
				write: [ :me :newValue | 
					newValue
						ifNil: [ [ me model profileApplications isNotEmpty ]
								whileTrue: [ me model profileApplications remove: me model profileApplications first ] ]
						ifNotNil: [ me model profileApplications
								ifEmpty: [ me model profileApplications
										add: (OPUMLProfileApplication new uuid: me model uuid , '-_profileApplication.0') ].
							me model profileApplications first appliedProfile: newValue ].
					self rebuildPalette.
					self refreshFigure ]);
		label: 'Applied Profile';
		priority: 10;
		beSorted;
		yourself
]

{ #category : #figures }
OPUmlPackageDiagramController >> diagramElementForModel: aModel [
	^ (self showWithoutDependentInDiagramModel: aModel) diagramElement
]

{ #category : #userinterface }
OPUmlPackageDiagramController >> disableRefresh [
	| install |
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

{ #category : #figures }
OPUmlPackageDiagramController >> elementsToShowInside [
	| queue priority |
	queue := OrderedCollection new.
	priority := {(OPUMLPackage -> 1).
	(OPUMLModel -> 1).
	(OPUMLProfile -> 1).
	(OPUMLClass -> 2).
	(OPUMLStereotype -> 3).
	(OPUMLEnumeration -> 4)} asDictionary.
	queue addAll: self model packagedElements.
	self model packagedElements
		select: [ :each | each oclIsKindOf: #Package ]
		thenDo: [ :each | 
			each packageImports
				do: [ :import | 
					queue addIfNotPresent: import importedPackage.
					queue add: import ] ].
	self model packagedElements
		select:
			[ :each | (each isKindOf: OPUMLClass) | (each isKindOf: OPUMLStereotype) ]
		thenDo: [ :each | 
			each generalizations
				do: [ :gen | 
					queue addIfNotPresent: gen general.
					queue add: gen ].
			(each ownedAttributes
				select:
					[ :attr | (attr isKindOf: OPUMLProperty) and: [ attr association isNotNil ] ])
				do: [ :attr | queue addIfNotPresent: attr association ] ].
	self model packagedElements
		select: [ :each | each isKindOf: OPUMLStereotype ]
		thenDo: [ :each | 
			each ownedAttributes
				select: [ :attr | 
					attr association isNotNil
						and: [ attr association isKindOf: OPUMLExtension ] ]
				thenDo: [ :attr | queue add: attr type ] ].
	queue
		removeAllSuchThat: [ :each | 
			(each isKindOf: OPUMLAssociation)
				and: [ each memberEnds
						anySatisfy: [ :membEnd | (queue includes: membEnd type) not ] ] ].
	^ (queue asSet asArray
		sorted: [ :a :b | 
			(priority at: a class ifAbsent: [ 100 ])
				< (priority at: b class ifAbsent: [ 100 ]) ])
		select: [ :each | self hasSupportForModel: each ]
]

{ #category : #userinterface }
OPUmlPackageDiagramController >> enableRefresh [
	| uninstall |
	uninstall := [ :cls | 
	(cls includesSelector: #refreshFigure)
		ifTrue: [ (cls >> #refreshFigure) ast links
				ifNotNil: [ :l | l asSet do: #uninstall ] ] ].
	OPUmlElementController
		withAllSubAndSuperclassesDo: [ :each | uninstall value: each ]
]

{ #category : #palette }
OPUmlPackageDiagramController >> initializePackagePalette: aPalette [
	aPalette newSeparator.
	(aPalette newConnectionCreationTool: [ OPUmlPackageImportController new ])
		label: 'Package Import';
		icon: OPUmlIcons directedAssociationIcon.
	(aPalette newCreationEntry: [ OPUmlPackageController new beForPackage ])
		label: 'Package';
		icon: OPUmlIcons packageIcon;
		whenCompletedRename.
	(aPalette newCreationEntry: [ OPUmlPackageController new beForModel ])
		label: 'Model';
		icon: OPUmlIcons modelIcon;
		whenCompletedRename.
	(aPalette newCreationEntry: [ OPUmlPackageController new beForProfile ])
		label: 'Profile';
		icon: OPUmlIcons profileIcon;
		whenCompletedRename
]

{ #category : #palette }
OPUmlPackageDiagramController >> initializePalette: aPalette [
	(aPalette newCreationEntry: [ OPUmlClassController new ])
		label: 'Class';
		icon: OPUmlIcons classIcon;
		shortcut: $c asShortcut;
		whenCompletedRename.
	(aPalette newCreationEntry: [ OPUmlAttributeController new ])
		label: 'Attribute';
		icon: OPUmlIcons attributeIcon;
		shortcut: $a asShortcut;
		whenCompletedRename.
	(aPalette newCreationEntry: [ OPUmlOperationController new ])
		label: 'Operation';
		icon: OPUmlIcons operationIcon;
		shortcut: $o asShortcut;
		whenCompletedRename.
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
		whenCompletedRename.
	(aPalette newCreationEntry: [ OPUmlEnumerationLiteralController new ])
		label: 'Enumeration Literal';
		icon: OPUmlIcons literalIcon;
		whenCompletedRename.
	self initializeProfileModelingPalette: aPalette.
	self initializeProfilePalette: aPalette.
	self initializePackagePalette: aPalette
]

{ #category : #palette }
OPUmlPackageDiagramController >> initializeProfileModelingPalette: aPalette [
	(self model oclIsKindOf: #Profile)
		ifFalse: [ ^ self ].
	aPalette newSeparator.
	(aPalette newCreationEntry: [ OPUmlStereotypeController new ])
		label: 'Stereotype';
		icon: OPUmlIcons stereotypeIcon;
		whenCompletedRename.
	(aPalette newConnectionCreationTool: [ OPUmlExtensionController new ])
		label: 'Extension';
		icon: OPUmlIcons extensionIcon
]

{ #category : #palette }
OPUmlPackageDiagramController >> initializeProfilePalette: aPalette [
	| profile stereotypes elements relationships isForRelationship |
	model profileApplications ifEmpty: [ ^ self ].
	profile := model profileApplications first appliedProfile.
	stereotypes := (profile ownedStereotype reject: #isAbstract)
		sorted: [ :a :b | a name < b name ].
	isForRelationship := [ :attr | 
	(OPUMLXMISpecsStorage metaClassNamed: attr type name) allParents
		anySatisfy: [ :parent | parent name = 'Relationship' ] ].
	elements := stereotypes
		select: [ :each | 
			each allAttributes
				anySatisfy: [ :attr | (attr name beginsWith: 'base_') and: [ (isForRelationship value: attr) not ] ] ].
	relationships := stereotypes
		select: [ :each | 
			each allAttributes
				anySatisfy: [ :attr | (attr name beginsWith: 'base_') and: [ isForRelationship value: attr ] ] ].
	aPalette newSeparator.
	elements
		do: [ :stereotype | 
			(aPalette newCreationEntry: [ OPUmlClassController new ])
				label: stereotype name;
				icon: OPUmlIcons classIcon;
				whenCompleted: [ :ctrl | 
					ctrl model applyStereotype: stereotype implementationClass new.
					ctrl model name: stereotype name.
					ctrl refreshFigure.
					OPRenameElementCommand executeOn: ctrl model.
					ctrl refreshFigure ] ].
	aPalette newSeparator.
	relationships
		do: [ :stereotype | 
			(aPalette newConnectionCreationEntry: [ OPUmlAssociationController new ])
				label: stereotype name;
				icon: OPUmlIcons directedAssociationIcon;
				whenCompleted: [ :ctrl | 
					ctrl model applyStereotype: stereotype implementationClass new.
					ctrl refreshFigure ] ]
]

{ #category : #testing }
OPUmlPackageDiagramController >> isAppliedProfileInUse [
	model profileApplications ifEmpty: [ ^ false ].
	^ model packagedElements anySatisfy: [ :each | each appliedStereotypes isNotEmpty ]
]

{ #category : #hooks }
OPUmlPackageDiagramController >> reactToAttributeWrite [
	"do nothing"
]

{ #category : #palette }
OPUmlPackageDiagramController >> rebuildPalette [
	self editor paletteModel createPaletteFor: self.
	self editor paletteModel rebuildWidget.
	self selectView
]

{ #category : #figures }
OPUmlPackageDiagramController >> selectableFigures [
	^ (self controllers select: [ :each | each isKindOf: OPUmlClassController ])
		collect: #figure
]

{ #category : #figures }
OPUmlPackageDiagramController >> showAllElements [
	self disableRefresh.
	self allShowableElements
		do: [ :each | self showWithoutDependentInDiagramModel: each ].
	self enableRefresh.
	self controllers
		select: [ :each | each isKindOf: OPUmlClassController ]
		thenDo: #refreshFigure
]
