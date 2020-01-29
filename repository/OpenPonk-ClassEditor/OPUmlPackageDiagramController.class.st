"
I am controller for managing the main class diagram presentation and handling items contained in the canvas.
"
Class {
	#name : #OPUmlPackageDiagramController,
	#superclass : #OPDiagramController,
	#instVars : [
		'layouter'
	],
	#category : #'OpenPonk-ClassEditor-Controllers'
}

{ #category : #'ui hooks' }
OPUmlPackageDiagramController >> addAllElements [
	self showAllElements
]

{ #category : #adding }
OPUmlPackageDiagramController >> addAsSourceFor: aController [
	self shouldBeImplemented
]

{ #category : #adding }
OPUmlPackageDiagramController >> addAsTargetFor: aClassController [
	self assert: (self canBeTargetFor: aClassController).
	aClassController createModelIn: self model andShowInDiagram: self
]

{ #category : #'ui hooks' }
OPUmlPackageDiagramController >> addLayoutMenu: builder parent: aParent [
	self layouter buildMenuOn: builder parent: aParent
]

{ #category : #figures }
OPUmlPackageDiagramController >> allShowableElements [
	"Should return all elements that could be directly hidden on diagram"

	^ self elementsToShowInside
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

{ #category : #'ui hooks' }
OPUmlPackageDiagramController >> applyBasicLayout [
	self layouter dominanceTreeLayout
]

{ #category : #forms }
OPUmlPackageDiagramController >> buildEditorForm: aForm [
	aForm fromMagritteDescriptions: self magritteDescription
]

{ #category : #forms }
OPUmlPackageDiagramController >> buildNameEditorForm: aForm [
	(aForm addTextInput: 'Name')
		text: self model name;
		whenTextIsAccepted: [ :newValue | 
			self model name: newValue.
			self refreshFigure ]
]

{ #category : #adding }
OPUmlPackageDiagramController >> canBeTargetFor: aController [
	^ (aController isKindOf: OPUmlClassController)
		| (aController isKindOf: OPUmlPackageController)
		| (aController isKindOf: OPUmlEnumerationController)
]

{ #category : #forms }
OPUmlPackageDiagramController >> descriptionAccessor: aSymbol [
	^ MAPluggableAccessor
		read: [ :me | me model perform: aSymbol ]
		write: [ :me :newValue | me model perform: (aSymbol , ':') asSymbol with: newValue ]
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

{ #category : #forms }
OPUmlPackageDiagramController >> descriptionComment [
	<magritteDescription>
	^ MAMemoDescription new
		required: false;
		accessor:
			(MAPluggableAccessor
				read:
					[ :me | me model ownedComments ifEmpty: [ '' ] ifNotEmpty: [ :oc | oc first body asString ] ]
				write: [ :me :newValue | 
					me model ownedComments ifEmpty: [ me model ownedComments add: OPUMLComment new ].
					me model ownedComments first body: newValue asString ]);
		label: 'Comment';
		priority: 100;
		yourself
]

{ #category : #forms }
OPUmlPackageDiagramController >> descriptionModelInfo [
	<magritteDescription>
	^ MAStringDescription new
		beReadonly;
		accessor: (MAPluggableAccessor read: [ :me | '' ] write: [ :me :newValue |  ]);
		label: self model className;
		priority: 0;
		yourself
]

{ #category : #forms }
OPUmlPackageDiagramController >> descriptionName [
	<magritteDescription>
	^ MAStringDescription new
		accessor: (self descriptionAccessor: #name);
		label: 'Name';
		priority: 1;
		yourself
]

{ #category : #forms }
OPUmlPackageDiagramController >> descriptionVisibility [
	<magritteDescription>
	^ MASingleOptionDescription new
		optionsAndLabels:
			{nil -> ''.
			OPUMLVisibilityKind public -> 'public'.
			OPUMLVisibilityKind protected -> 'protected'.
			OPUMLVisibilityKind private -> 'private'.
			OPUMLVisibilityKind new package -> 'package'};
		reference: MAStringDescription new;
		accessor:
			(MAPluggableAccessor
				read: [ :me | me model visibility ]
				write: [ :me :newValue | 
					me model visibility: newValue.
					self refreshFigure ]);
		label: 'Visibility';
		priority: 8;
		beSorted;
		yourself
]

{ #category : #figures }
OPUmlPackageDiagramController >> diagramElementForModel: aModel [
	^ (self controllerForModel: aModel) diagramElement
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

{ #category : #testing }
OPUmlPackageDiagramController >> hasSupportForModel: aModel [
	^ modelToControllerMapping includesKey: aModel class
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

{ #category : #accessing }
OPUmlPackageDiagramController >> layouter [
	^ layouter ifNil: [ layouter := OPUmlLayouter new diagramController: self ]
]

{ #category : #adding }
OPUmlPackageDiagramController >> modelToControllerMapping [
	^ {OPUMLClass -> OPUmlClassController.
	OPUMLProperty -> OPUmlAttributeController.
	OPUMLOperation -> OPUmlOperationController.
	OPUMLGeneralization -> OPUmlGeneralizationController.
	OPUMLAssociation -> OPUmlAssociationController.
	OPUMLPackage -> OPUmlPackageController.
	OPUMLModel -> OPUmlPackageController.
	OPUMLProfile -> OPUmlPackageController.
	OPUMLExtension -> OPUmlExtensionController.
	OPUMLExtensionEnd -> OPUmlAttributeController.
	OPUMLEnumeration -> OPUmlEnumerationController.
	OPUMLEnumerationLiteral -> OPUmlEnumerationLiteralController.
	OPUMLStereotype -> OPUmlStereotypeController.
	OPUMLPackageImport -> OPUmlPackageImportController} asDictionary
]

{ #category : #rebuilding }
OPUmlPackageDiagramController >> rebuild [
	super rebuild.
	self applyBasicLayout
]

{ #category : #palette }
OPUmlPackageDiagramController >> rebuildPalette [
	self editor paletteModel createPaletteFor: self.
	self editor paletteModel rebuildWidget.
	self selectView
]

{ #category : #removing }
OPUmlPackageDiagramController >> removeFromModel: aModel [
	| controller |
	controller := self controllerForModel: aModel.
	controller removeModel
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
		do: [ :each | self showInDiagramModel: each ].
	self enableRefresh.
	self controllers
		select: [ :each | each isKindOf: OPUmlClassController ]
		thenDo: #refreshFigure
]
