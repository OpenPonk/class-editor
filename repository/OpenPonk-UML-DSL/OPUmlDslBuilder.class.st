"
I parse a complete DSL text.
"
Class {
	#name : #OPUmlDslBuilder,
	#superclass : #PPCompositeParser,
	#instVars : [
		'classBlock',
		'statements',
		'association',
		'umlClassName',
		'inheritance'
	],
	#category : 'OpenPonk-UML-DSL-Builders'
}

{ #category : #accessing }
OPUmlDslBuilder class >> dependencies [
	^ {OPUmlClassBuilder.
	OPUmlAssociationBuilder}
]

{ #category : #accessing }
OPUmlDslBuilder >> association [
	^ ((self dependencyAt: OPUmlAssociationBuilder) association , $; asParser)
		==> [ :nodes | nodes first ]
]

{ #category : #accessing }
OPUmlDslBuilder >> classBlock [
	^ (self dependencyAt: OPUmlClassBuilder) classBlock
]

{ #category : #accessing }
OPUmlDslBuilder >> inheritance [
	^ (umlClassName , ('>>' asParser / 'extends' asParser) trim , umlClassName , $; asParser)
		==>
			[ :nodes | 
			FAMIXInheritance
				subclass: (FAMIXClass named: nodes first)
				superclass: (FAMIXClass named: nodes third) ]
]

{ #category : #accessing }
OPUmlDslBuilder >> start [
	^ statements end
]

{ #category : #accessing }
OPUmlDslBuilder >> statements [
	^ (#newline asParser star
		, (classBlock / association / inheritance separatedBy: #newline asParser plus) withoutSeparators
		, #newline asParser star) optional
		==> [ :nodes | nodes ifNil: [ #() ] ifNotNil: [ nodes second ] ]
]

{ #category : #accessing }
OPUmlDslBuilder >> umlClassName [
	^ (self dependencyAt: OPUmlClassBuilder) dslName ==> [ :nodes | nodes second ]
]
