"
I am the ViewModel for UML DataTypes, handling data-type specific domain logic and visual representations.
"
Class {
	#name : 'OPUmlDataTypeViewModel',
	#superclass : 'OPUmlElementViewModel',
	#traits : 'OPTUmlPackageableElementViewModel',
	#classTraits : 'OPTUmlPackageableElementViewModel classTrait',
	#category : 'OpenPonk-ClassEditor-ViewModels',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'ViewModels'
}

{ #category : 'accessing' }
OPUmlDataTypeViewModel class >> modelClass [ ^ OPUMLDataType
]

{ #category : 'accessing' }
OPUmlDataTypeViewModel >> icon [ ^ OPUmlIcons dataTypeIcon
]
