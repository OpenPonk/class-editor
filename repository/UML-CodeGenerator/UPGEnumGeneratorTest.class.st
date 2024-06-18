Class {
	#name : 'UPGEnumGeneratorTest',
	#superclass : 'UPGBaseGeneratorTest',
	#instVars : [
		'enum'
	],
	#category : 'UML-CodeGenerator-Tests',
	#package : 'UML-CodeGenerator',
	#tag : 'Tests'
}

{ #category : 'running' }
UPGEnumGeneratorTest >> createEnum [
	| mooseModel pkg enumModel |
	mooseModel := 'TestEnumKind <<enumeration>> {
	organization
	person
	system
}' asClassDiagram.
	enumModel := mooseModel allModelClasses first.
	(pkg := FAMIXPackage new) name: self categoryName.
	pkg mooseModel: mooseModel.
	enumModel parentPackage: pkg.
	^ enumModel
]

{ #category : 'running' }
UPGEnumGeneratorTest >> setUp [
	super setUp.
	generator := UPGEnumGenerator new.
	model := self createEnum.
	generator executeOn: model.
	cls := model smalltalkClass
]

{ #category : 'tests' }
UPGEnumGeneratorTest >> testClassCreated [
	self assert: cls name equals: model name.
	self assert: cls package name equals: model parentPackage name.
	self assert: cls superclass name equals: #Object
]

{ #category : 'tests' }
UPGEnumGeneratorTest >> testClassMethods [
	self assert: cls class selectors asSet equals: #(#person #system #enum) asSet.
	self
		ast: (cls class >> #person) ast
		equals:
			'person
	"Generated method"
	^ self enum person'.
	self assert: (cls class >> #person) protocol equals: 'accessing - literals'
]

{ #category : 'tests' }
UPGEnumGeneratorTest >> testInstanceMethods [
	self assert: cls selectors asSet equals: #(#organization #person #system) asSet.
	self
		ast: (cls >> #organization) ast
		equals:
			'organization
	"Generated method"
	^ #organization'.
	self assert: (cls >> #organization) protocol equals: 'accessing - literals'
]

{ #category : 'tests' }
UPGEnumGeneratorTest >> testLiteralsFor [
	self
		assert: (generator literalsFor: model)
		equals:
			(Dictionary
				with: #organization -> '#organization'
				with: #person -> '#person'
				with: #system -> '#system')
]

{ #category : 'tests' }
UPGEnumGeneratorTest >> testMetaMethods [
	self assert: cls class instVarNames equals: #(#Default).
	self assert: (cls class selectors includes: #enum).
	self
		ast: (cls class >> #enum) ast
		equals:
			'enum
	"Generated method"
	^ Default ifNil: [ Default := self new ]'.
	self assert: (cls class >> #enum) protocol equals: 'accessing'
]
