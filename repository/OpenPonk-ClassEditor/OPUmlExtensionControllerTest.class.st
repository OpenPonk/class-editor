"
I am a unit test class verifying the behavior of OPUmlExtensionController, ensuring proper assignment of source stereotypes and target metaclasses.
"
Class {
	#name : 'OPUmlExtensionControllerTest',
	#superclass : 'OPUmlRelationshipControllerTest',
	#category : 'OpenPonk-ClassEditor-Tests - Controllers',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Tests - Controllers'
}

{ #category : 'constants' }
OPUmlExtensionControllerTest class >> diagramElementClass [

	^ OPUmlExtensionShape
]

{ #category : 'initialization' }
OPUmlExtensionControllerTest >> assignModelSource [
	model ownedEnd type: sourceModel.
	model memberEnds second owningClass: sourceModel.
	model memberEnds second owningAssociation: nil
]

{ #category : 'initialization' }
OPUmlExtensionControllerTest >> assignModelTarget [
	model memberEnds second type: targetModel
]

{ #category : 'constants' }
OPUmlExtensionControllerTest >> controllerClass [
	^ OPUmlExtensionController
]

{ #category : 'constants' }
OPUmlExtensionControllerTest >> diagramModelClass [

	^ OPUMLProfile
]

{ #category : 'constants' }
OPUmlExtensionControllerTest >> modelClass [
	^ OPUMLExtension
]

{ #category : 'initialization' }
OPUmlExtensionControllerTest >> newModel [
	| ext end1 end2 type1 type2 |
	ext := super newModel.
	ext uuid.
	type1 := OPUMLStereotype new name: 'Stereo1'.
	type2 := OPUMLClass new name: 'Class1'.
	end1 := OPUMLExtensionEnd new
		name: 'extension'; type: type1; lowerValue: (OPUMLLiteralInteger new value: 0); upperValue: (OPUMLLiteralUnlimitedNatural new value: 1); owningAssociation: ext; association: ext.
	end2 := OPUMLProperty new name: 'base'; type: type2; owningAssociation: ext; association: ext.
	ext memberEnds add: end1; add: end2.
	ext ownedEnd: end1.
	^ ext
]

{ #category : 'constants' }
OPUmlExtensionControllerTest >> sourceControllerClass [

	^ OPUmlStereotypeController
]

{ #category : 'constants' }
OPUmlExtensionControllerTest >> sourceModelClass [

	^ OPUMLStereotype
]

{ #category : 'constants' }
OPUmlExtensionControllerTest >> targetControllerClass [

	^ OPUmlClassController
]

{ #category : 'constants' }
OPUmlExtensionControllerTest >> targetModelClass [

	^ OPUMLClass
]
