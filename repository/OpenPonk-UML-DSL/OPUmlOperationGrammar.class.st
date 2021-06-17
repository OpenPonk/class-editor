"
I am parsing string representation of UML class diagram objects like names, attributes, operations, or multiplicities.

!! Reference
9.4.4 Parameter Notation
9.6.4 Operation Notation

!! Todo
NOTE that the parser currently does NOT support all specified options.
"
Class {
	#name : #OPUmlOperationGrammar,
	#superclass : #OPUmlPropGrammar,
	#instVars : [
		'parameterList',
		'returnValue',
		'operation',
		'parameter',
		'opName',
		'parameters'
	],
	#category : 'OpenPonk-UML-DSL-Grammar'
}

{ #category : #grammar }
OPUmlOperationGrammar >> opName [
	^ ((symbol , $: asParser) plus ==> [ :nodes | nodes flatten joinUsing: '' ]) / symbol
]

{ #category : #grammar }
OPUmlOperationGrammar >> operation [
	^ prefix, visibility optional , opName , parameters , returnValue optional
]

{ #category : #grammar }
OPUmlOperationGrammar >> parameter [
	^ symbol , (($: asParser , type) ==> [ :nodes | nodes second ]) optional , multiplicity
]

{ #category : #grammar }
OPUmlOperationGrammar >> parameterList [
	^ (parameter separatedBy: $, asParser) withoutSeparators optional
		==> [ :nodes | nodes ifNil: [ #() ] ]
]

{ #category : #grammar }
OPUmlOperationGrammar >> parameters [
	^ ($( asParser , parameterList , $) asParser) ==> [ :nodes | nodes second ]
]

{ #category : #grammar }
OPUmlOperationGrammar >> returnValue [
	^ (Character space asParser star , $: asParser , type , multiplicity)
		==> [ :nodes | nodes allButFirst: 2 ]
]

{ #category : #grammar }
OPUmlOperationGrammar >> start [
	^ operation end
]
