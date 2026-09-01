"
I am the ViewModel for UML Enumerations. I manage the hierarchical UI relationship between the enumeration and its contained literal children.
"
Class {
	#name : 'OPUmlEnumerationViewModel',
	#superclass : 'OPUmlClassifierViewModel',
	#category : 'OpenPonk-ClassEditor-ViewModels',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'ViewModels'
}

{ #category : 'accessing' }
OPUmlEnumerationViewModel class >> modelClass [ ^ OPUMLEnumeration
]

{ #category : 'accessing' }
OPUmlEnumerationViewModel >> essentialChildrenModels [

	^ self model ownedLiterals asArray
]

{ #category : 'accessing' }
OPUmlEnumerationViewModel >> icon [ ^ OPUmlIcons enumIcon
]

{ #category : 'accessing' }
OPUmlEnumerationViewModel >> modelClassName [

	^ 'Enumeration'
]
