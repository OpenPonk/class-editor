"
I am the ViewModel for UML Constraints, linking the underlying constraint model to the UI representations.
"
Class {
	#name : 'OPUmlConstraintViewModel',
	#superclass : 'OPUmlElementViewModel',
	#traits : 'OPTUmlPackageableElementViewModel',
	#classTraits : 'OPTUmlPackageableElementViewModel classTrait',
	#category : 'OpenPonk-ClassEditor-ViewModels',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'ViewModels'
}

{ #category : 'accessing' }
OPUmlConstraintViewModel class >> modelClass [ ^ OPUMLConstraint
]

{ #category : 'accessing' }
OPUmlConstraintViewModel >> icon [ ^ OPUmlIcons constraintIcon
]
