Class {
	#name : #UPGSimpleAccessorsGeneratorTest,
	#superclass : #UPGBaseGeneratorTest,
	#instVars : [
		'university',
		'department',
		'uniToDept'
	],
	#category : 'UML-CodeGenerator-Tests'
}

{ #category : #hooks }
UPGSimpleAccessorsGeneratorTest >> createModel [
	| associations |
	model := 'University[1] university <*>-- departments Department[*];' asClassDiagram.
	university := model detect: [ :each | each name = #University ].
	department := model detect: [ :each | each name = #Department ].
	associations := model select: #isBinaryAssociation.
	uniToDept := associations
		detect: [ :each | (each source name = #University & each target name) = #Department ]
]

{ #category : #running }
UPGSimpleAccessorsGeneratorTest >> setUp [
	super setUp.
	generator := UPGSimpleAccessorsGenerator new.
	generator context useEagerInitialization.
	cls := self newClassNamed: #SomethingGenerated.
	self createModel
]

{ #category : #tests }
UPGSimpleAccessorsGeneratorTest >> testAdder [
	self
		ast: (generator adder: uniToDept targetEnd)
		equals:
			'addDepartment: aDepartment
			departments add: aDepartment'
]

{ #category : #tests }
UPGSimpleAccessorsGeneratorTest >> testGetter [
	self
		ast: (generator getter: uniToDept sourceEnd)
		equals:
			'university <DCAssociation: ''University university <*>-- departments Department[*]''> ^ university'
]

{ #category : #tests }
UPGSimpleAccessorsGeneratorTest >> testGetter1 [
	self
		ast: (generator getter: uniToDept targetEnd)
		equals:
			'departments <DCAssociation: ''University university <*>-- departments Department[*]''> ^ departments'
]

{ #category : #tests }
UPGSimpleAccessorsGeneratorTest >> testGetterEager [
	generator context useEagerInitialization.
	self
		ast: (generator getter: uniToDept sourceEnd)
		equals:
			'university <DCAssociation: ''University university <*>-- departments Department[*]''> ^ university'
]

{ #category : #tests }
UPGSimpleAccessorsGeneratorTest >> testGetterLazy [
	generator context useLazyInitialization.
	self
		ast: (generator getter: uniToDept sourceEnd)
		equals:
			'university <DCAssociation: ''University university <*>-- departments Department[*]''> ^ university ifNil: [ university := OrderedCollection new ]'
]

{ #category : #tests }
UPGSimpleAccessorsGeneratorTest >> testRemover [
	self
		ast: (generator remover: uniToDept targetEnd)
		equals:
			'removeDepartment: aDepartment
			departments remove: aDepartment'
]

{ #category : #tests }
UPGSimpleAccessorsGeneratorTest >> testSetter [
	self
		ast: (generator setter: uniToDept sourceEnd)
		equals:
			'university: anUniversity
			university := anUniversity'
]

{ #category : #tests }
UPGSimpleAccessorsGeneratorTest >> testSetter1 [
	self
		ast: (generator setter: uniToDept targetEnd)
		equals:
			'departments: aCollection
			departments := aCollection'
]
