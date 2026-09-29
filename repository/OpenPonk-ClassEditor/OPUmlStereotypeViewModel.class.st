"
I am the ViewModel for UML Stereotypes. I specialize the standard class ViewModel to handle the specific UI metadata and icon requirements of a stereotype definition within a profile.
"
Class {
	#name : 'OPUmlStereotypeViewModel',
	#superclass : 'OPUmlClassViewModel',
	#category : 'OpenPonk-ClassEditor-ViewModels',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'ViewModels'
}

{ #category : 'accessing' }
OPUmlStereotypeViewModel class >> modelClass [ ^ OPUMLStereotype
]

{ #category : 'accessing' }
OPUmlStereotypeViewModel >> icon [ ^ OPUmlIcons stereotypeIcon
]

{ #category : 'accessing' }
OPUmlStereotypeViewModel >> modelClassName [

	^ 'Stereotype'
]
