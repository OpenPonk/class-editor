Class {
	#name : #OPUmlClassBuilderTest,
	#superclass : #PPCompositeParserTest,
	#category : 'OpenPonk-UML-DSL-Tests'
}

{ #category : #accessing }
OPUmlClassBuilderTest >> parserClass [
	^ OPUmlClassBuilder
]

{ #category : #tests }
OPUmlClassBuilderTest >> testAbstractClass [
	self parse: '/MyClass {}' rule: #classBlock.
	self assert: result class equals: FAMIXClass.
	self assert: result name equals: 'MyClass'.
	self assert: result isAbstract
]

{ #category : #tests }
OPUmlClassBuilderTest >> testBlockWithDefaultValue [
	self
		parse:
			'{
	attr : String = ''hello''
}'
		rule: #block.
	self assert: result size equals: 1
]

{ #category : #tests }
OPUmlClassBuilderTest >> testClass [
	self parse: 'MyClass {}' rule: #classBlock.
	self assert: result class equals: FAMIXClass.
	self assert: result name equals: 'MyClass'.
	self deny: result isAbstract
]

{ #category : #tests }
OPUmlClassBuilderTest >> testClassWithDefaultValue [
	self
		parse:
			'MyClass {
	attr : String = ''hello''
}'
		rule: #classBlock.
	self assert: result attributes size equals: 1.
	self assert: result attributes first name equals: 'attr'
]

{ #category : #tests }
OPUmlClassBuilderTest >> testClassWithStatements [
	self
		parse:
			'MyClass {
	attr : String
	op() : Integer
}'
		rule: #classBlock.
	self assert: result attributes size equals: 1.
	self assert: result attributes first name equals: 'attr'.
	self assert: result methods size equals: 1.
	self assert: result methods first name equals: 'op'
]

{ #category : #tests }
OPUmlClassBuilderTest >> testClassWithStereotype [
	self parse: 'MyClass <<meta,class>> {}' rule: #classBlock.
	self assert: result class equals: FAMIXClass.
	self assert: result name equals: 'MyClass'.
	self assert: result stereotypes size equals: 2.
	self assert: result stereotypes first name equals: 'meta'.
	self assert: result stereotypes second name equals: 'class'
]

{ #category : #tests }
OPUmlClassBuilderTest >> testDslName [
	self parse: 'MyClass' rule: #dslName.
	self assert: result equals: #(false 'MyClass')
]

{ #category : #tests }
OPUmlClassBuilderTest >> testDslName1 [
	self parse: '/MyClass' rule: #dslName.
	self assert: result equals: #(true 'MyClass')
]

{ #category : #tests }
OPUmlClassBuilderTest >> testDslName2 [
	self parse: '/::MyClass' rule: #dslName.
	self assert: result equals: #(true '::MyClass')
]

{ #category : #tests }
OPUmlClassBuilderTest >> testEmptyBlock [
	self parse: '{}' rule: #block.
	self parse: '{ }' rule: #block.
	self
		parse:
			'{
}'
		rule: #block
]

{ #category : #tests }
OPUmlClassBuilderTest >> testFqn [
	self parse: 'MyClass' rule: #fqn.
	self assert: result equals: 'MyClass'
]

{ #category : #tests }
OPUmlClassBuilderTest >> testFqn1 [
	self parse: '::MyClass' rule: #fqn.
	self assert: result equals: '::MyClass'
]

{ #category : #tests }
OPUmlClassBuilderTest >> testFqn2 [
	self parse: 'NS::MyClass' rule: #fqn.
	self assert: result equals: 'NS::MyClass'
]

{ #category : #tests }
OPUmlClassBuilderTest >> testKeyword [
	self parse: '' rule: #keyword.
	self assert: result equals: OrderedCollection new
]

{ #category : #tests }
OPUmlClassBuilderTest >> testKeyword1 [
	self parse: '<<aaa,bbb>>' rule: #keyword.
	self assert: result first name equals: 'aaa'.
	self assert: result second name equals: 'bbb'
]

{ #category : #tests }
OPUmlClassBuilderTest >> testKeywordSpaced [
	self parse: '<< aaa , bbb >>' rule: #keyword.
	self assert: result first name equals: 'aaa'.
	self assert: result second name equals: 'bbb'
]

{ #category : #tests }
OPUmlClassBuilderTest >> testStatement [
	self parse: 'attr : Type' rule: #statement.
	self assert: result class equals: FAMIXAttribute.
	self assert: result name equals: 'attr'
]

{ #category : #tests }
OPUmlClassBuilderTest >> testStatement2 [
	self parse: 'op()' rule: #statement.
	self assert: result class equals: FAMIXMethod.
	self assert: result name equals: 'op'
]

{ #category : #tests }
OPUmlClassBuilderTest >> testStatementWithDefaultValue [
	self parse: 'attr : String = ''hello''
' rule: #statements.
	self assert: result size equals: 1.
	self assert: result first name equals: 'attr'
]

{ #category : #tests }
OPUmlClassBuilderTest >> testStatements [
	self
		parse:
			'op1() : Type
attr
'
		rule: #statements.
	self assert: result size equals: 2.
	self assert: result first class equals: FAMIXMethod.
	self assert: result second class equals: FAMIXAttribute
]
