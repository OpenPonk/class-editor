Class {
	#name : 'UPGFameAssociationsGeneratorTest',
	#superclass : 'UPGBaseGeneratorTest',
	#instVars : [
		'university',
		'department',
		'uniToDept'
	],
	#category : 'UML-CodeGenerator-Tests',
	#package : 'UML-CodeGenerator',
	#tag : 'Tests'
}

{ #category : 'hooks' }
UPGFameAssociationsGeneratorTest >> createModel [
	| associations |
	model := 'University[1] university <*>-- departments Department[*];' asClassDiagram.
	university := model detect: [ :each | each name = #University ].
	department := model detect: [ :each | each name = #Department ].
	associations := model select: #isBinaryAssociation.
	uniToDept := associations
		detect: [ :each | (each source name = #University & each target name) = #Department ]
]

{ #category : 'accessing' }
UPGFameAssociationsGeneratorTest >> generatorClass [
	^ UPGFameAssociationsGenerator
]

{ #category : 'running' }
UPGFameAssociationsGeneratorTest >> setUp [
	super setUp.
	generator := self generatorClass new.
	generator context useEagerInitialization.
	cls := self newClassNamed: #SomethingGenerated.
	self createModel
]

{ #category : 'tests' }
UPGFameAssociationsGeneratorTest >> testAdder [
	self
		ast: (generator adder: uniToDept targetEnd)
		equals:
			'addDepartment: aDepartment
			departments add: aDepartment'
]

{ #category : 'tests' }
UPGFameAssociationsGeneratorTest >> testGetter [
	self
		ast: (generator getter: uniToDept sourceEnd)
		equals:
			'university <DCAssociation: ''University university <*>-- departments Department[*]''> ^ university'
]

{ #category : 'tests' }
UPGFameAssociationsGeneratorTest >> testGetter1 [
	self
		ast: (generator getter: uniToDept targetEnd)
		equals:
			'departments <DCAssociation: ''University university <*>-- departments Department[*]''> ^ departments'
]

{ #category : 'tests' }
UPGFameAssociationsGeneratorTest >> testGetterEager [
	generator context useEagerInitialization.
	self
		ast: (generator getter: uniToDept sourceEnd)
		equals:
			'university <DCAssociation: ''University university <*>-- departments Department[*]''> ^ university'
]

{ #category : 'tests' }
UPGFameAssociationsGeneratorTest >> testGetterLazy [
	generator context useLazyInitialization.
	self
		ast: (generator getter: uniToDept sourceEnd)
		equals:
			'university <DCAssociation: ''University university <*>-- departments Department[*]''> ^ university'
]

{ #category : 'tests' }
UPGFameAssociationsGeneratorTest >> testRemover [
	self
		ast: (generator remover: uniToDept targetEnd)
		equals:
			'removeDepartment: aDepartment
			departments remove: aDepartment'
]

{ #category : 'tests' }
UPGFameAssociationsGeneratorTest >> testSetterMany [
	true
		ifTrue: [ ^ self skip: 'not yet implemented' ].
	self
		ast: (generator setter: uniToDept targetEnd)
		equals:
			'departments: aCollection
			departments value: aCollection'
]

{ #category : 'tests' }
UPGFameAssociationsGeneratorTest >> testSetterOne [
	true
		ifTrue: [ ^ self skip: 'not yet implemented' ].
	self
		ast: (generator setter: uniToDept sourceEnd)
		equals:
			'university: anUniversity
			university := FMMultivalueLink
				on: self
				update: #departments
				from: university
				to: anUniversity'
]
