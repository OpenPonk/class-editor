"
View model for UML classes, providing form bindings for abstract modifiers and stereotypes and exposing attributes, operations, and generalizations as child models.
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

{ #category : 'accessing' }
OPUmlClassViewModel >> childrenModels [

	^ Array streamContents: [ :stream |
			  stream nextPutAll: self model ownedAttributes.
			  stream nextPutAll: self model ownedOperations.
			  stream nextPutAll: super childrenModels ]
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
OPUmlClassViewModel >> icon [ ^ OPUmlIcons classIcon
]

{ #category : 'accessing' }
OPUmlClassViewModel >> modelClassName [

	^ 'Class'
]
