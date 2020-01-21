"
I am a parser for string representation of a UML property.

!! Reference
9.5.4 Properties Notation

!! Todo
NOTE that the parser currently does NOT support all specified options.
"
Class {
	#name : #OPUmlPropertyGrammar,
	#superclass : #OPUmlPropGrammar,
	#instVars : [
		'propName',
		'propType',
		'property',
		'defaultValue'
	],
	#category : 'OpenPonk-UML-DSL-Grammar'
}

{ #category : #grammar }
OPUmlPropertyGrammar >> defaultValue [
	^ (#blank asParser star , $= asParser , (#any asParser starLazy: #endOfLine asParser and))
		==> [ :nodes | (nodes third joinUsing: '') trim ]
]

{ #category : #grammar }
OPUmlPropertyGrammar >> propName [
	^ symbol
]

{ #category : #grammar }
OPUmlPropertyGrammar >> propType [
	^ symbol
]

{ #category : #grammar }
OPUmlPropertyGrammar >> property [
	^ prefix, visibility optional , propName , (($: asParser , propType) ==> [ :n | n second ]) optional , multiplicity, defaultValue optional
]

{ #category : #grammar }
OPUmlPropertyGrammar >> start [
	^ property end
]
