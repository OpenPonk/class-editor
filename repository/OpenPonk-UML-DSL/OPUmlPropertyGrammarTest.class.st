Class {
	#name : #OPUmlPropertyGrammarTest,
	#superclass : #OPUmlPropGrammarTest,
	#category : 'OpenPonk-UML-DSL-Tests'
}

{ #category : #accessing }
OPUmlPropertyGrammarTest >> parserClass [
	^ OPUmlPropertyGrammar
]

{ #category : #tests }
OPUmlPropertyGrammarTest >> testDefaultValue [
	self parse: '= 10' rule: #defaultValue.
	self parse: '= #(1 2 3)' rule: #defaultValue.
	self parse: '= ''str''' rule: #defaultValue
]

{ #category : #tests }
OPUmlPropertyGrammarTest >> testPropName [
	self parse: 'symbol' rule: #propName
]

{ #category : #tests }
OPUmlPropertyGrammarTest >> testPropName2 [
	self parse: 'symb_ol' rule: #propName
]

{ #category : #tests }
OPUmlPropertyGrammarTest >> testPropType [
	self parse: 'symbol' rule: #propType
]

{ #category : #tests }
OPUmlPropertyGrammarTest >> testProperty [
	self parse: 'name' rule: #property.
	self parse: '+name: Type' rule: #property.
	self parse: 'name : Type' rule: #property.
	self parse: '+name: Type[1..2]' rule: #property.
	self parse: 'name : Type = defaultValue' rule: #property.
	self parse: 'name : Type[1..4] = defaultValue' rule: #property
]

{ #category : #tests }
OPUmlPropertyGrammarTest >> testStatic [
	self parse: '_name' rule: #property
]
