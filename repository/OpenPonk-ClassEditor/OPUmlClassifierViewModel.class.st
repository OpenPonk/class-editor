"
I am the abstract base ViewModel for UML Classifiers (such as Class or Enumeration). I handle logic for packageable elements and their diagram removal.
"
Class {
	#name : 'OPUmlClassifierViewModel',
	#superclass : 'OPUmlElementViewModel',
	#traits : 'OPTUmlPackageableElementViewModel',
	#classTraits : 'OPTUmlPackageableElementViewModel classTrait',
	#category : 'OpenPonk-ClassEditor-ViewModels',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'ViewModels'
}

{ #category : 'testing' }
OPUmlClassifierViewModel class >> isAbstract [

	^ self = OPUmlClassifierViewModel
]

{ #category : 'accessing' }
OPUmlClassifierViewModel >> childrenModels [

	^ super childrenModels , self model generalizations
]

{ #category : 'construction' }
OPUmlClassifierViewModel >> createModelIn: aParentModel [

	^ (super createModelIn: aParentModel)
		  name: self modelClassName;
		  yourself
]

{ #category : 'accessing' }
OPUmlClassifierViewModel >> dependentElements [

	| deps traverse |
	deps := super dependentElements asSet reject: [ :any | (any isKindOf: OPUMLProperty) and: [ any association isNotNil ] ].

	traverse := [ :element |
		            (element respondsTo: #memberEnds) ifTrue: [
				            (element memberEnds anySatisfy: [ :end | end type = self model or: [ end owningClass = self model ] ]) ifTrue: [
					            deps add: element ] ].

		            (element respondsTo: #specific) ifTrue: [
			            (element general = self model or: [ element specific = self model ]) ifTrue: [ deps add: element ] ].

		            (element respondsTo: #packagedElements) ifTrue: [ element packagedElements do: [ :child | traverse value: child ] ].

		            (element respondsTo: #ownedElements) ifTrue: [ element ownedElements do: [ :child | traverse value: child ] ] ].

	self registry project models do: [ :rootModel | traverse value: rootModel ].

	^ deps asArray
]

{ #category : 'accessing' }
OPUmlClassifierViewModel >> modelClassName [
	^ self subclassResponsibility
]

{ #category : 'construction' }
OPUmlClassifierViewModel >> registerModelIn: aParentModel [
	aParentModel packagedElements add: self model
]

{ #category : 'validation' }
OPUmlClassifierViewModel >> validate [
	super validate.
	self model attributes do: [ :each | self validateProperty: each ]
]
