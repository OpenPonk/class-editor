"
I am the ViewModel for UML EnumerationLiterals. I manage the model linkage and parent lookup for literal items within an Enumeration.
"
Class {
	#name : 'OPUmlEnumerationLiteralViewModel',
	#superclass : 'OPUmlClassifierItemViewModel',
	#category : 'OpenPonk-ClassEditor-ViewModels',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'ViewModels'
}

{ #category : 'accessing' }
OPUmlEnumerationLiteralViewModel class >> modelClass [ ^ OPUMLEnumerationLiteral
]

{ #category : 'private' }
OPUmlEnumerationLiteralViewModel >> basicRemoveModel [
	"could be any of those, so just nil all of them"

	self model enumeration: nil
]

{ #category : 'construction' }
OPUmlEnumerationLiteralViewModel >> createModelIn: aParentModel [

	^ (super createModelIn: aParentModel)
		  name: self placeholderName;
		  yourself
]

{ #category : 'accessing' }
OPUmlEnumerationLiteralViewModel >> dependingOnElements [

	^ super dependingOnElements , (Set with: self model enumeration)
]

{ #category : 'accessing' }
OPUmlEnumerationLiteralViewModel >> findParentViewModel [
    self model enumeration ifNotNil: [ :m | ^ self registry viewModelFor: m ].
    ^ super findParentViewModel
]

{ #category : 'accessing' }
OPUmlEnumerationLiteralViewModel >> icon [ ^ OPUmlIcons literalIcon
]

{ #category : 'accessing' }
OPUmlEnumerationLiteralViewModel >> placeholderName [

	^ 'literal'
]

{ #category : 'construction' }
OPUmlEnumerationLiteralViewModel >> registerModelIn: aParentModel [

	aParentModel ownedLiterals add: self model
]

{ #category : 'validation' }
OPUmlEnumerationLiteralViewModel >> validate [

	super validate.
	self model ifNil: [ ^ self ].
	self model enumeration ifNotNil: [ ^ self ].
	OPModelInvalid signal: (String streamContents: [ :s |
			 self model printOn: s.
			 s << ' has no owning enumeration' ])
]
