"
I am the ViewModel for UML Classes. I provide descriptions for abstract modifiers, stereotypes, and essential children models (attributes and operations).
"
Class {
	#name : 'OPUmlClassViewModel',
	#superclass : 'OPUmlClassifierViewModel',
	#category : 'OpenPonk-ClassEditor-ViewModels',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'ViewModels'
}

{ #category : 'accessing' }
OPUmlClassViewModel class >> modelClass [ ^ OPUMLClass
]

{ #category : 'forms' }
OPUmlClassViewModel >> descriptionIsAbstract [

	<magritteDescription>
	^ MABooleanDescription new
		  accessor: (self descriptionAccessor: #isAbstract);
		  label: 'Is Abstract';
		  priority: 5;
		  yourself
]

{ #category : 'forms' }
OPUmlClassViewModel >> descriptionStereotype [

	<magritteDescription>
	^ self descriptionStereotypeContent
]

{ #category : 'accessing' }
OPUmlClassViewModel >> essentialChildrenModels [

	^ self model ownedAttributes asArray
	  , self model ownedOperations asArray
]

{ #category : 'accessing' }
OPUmlClassViewModel >> icon [ ^ OPUmlIcons classIcon
]

{ #category : 'accessing' }
OPUmlClassViewModel >> modelClassName [

	^ 'Class'
]
