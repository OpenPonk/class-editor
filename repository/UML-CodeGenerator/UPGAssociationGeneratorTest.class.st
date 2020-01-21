Class {
	#name : #UPGAssociationGeneratorTest,
	#superclass : #UPGBaseGeneratorTest,
	#instVars : [
		'president',
		'university',
		'department',
		'teacher',
		'name',
		'oneToOne',
		'oneToMany',
		'manyToMany',
		'result',
		'noneToMany',
		'noneToOne'
	],
	#category : 'UML-CodeGenerator-Tests'
}

{ #category : #'instance creation' }
UPGAssociationGeneratorTest >> createModel [
	| associations |
	model := 'President president --- university University;
University[1] university <*>-- departments Department[*];
Department[*] memberOf <>-- teachers Teacher[*];
President --> name Name;
Teacher --> names Name[*];' asClassDiagram.
	president := model detect: [ :each | each name = #President ].
	university := model detect: [ :each | each name = #University ].
	department := model detect: [ :each | each name = #Department ].
	teacher := model detect: [ :each | each name = #Teacher ].
	name := model detect: [ :each | each name = #Name ].
	associations := model select: #isBinaryAssociation.
	oneToOne := associations
		detect: [ :each | (each source name = #President & each target name) = #University ].
	oneToMany := associations
		detect: [ :each | (each source name = #University & each target name) = #Department ].
	manyToMany := associations
		detect: [ :each | (each source name = #Department & each target name) = #Teacher ].
	noneToOne := associations
		detect: [ :each | (each source name = #President & each target name) = #Name ].
	noneToMany := associations
		detect: [ :each | (each source name = #Teacher & each target name) = #Name ]
]

{ #category : #running }
UPGAssociationGeneratorTest >> setUp [
	super setUp.
	generator := UPGDirectAssociationGenerator new.
	cls := self newClassNamed: #SomethingGenerated.
	self createModel
]

{ #category : #tests }
UPGAssociationGeneratorTest >> testAdderManyToMany [
	self
		ast: (generator adder: manyToMany targetEnd)
		equals:
			'addTeacher: aTeacher
	(teachers includes: aTeacher) ifTrue: [ ^ self ].
	teachers add: aTeacher.
	aTeacher addMemberOf: self'
]

{ #category : #tests }
UPGAssociationGeneratorTest >> testAdderNoneToMany [
	self
		ast: (generator adder: noneToMany targetEnd)
		equals:
			'addName: aName
	(names includes: aName) ifTrue: [ ^ self ].
	names add: aName'
]

{ #category : #tests }
UPGAssociationGeneratorTest >> testAdderOneToMany [
	self
		ast: (generator adder: oneToMany targetEnd)
		equals:
			'addDepartment: aDepartment
	(departments includes: aDepartment) ifTrue: [ ^ self ].
	departments add: aDepartment.
	aDepartment university: self'
]

{ #category : #tests }
UPGAssociationGeneratorTest >> testGeneratedManyToOne [
	generator resolveAssociationEnd: oneToMany targetEnd in: cls.
	self assert: cls instVarNames equals: #(#departments).
	self
		assert: cls selectors asSet
		equals: #(#departments #departments: #addDepartment: #removeDepartment: #initialize) asSet
]

{ #category : #tests }
UPGAssociationGeneratorTest >> testGeneratedOneToMany [
	generator resolveAssociationEnd: oneToMany sourceEnd in: cls.
	self assert: cls instVarNames equals: #(#university).
	self assert: cls selectors asSet equals: #(#university #university:) asSet
]

{ #category : #tests }
UPGAssociationGeneratorTest >> testGetterOneToOne [
	self
		ast: (generator getter: oneToOne targetEnd)
		equals: 'university "<DCAssociation: ''President president --- university University''>" ^ university'
]

{ #category : #tests }
UPGAssociationGeneratorTest >> testRemoverManyToMany [
	self
		ast: (generator remover: manyToMany targetEnd)
		equals:
			'removeTeacher: aTeacher
	(teachers includes: aTeacher) ifFalse: [ ^ self ].
	teachers remove: aTeacher.
	aTeacher removeMemberOf: self'
]

{ #category : #tests }
UPGAssociationGeneratorTest >> testRemoverNoneToMany [
	self
		ast: (generator remover: noneToMany targetEnd)
		equals:
			'removeName: aName
	(names includes: aName) ifFalse: [ ^ self ].
	names remove: aName'
]

{ #category : #tests }
UPGAssociationGeneratorTest >> testRemoverOneToMany [
	self
		ast: (generator remover: oneToMany targetEnd)
		equals:
			'removeDepartment: aDepartment
	(departments includes: aDepartment) ifFalse: [ ^ self ].
	departments remove: aDepartment.
	aDepartment university: nil'
]

{ #category : #tests }
UPGAssociationGeneratorTest >> testSetterManyToOne [
	self
		ast: (generator setter: oneToMany sourceEnd)
		equals:
			'university: anUniversity
	|oldRef|
	university = anUniversity ifTrue: [ ^ self ].
	oldRef := university.
	university := anUniversity.
	"oldRef ifNotNil: [ oldRef removeDepartment: self ]."
	oldRef ifNotNil: [ oldRef forgetAttribute: #department ].
	university ifNotNil: [ university addDepartment: self ]'
]

{ #category : #tests }
UPGAssociationGeneratorTest >> testSetterNoneToMany [
	self ast: (generator setter: noneToMany targetEnd) equals: 'names: aCollection names := aCollection'
]

{ #category : #tests }
UPGAssociationGeneratorTest >> testSetterNoneToOne [
	self ast: (generator setter: noneToOne targetEnd) equals: 'name: aName name := aName'
]

{ #category : #tests }
UPGAssociationGeneratorTest >> testSetterOneToMany [
	self
		ast: (generator setter: oneToMany targetEnd)
		equals:
			'departments: aCollection
	[ departments isNotEmpty ] whileTrue: [ self removeDepartment: departments anyOne ].
	aCollection do: [ :each | self addDepartment: each ]'
]

{ #category : #tests }
UPGAssociationGeneratorTest >> testSetterOneToOne [
	self
		ast: (generator setter: oneToOne targetEnd)
		equals:
			'university: anUniversity
		|oldRef|
		university = anUniversity ifTrue: [ ^ self ].
		oldRef := university.
		university := anUniversity.
		"oldRef ifNotNil: [ oldRef president: nil ]."
		oldRef ifNotNil: [ oldRef forgetAttribute: #president ].
		university ifNotNil: [ university president: self ]'
]
