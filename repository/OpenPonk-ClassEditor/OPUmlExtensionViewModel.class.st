"
I am the ViewModel for UML Extensions. I represent the structural relationship between a custom stereotype and a base UML metaclass within a Profile.
"
Class {
	#name : 'OPUmlExtensionViewModel',
	#superclass : 'OPUmlElementViewModel',
	#traits : 'OPTUmlPackageableElementViewModel',
	#classTraits : 'OPTUmlPackageableElementViewModel classTrait',
	#category : 'OpenPonk-ClassEditor-ViewModels',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'ViewModels'
}

{ #category : 'accessing' }
OPUmlExtensionViewModel class >> modelClass [ ^ OPUMLExtension
]

{ #category : 'construction' }
OPUmlExtensionViewModel >> attachModelFrom: sourceViewModel to: targetViewModel [

	| sourceProp targetProp |
	sourceProp := OPUMLExtensionEnd new
		              owningAssociation: self model;
		              association: self model;
		              name: 'extension_' , sourceViewModel model name;
		              type: sourceViewModel model;
		              lowerValue: (OPUMLLiteralInteger new value: 0);
		              upperValue:
			              (OPUMLLiteralUnlimitedNatural new value: 1).
	self model memberEnds add: sourceProp.
	self model ownedEnd: sourceProp.

	targetProp := OPUMLProperty new
		              owningClass: sourceViewModel model;
		              association: self model;
		              name: 'base_' , targetViewModel model name;
		              type: targetViewModel model.
	self model memberEnds add: targetProp
]

{ #category : 'private' }
OPUmlExtensionViewModel >> basicRemoveModel [

	self model memberEnds asArray do: [ :end |
			end owningClass: nil.
			end interface: nil.
			end datatype: nil.
			end owningAssociation: nil.
			end association: nil ].
	self basicRemovePackagedModel
]

{ #category : 'accessing' }
OPUmlExtensionViewModel >> dependingOnElements [

	^ super dependingOnElements
	  , (self model memberEnds collect: [ :each | each type ])
]

{ #category : 'accessing' }
OPUmlExtensionViewModel >> icon [ ^ OPUmlIcons extensionIcon
]

{ #category : 'accessing' }
OPUmlExtensionViewModel >> modelSource [

	^ self model ownedEnd ifNotNil: [ :end | end type ]
]

{ #category : 'accessing' }
OPUmlExtensionViewModel >> modelTarget [

	| baseEnds |
	self model memberEnds ifNil: [ ^ nil ].
	baseEnds := self model memberEnds reject: [ :each |
		            each == self model ownedEnd ].
	^ baseEnds ifEmpty: [ nil ] ifNotEmpty: [ baseEnds first type ]
]

{ #category : 'construction' }
OPUmlExtensionViewModel >> registerModelIn: aParentModel [

	aParentModel ifNotNil: [
		aParentModel packagedElements add: self model ]
]
