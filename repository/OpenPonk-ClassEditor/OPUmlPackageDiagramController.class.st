"
I am the primary diagram controller for the UML Class Diagram editor. I manage the palette, canvas interactions, profile applications, and the rendering of classes, packages, and their relationships.
"
Class {
	#name : 'OPUmlPackageDiagramController',
	#superclass : 'OPDiagramController',
	#category : 'OpenPonk-ClassEditor-Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Controllers'
}

{ #category : 'accessing' }
OPUmlPackageDiagramController class >> viewModelClass [

	^ OPUmlPackageViewModel
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
		register: OPUmlProfileController forModel: OPUMLProfile;
		register: OPUmlExtensionController forModel: OPUMLExtension;
		register: OPUmlEnumerationController forModel: OPUMLEnumeration;
		register: OPUmlEnumerationLiteralController forModel: OPUMLEnumerationLiteral;
		register: OPUmlStereotypeController forModel: OPUMLStereotype;
		register: OPUmlPackageImportController forModel: OPUMLPackageImport
]

{ #category : 'testing' }
OPUmlPackageDiagramController >> hasSupportForModel: aModel [

	^ (super hasSupportForModel: aModel) and: [ (self isSystemModel: aModel) not ]
]

{ #category : 'palette' }
OPUmlPackageDiagramController >> initializePackagePalette: aPalette [
	aPalette newSeparator.
	(aPalette newConnectionCreationTool: [ OPUmlPackageImportController new ])
		label: 'Package Import';
		icon: OPUmlIcons directedAssociationIcon.
	(aPalette newCreationEntry: [ OPUmlPackageController new ])
		label: 'Package';
		icon: OPUmlIcons packageIcon.
	(aPalette newCreationEntry: [ OPUmlProfileController new ])
		label: 'Profile';
		icon: OPUmlIcons profileIcon
]

{ #category : 'ui interaction' }
OPUmlPackageDiagramController >> initializePalette: aPalette [
	(aPalette newCreationEntry: [ OPUmlClassController new ])
		label: 'Class';
		icon: OPUmlIcons classIcon;
		shortcut: $c asShortcut.
	(aPalette newCreationEntry: [ OPUmlAttributeController new ])
		label: 'Attribute';
		icon: OPUmlIcons attributeIcon;
		shortcut: $a asShortcut.
	(aPalette newCreationEntry: [ OPUmlOperationController new ])
		label: 'Operation';
		icon: OPUmlIcons operationIcon;
		shortcut: $o asShortcut.
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
		icon: OPUmlIcons enumIcon.
	(aPalette newCreationEntry: [ OPUmlEnumerationLiteralController new ])
		label: 'Enumeration Literal';
		icon: OPUmlIcons literalIcon.
	self initializeProfileModelingPalette: aPalette.
	self initializeProfilesPalette: aPalette.
	self initializePackagePalette: aPalette
]

{ #category : 'palette' }
OPUmlPackageDiagramController >> initializeProfile: aProfile palette: aPalette [

	| stereotypes elements relationships isForRelationship isForClass |
	stereotypes := (aProfile ownedStereotype reject: #isAbstract) sorted: [ :stereotypeA :stereotypeB |
		               stereotypeA name < stereotypeB name ].
	isForRelationship := [ :attribute |
		                     (OPUMLXMISpecsStorage metaClassNamed: attribute type name) allParents anySatisfy: [ :parentMetaClass |
			                     parentMetaClass name = 'Relationship' ] ].
	isForClass := [ :attribute |
		              | metaclassObj |
		              metaclassObj := OPUMLXMISpecsStorage metaClassNamed: attribute type name.
		              metaclassObj name = 'Class' or: [
			              metaclassObj allParents anySatisfy: [ :parentClass | parentClass name = 'Class' ] ] ].
	elements := stereotypes select: [ :eachStereotype |
			            eachStereotype allAttributes anySatisfy: [ :attributeProperty |
				            (attributeProperty name beginsWith: 'base_') and: [ isForClass value: attributeProperty ] ] ].
	relationships := stereotypes select: [ :eachStereotype |
			                 eachStereotype allAttributes anySatisfy: [ :attributeProperty |
				                 (attributeProperty name beginsWith: 'base_') and: [ isForRelationship value: attributeProperty ] ] ].
	elements ifNotEmpty: [ aPalette newSeparator ].
	elements do: [ :stereotypeElement |
			(aPalette newCreationEntry: [ OPUmlClassController new ])
				label: stereotypeElement name;
				icon: OPUmlIcons classIcon;
				whenCreated: [ :classController |
						classController viewModel applyStereotype: stereotypeElement to: classController model.
						classController model name: stereotypeElement name.
						classController modelChanged.
						classController diagramController ifNotNil: [ :activeDiagramController |
									activeDiagramController editor ifNotNil: [ :activeEditor |
											activeEditor form ifNotNil: [ :activeForm | activeForm focusFirstInput ] ] ] ] ].
	relationships ifNotEmpty: [ aPalette newSeparator ].
	relationships do: [ :stereotypeRelation |
			(aPalette newConnectionCreationEntry: [ OPUmlAssociationController new ])
				label: stereotypeRelation name;
				icon: OPUmlIcons directedAssociationIcon;
				whenCreated: [ :associationController |
						associationController viewModel applyStereotype: stereotypeRelation to: associationController model.
						associationController modelChanged ] ]
]

{ #category : 'palette' }
OPUmlPackageDiagramController >> initializeProfileModelingPalette: aPalette [
	(self model oclIsKindOf: #Profile)
		ifFalse: [ ^ self ].
	aPalette newSeparator.
	(aPalette newCreationEntry: [ OPUmlStereotypeController new ])
		label: 'Stereotype';
		icon: OPUmlIcons stereotypeIcon.
	(aPalette newConnectionCreationTool: [ OPUmlExtensionController new ])
		label: 'Extension';
		icon: OPUmlIcons extensionIcon
]

{ #category : 'palette' }
OPUmlPackageDiagramController >> initializeProfilesPalette: aPalette [

	self model profileApplications do: [ :each |
		self initializeProfile: each appliedProfile palette: aPalette ]
]

{ #category : 'testing' }
OPUmlPackageDiagramController >> isSystemModel: aModel [

	^ ((self viewModel ifNil: [ ^ false ]) registry viewModelFor: aModel) isSystemElement
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

	self editor ifNotNil: [ :activeEditor |
			activeEditor palette
				createPaletteFor: self;
				rebuildWidget ]
]

{ #category : 'announcements' }
OPUmlPackageDiagramController >> subscribeToViewModel [

	super subscribeToViewModel.
	self viewModel announcer weak when: OPUmlProfileApplied send: #rebuildPalette to: self
]
