Class {
	#name : #OPUmlAssociationGrammarTest,
	#superclass : #PPCompositeParserTest,
	#category : 'OpenPonk-UML-DSL-Tests'
}

{ #category : #accessing }
OPUmlAssociationGrammarTest >> parserClass [
	^ OPUmlAssociationGrammar
]

{ #category : #tests }
OPUmlAssociationGrammarTest >> testAssociation1 [
	self parse: 'Left --- Right' rule: #association
]

{ #category : #tests }
OPUmlAssociationGrammarTest >> testAssociation2 [
	self parse: 'Left[0..1] --- Right[*]' rule: #association.
]

{ #category : #tests }
OPUmlAssociationGrammarTest >> testAssociation3 [
	self parse: 'Left[0..1] leftRole <-> rightRole Right[*] : name' rule: #association.
]

{ #category : #tests }
OPUmlAssociationGrammarTest >> testAssociationName [
	self parse: ': name' rule: #associationName
]

{ #category : #tests }
OPUmlAssociationGrammarTest >> testAssociationNs [
	self parse: '::Object --- NS::Object' rule: #association.
]

{ #category : #tests }
OPUmlAssociationGrammarTest >> testAssociationNs1 [
	self parse: 'NS::Object --- ::Object' rule: #association.
]

{ #category : #tests }
OPUmlAssociationGrammarTest >> testAssociationWithRoles [
	self parse: 'Left roleLeft --- roleRight Right' rule: #association
]

{ #category : #tests }
OPUmlAssociationGrammarTest >> testEndName [
	self parse: 'name' rule: #endName
]

{ #category : #tests }
OPUmlAssociationGrammarTest >> testEndSymbol [
	self parse: '>' rule: #endSymbol
]

{ #category : #tests }
OPUmlAssociationGrammarTest >> testLeftEnd [
	self parse: 'Left -' rule: #leftEnd.
	self parse: 'Left[*] <' rule: #leftEnd
]

{ #category : #tests }
OPUmlAssociationGrammarTest >> testLeftEndWithRole [
	self parse: 'Left role -' rule: #leftEnd.
	self parse: 'Left[*] role <' rule: #leftEnd
]

{ #category : #tests }
OPUmlAssociationGrammarTest >> testNavigable [
	self parse: 'Left --- Right' rule: #association.
]

{ #category : #tests }
OPUmlAssociationGrammarTest >> testNavigable1 [
	self parse: 'Left --> Right' rule: #association.
]

{ #category : #tests }
OPUmlAssociationGrammarTest >> testNavigable2 [
	self parse: 'Left <-- Right' rule: #association.
]

{ #category : #tests }
OPUmlAssociationGrammarTest >> testNavigable3 [
	self parse: 'Left <>-- Right' rule: #association.
]

{ #category : #tests }
OPUmlAssociationGrammarTest >> testNavigable4 [
	self parse: 'Left <>-> Right' rule: #association.
]

{ #category : #tests }
OPUmlAssociationGrammarTest >> testNavigable5 [
	self parse: 'Left --<*> Right' rule: #association.
]

{ #category : #tests }
OPUmlAssociationGrammarTest >> testNavigable6 [
	self parse: 'Left <-<*> Right' rule: #association.
]

{ #category : #tests }
OPUmlAssociationGrammarTest >> testRightEnd [
	self parse: '- Right' rule: #rightEnd.
	self parse: '> Right[*]' rule: #rightEnd
]

{ #category : #tests }
OPUmlAssociationGrammarTest >> testRightEndWithRole [
	self parse: '- role Right' rule: #rightEnd.
	self parse: '> role Right[*]' rule: #rightEnd
]

{ #category : #tests }
OPUmlAssociationGrammarTest >> testStartSymbol [
	self parse: '<' rule: #startSymbol
]

{ #category : #tests }
OPUmlAssociationGrammarTest >> testType [
	self parse: ' --- ' rule: #type.
	self parse: ' <-> ' rule: #type.
	self parse: ' <-- ' rule: #type.
	self parse: ' <>-<> ' rule: #type.
	self parse: ' <*>-<*> ' rule: #type
]

{ #category : #tests }
OPUmlAssociationGrammarTest >> testTypeSymbol [
	self parse: '-' rule: #typeSymbol.
	self parse: '<>' rule: #typeSymbol.
	self parse: '<*>' rule: #typeSymbol
]
