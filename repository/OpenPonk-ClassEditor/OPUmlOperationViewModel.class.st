"
I am the ViewModel for UML Operations. I manage model linkage, placeholders, and UI descriptions (such as the `isAbstract` modifier) for operations contained within a classifier.
"
Class {
	#name : 'OPUmlOperationViewModel',
	#superclass : 'OPUmlClassItemViewModel',
	#category : 'OpenPonk-ClassEditor-ViewModels',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'ViewModels'
}

{ #category : 'accessing' }
OPUmlOperationViewModel class >> modelClass [ ^ OPUMLOperation
]

{ #category : 'construction' }
OPUmlOperationViewModel >> createModelIn: aParentModel [

	^ (super createModelIn: aParentModel)
		  name: 'operation';
		  yourself
]

{ #category : 'forms' }
OPUmlOperationViewModel >> descriptionIsAbstract [
	<magritteDescription>
	^ MABooleanDescription new
		accessor: (self descriptionAccessor: #isAbstract);
		label: 'Is Abstract';
		priority: 5;
		yourself
]

{ #category : 'accessing' }
OPUmlOperationViewModel >> findParentViewModel [
    self model owningClass ifNotNil: [ :m | ^ self registry viewModelFor: m ].
    self model datatype ifNotNil: [ :m | ^ self registry viewModelFor: m ].
    ^ super findParentViewModel
]

{ #category : 'accessing' }
OPUmlOperationViewModel >> icon [ ^ OPUmlIcons operationIcon
]

{ #category : 'accessing' }
OPUmlOperationViewModel >> placeholderName [

	^ 'operation'
]

{ #category : 'construction' }
OPUmlOperationViewModel >> registerModelIn: aParentModel [

	aParentModel ownedOperations add: self model
]

{ #category : 'validation' }
OPUmlOperationViewModel >> validate [

	super validate.
	self model ifNil: [ ^ self ].
	self model owningClass ifNotNil: [ ^ self ].
	OPModelInvalid signal: (String streamContents: [ :s |
			 self model printOn: s.
			 s << ' has no owning class' ])
]
