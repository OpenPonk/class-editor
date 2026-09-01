"
I am the primary diagram controller for the UML Class Diagram editor. I manage the palette, canvas interactions, profile applications, and the rendering of classes, packages, and their relationships.
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

{ #category : 'accessing' }
OPUmlPackageDiagramController class >> viewModelClass [

	^ OPUmlPackageViewModel
]

{ #category : 'deprecation' }
OPUmlPackageDiagramController >> allGeneralizationSets [
	self deprecated: 'Use viewModel instead' transformWith: '`@receiver allGeneralizationSets' -> '`@receiver viewModel allGeneralizationSets'.
	^ self viewModel allGeneralizationSets
]

{ #category : 'deprecation' }
OPUmlPackageDiagramController >> allPackages [
	self deprecated: 'Use viewModel instead' transformWith: '`@receiver allPackages' -> '`@receiver viewModel allPackages'.
	^ self viewModel allPackages
]

{ #category : 'deprecation' }
OPUmlPackageDiagramController >> allPackagesIn: aPackage [
	self deprecated: 'Use viewModel instead' transformWith: '`@receiver allPackagesIn: `@arg1' -> '`@receiver viewModel allPackagesIn: `@arg1'.
	^ self viewModel allPackagesIn: aPackage
]

{ #category : 'connecting' }
OPUmlPackageDiagramController >> canBeTargetFor: aController [
	^ (super canBeTargetFor: aController)
		or: [ (aController isKindOf: OPUmlClassController)
				or: [ (aController isKindOf: OPUmlPackageController)
						or: [ aController isKindOf: OPUmlEnumerationController ] ] ]
]

{ #category : 'accessing' }
OPUmlPackageDiagramController >> controllerFactory [
			"Configure controller factory with explicit conditions for UML elements."
			^ super controllerFactory
				register: OPUmlClassController forModel: OPUMLClass;
				register: OPUmlAttributeController 
					forModel: OPUMLProperty 
					condition: [ :prop | prop owningAssociation isNil ];
				register: OPUmlOperationController forModel: OPUMLOperation;
				register: OPUmlGeneralizationController forModel: OPUMLGeneralization;
				register: OPUmlAssociationController forModel: OPUMLAssociation;
				register: OPUmlPackageController forModel: OPUMLPackage;
				register: OPUmlPackageController forModel: OPUMLProfile;
				register: OPUmlExtensionController forModel: OPUMLExtension;
				register: OPUmlAttributeController 
					forModel: OPUMLExtensionEnd 
					condition: [ :prop | prop owningAssociation isNil ];
				register: OPUmlEnumerationController forModel: OPUMLEnumeration;
				register: OPUmlEnumerationLiteralController forModel: OPUMLEnumerationLiteral;
				register: OPUmlStereotypeController forModel: OPUMLStereotype;
				register: OPUmlPackageImportController forModel: OPUMLPackageImport
]

{ #category : 'deprecation' }
OPUmlPackageDiagramController >> descriptionAppliedProfiles [
	self deprecated: 'Use viewModel instead' transformWith: '`@receiver descriptionAppliedProfiles' -> '`@receiver viewModel descriptionAppliedProfiles'.
	^ self viewModel descriptionAppliedProfiles
]

{ #category : 'deprecation' }
OPUmlPackageDiagramController >> descriptionGeneralizationSets [
	self deprecated: 'Use viewModel instead' transformWith: '`@receiver descriptionGeneralizationSets' -> '`@receiver viewModel descriptionGeneralizationSets'.
	^ self viewModel descriptionGeneralizationSets
]

{ #category : 'userinterface' }
OPUmlPackageDiagramController >> disableRefresh [
	| install |
	self flag: #todo.
	install := [ :cls | 
	| link |
	(cls includesSelector: #modelChanged)
		ifTrue:
			[ link := MetaLink new
				metaObject: self;
				selector: #yourself;
				arguments: #();
				control: #instead.
			(cls >> #modelChanged) ast link: link ] ].
	OPUmlElementController withAllSubAndSuperclassesDo: [ :each | install value: each ]
]

{ #category : 'userinterface' }
OPUmlPackageDiagramController >> enableRefresh [
	| uninstall |
	self flag: #todo.
	uninstall := [ :cls | 
	(cls includesSelector: #modelChanged)
		ifTrue: [ (cls >> #modelChanged) ast links
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
	(aPalette newCreationEntry: [ OPUmlPackageController new beForProfile ])
		label: 'Profile';
		icon: OPUmlIcons profileIcon;
		whenCreatedSetup
]

{ #category : 'ui interaction' }
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
				ctrl modelChanged.
				OPInitialSetElementCommand executeOn: ctrl.
				ctrl modelChanged ] ].
	relationships ifNotEmpty: [ aPalette newSeparator ].
	relationships do: [ :stereotype |
		(aPalette newConnectionCreationEntry: [
				 OPUmlAssociationController new ])
			label: stereotype name;
			icon: OPUmlIcons directedAssociationIcon;
			whenCreated: [ :ctrl |
				ctrl model applyStereotype: stereotype implementationClass new.
				ctrl modelChanged ] ]
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

	self model profileApplications do: [ :each |
		self initializeProfile: each appliedProfile palette: aPalette ]
]

{ #category : 'forms' }
OPUmlPackageDiagramController >> maEdit [

	OPUmlAllGeneralizationSetsEditor new
		application: self diagramController editor application;
		controller: self;
		openModal
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

	self editor palette
		createPaletteFor: self;
		rebuildWidget
]

{ #category : 'announcements' }
OPUmlPackageDiagramController >> subscribeToViewModel [

	super subscribeToViewModel.
	(self viewModel ifNil: [ ^ self ]) announcer weak
		when: OPUmlProfileApplied
		send: #rebuildPalette
		to: self
]
