Class {
	#name : 'OPUmlDslBuilderTest',
	#superclass : 'PPCompositeParserTest',
	#category : 'OpenPonk-UML-DSL-Tests',
	#package : 'OpenPonk-UML-DSL',
	#tag : 'Tests'
}

{ #category : 'accessing' }
OPUmlDslBuilderTest >> parserClass [
	^ OPUmlDslBuilder
]

{ #category : 'tests' }
OPUmlDslBuilderTest >> testAssociation [
	self parse: 'Left --- Right;' rule: #association
]

{ #category : 'tests' }
OPUmlDslBuilderTest >> testAssociations [
	self parse: 'A --- B;
C --- D;' rule: #statements
]

{ #category : 'tests' }
OPUmlDslBuilderTest >> testAssociations1 [
	self
		parse:
			'DCDiagram[0..1] owner --- elements DCNamedElement[*];
DCProject[0..1] --- diagrams DCDiagram[*];'
		rule: #statements
]

{ #category : 'tests' }
OPUmlDslBuilderTest >> testClasses [
	self
		parse:
			'One {}
Two {}'
		rule: #statements.
	self assert: result size equals: 2.
	self assert: result first name equals: 'One'.
	self assert: result second name equals: 'Two'
]

{ #category : 'tests' }
OPUmlDslBuilderTest >> testInheritance [
	self parse: 'Sub >> Super;' rule: #inheritance.
	self assert: result class equals: FAMIXInheritance.
	self assert: result subclass name equals: 'Sub'.
	self assert: result superclass name equals: 'Super'
]

{ #category : 'tests' }
OPUmlDslBuilderTest >> testInheritances [
	self
		parse:
			'Sub >> Super;
A extends B;'
		rule: #statements.
	self assert: result size equals: 2
]

{ #category : 'tests' }
OPUmlDslBuilderTest >> testStatements [
	self
		parse:
			'One {}
Two {}'
		rule: #statements.
	self assert: result size equals: 2.
	self assert: result first name equals: 'One'.
	self assert: result second name equals: 'Two'
]

{ #category : 'tests' }
OPUmlDslBuilderTest >> testStatements1 [
	self
		parse:
			'Left --- Right;
Source --> Target : z;
Class { }
Source --> Target : z;
Person {
	name : String
}
'
		rule: #statements.
	self assert: result size equals: 5
]

{ #category : 'tests' }
OPUmlDslBuilderTest >> testStatements2 [
	self parse: '' rule: #statements.
	self assert: result size equals: 0
]

{ #category : 'tests' }
OPUmlDslBuilderTest >> testStatements3 [
	self parse: '
Class { }' rule: #statements.
	self assert: result size equals: 1
]

{ #category : 'tests' }
OPUmlDslBuilderTest >> testUmlClassName [
	self parse: 'Name' rule: #umlClassName.
	self assert: result equals: 'Name'
]
