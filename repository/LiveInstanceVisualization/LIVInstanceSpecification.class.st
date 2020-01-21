Class {
	#name : #LIVInstanceSpecification,
	#superclass : #Object,
	#instVars : [
		'name',
		'classifier',
		'slots',
		'instanceHash'
	],
	#category : 'LiveInstanceVisualization-Models'
}

{ #category : #converting }
LIVInstanceSpecification >> asShape [
	| el lbl comp compLbl |
	el := OPUmlCompartmentableShape new.
	el modelElement: self.
	lbl := OPUmlTypedElementLabel new.
	lbl
		text:
			(String
				streamContents: [ :stream | 
					name
						ifNotNil: [ stream
								<< name;
								<< ' ' ].
					stream << ': '.
					stream << classifier name ]).
	lbl
		localStyle:
			(OPUmlStyle new
				fontSize: 11;
				fontUnderline: true).
	lbl owningElement: el.
	comp := OPUmlCompartment new.
	comp owningElement: el.
	slots
		keysAndValuesDo: [ :key :value | 
			(compLbl := OPUmlTypedElementLabel new)
				owningElement: comp;
				modelElement: key;
				text:
					(String
						streamContents: [ :stream | 
							stream << key.
							stream << ' = '.
							(value isCollection
								and: [ value allSatisfy: [ :each | each isKindOf: LIVInstanceSpecification ] ])
								ifTrue: [ (stream
										<<
										(value class printString first isVowel
										ifTrue: [ 'an' ]
										ifFalse: [ 'a' ]))
										<< value class printString;
										<< '(size=';
										<< value size;
										<< ')' ]
								ifFalse: [ stream << value printString ] ]) ].
	^ el
]

{ #category : #accessing }
LIVInstanceSpecification >> classifier [
	^ classifier
]

{ #category : #accessing }
LIVInstanceSpecification >> classifier: anObject [
	classifier := anObject
]

{ #category : #initialization }
LIVInstanceSpecification >> initialize [
	super initialize.
	slots := OrderedDictionary new
]

{ #category : #accessing }
LIVInstanceSpecification >> instanceHash [
	^ instanceHash
]

{ #category : #accessing }
LIVInstanceSpecification >> instanceHash: aHash [
	instanceHash := aHash
]

{ #category : #accessing }
LIVInstanceSpecification >> name [
	^ name
]

{ #category : #accessing }
LIVInstanceSpecification >> name: aString [
	name := aString
]

{ #category : #printing }
LIVInstanceSpecification >> printOn: aStream [
	aStream
		<< 'InstSpec';
		<< '(';
		<< self name;
		<< ' : ';
		<< self classifier name;
		<< ')'
]

{ #category : #accessing }
LIVInstanceSpecification >> slots [
	^ slots
]
