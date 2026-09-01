"
I am the ViewModel for UML Profiles. I extend the standard Package ViewModel behavior to specifically handle profile application constraints and stereotype definitions.
"
Class {
	#name : 'OPUmlProfileViewModel',
	#superclass : 'OPUmlPackageViewModel',
	#category : 'OpenPonk-ClassEditor-ViewModels',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'ViewModels'
}

{ #category : 'accessing' }
OPUmlProfileViewModel class >> modelClass [ ^ OPUMLProfile
]

{ #category : 'accessing' }
OPUmlProfileViewModel >> childrenModels [ ^ self model packagedElements
]

{ #category : 'accessing' }
OPUmlProfileViewModel >> icon [ ^ OPUmlIcons profileIcon
]
