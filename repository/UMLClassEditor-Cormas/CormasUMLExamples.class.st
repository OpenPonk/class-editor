Class {
	#name : #CormasUMLExamples,
	#superclass : #Object,
	#category : 'UMLClassEditor-Cormas-Examples'
}

{ #category : #'as yet unclassified' }
CormasUMLExamples class >> createNewModel [
	| modelName projectName project model |
	projectName := UIManager default request: 'New model name'.
	modelName := ((projectName splitOn: ' ') collect: #capitalized) joinUsing: ''.
	project := OPProject named: projectName.
	(model := MooseModel new)
		name: projectName;
		isCormasModel: true.
	model
		add:
			((FAMIXClass named: modelName)
				addStereotype: (OPFAMIXStereotype named: 'CormasModel');
				yourself).
	project addModel: model.
	OPWorkbench openProject: project
]

{ #category : #'as yet unclassified' }
CormasUMLExamples class >> exampleCormas [
	| model diagramInterchange |
	model := self sampleCormas.
	model name: 'MyECEC'.
	"	diagramInterchange := self sampleDslDIFor: model."
	OPProject new
		projectName: 'My ECEC';
		addModel: model;
		"		layout: diagramInterchange for: model;"
			open
]

{ #category : #'as yet unclassified' }
CormasUMLExamples class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: #CormasUMLExamples)
		parent: #UMLClassEditor;
		label: 'New Cormas Model';
		icon: OPIcons current dcOmlDiagramIcon;
		action: [ self createNewModel ]
]

{ #category : #'as yet unclassified' }
CormasUMLExamples class >> sampleCormas [
	^ OPUmlDslParser
		parse:
			'
MyECEC <<CormasModel>> {
	
}

/Forager <<Agent>> {
	_catabolicRate = 2
	_fertilityThreshold = 100
	_harvestRate
	energy = 50
}

Restrained >> Forager;

MyECEC --> theRestraineds Restrained[*];'
]
