Class {
	#name : 'LGGenerator',
	#superclass : 'Object',
	#instVars : [
		'object'
	],
	#category : 'LiveGenerator',
	#package : 'LiveGenerator'
}

{ #category : 'instance creation' }
LGGenerator class >> on: anObject [
	^ self new setObject: anObject
]

{ #category : 'as yet unclassified' }
LGGenerator >> dictionaryToStructureNamed: aName [
	| keys cls |
	self assert: [ object isDictionary ].
	keys := object keys collect: [ :each | self selectorForName: each ].
	cls := Object subclass: aName asSymbol.
	cls := Object
		subclass: aName asSymbol
		slots: keys
		classVariables: {}
		category: 'Unclassified'.
	keys
		do: [ :each | 
			cls
				compile:
					('{1}
	^ {1}' format: {each})
				classified: 'accessing' ].
	cls browse
]

{ #category : 'as yet unclassified' }
LGGenerator >> selectorForName: aString [
	"selector must adhere to /^[a-z][a-zA-Z0-9_]*$/"

	| selector |
	selector := aString copyWithRegex: '[^a-zA-Z0-9_]' matchesReplacedWith: '_'.
	selector first isLetter
		ifFalse: [ selector := 'get' , selector capitalized ].
	^ selector uncapitalized asSymbol
]

{ #category : 'as yet unclassified' }
LGGenerator >> setObject: anObject [
 object := anObject
]
