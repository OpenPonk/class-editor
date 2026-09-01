"
I am the ViewModel for UML PrimitiveTypes, linking primitive data types to the UI and canvas properties.
"
Class {
	#name : 'OPUmlPrimitiveTypeViewModel',
	#superclass : 'OPUmlElementViewModel',
	#traits : 'OPTUmlPackageableElementViewModel',
	#classTraits : 'OPTUmlPackageableElementViewModel classTrait',
	#category : 'OpenPonk-ClassEditor-ViewModels',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'ViewModels'
}

{ #category : 'accessing' }
OPUmlPrimitiveTypeViewModel class >> modelClass [ ^ OPUMLPrimitiveType
]

{ #category : 'accessing' }
OPUmlPrimitiveTypeViewModel >> icon [ ^ OPUmlIcons primitiveIcon
]
