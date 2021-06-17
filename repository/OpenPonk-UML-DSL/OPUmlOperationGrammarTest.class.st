Class {
	#name : #OPUmlOperationGrammarTest,
	#superclass : #OPUmlPropGrammarTest,
	#category : 'OpenPonk-UML-DSL-Tests'
}

{ #category : #accessing }
OPUmlOperationGrammarTest >> parserClass [
	^ OPUmlOperationGrammar
]

{ #category : #tests }
OPUmlOperationGrammarTest >> testOpName [
	self parse: 'symbol' rule: #opName
]

{ #category : #tests }
OPUmlOperationGrammarTest >> testOpName2 [
	self parse: 'add:to:' rule: #opName
]

{ #category : #tests }
OPUmlOperationGrammarTest >> testOpName3 [
	self parse: 'add_to:' rule: #opName
]

{ #category : #tests }
OPUmlOperationGrammarTest >> testOperation [
	self parse: 'name()' rule: #operation.
	self parse: 'name() : Type' rule: #operation.
	self parse: 'name(arg)' rule: #operation.
	self parse: '+name(param: Type, param2: Type[*]): Type[1..2]' rule: #operation
]

{ #category : #tests }
OPUmlOperationGrammarTest >> testParameter [
	self parse: 'name: Type' rule: #parameter.
	self parse: 'name : Type' rule: #parameter.
	self parse: 'name: Type[1..2]' rule: #parameter
]

{ #category : #tests }
OPUmlOperationGrammarTest >> testParameterList [
	self parse: '' rule: #parameterList.
	self parse: 'name: Type' rule: #parameterList.
	self parse: 'name: Type, name2: Type2' rule: #parameterList.
	self parse: 'name : Type, name2 : Type2' rule: #parameterList
]
