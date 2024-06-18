"
I create FAMIX classes from a DSL.

!! Examples

MyClass => Create a FAMIXClass named 'MyClass'
/MyClass/ => The class is abstract
"
Class {
	#name : 'OPUmlClassBuilder',
	#superclass : 'PPCompositeParser',
	#instVars : [
		'symbol',
		'classBlock',
		'dslName',
		'block',
		'statements',
		'statement',
		'fqn',
		'keyword'
	],
	#category : 'OpenPonk-UML-DSL-Builders',
	#package : 'OpenPonk-UML-DSL',
	#tag : 'Builders'
}

{ #category : 'accessing' }
OPUmlClassBuilder class >> dependencies [
	^ {OPUmlAttributeBuilder.
	OPUmlMethodBuilder}
]

{ #category : 'accessing' }
OPUmlClassBuilder >> block [
	^ (${ asParser , #space asParser star , statements , #space asParser star , $} asParser)
		==> [ :nodes | nodes third ]
]

{ #category : 'accessing' }
OPUmlClassBuilder >> classBlock [
	^ (dslName, keyword , #blank asParser plus , block)
		==>
			[ :nodes | 
			(FAMIXClass named: nodes first second)
				stereotypes: nodes second;
				isAbstract: nodes first first;
				methods: (nodes fourth select: #isMethod);
				attributes: (nodes fourth select: #isAttribute) ]
]

{ #category : 'accessing' }
OPUmlClassBuilder >> dslName [
	^ ($/ asParser optional , fqn)
		==>
			[ :nodes | Array with: (nodes first ifNil: [ false ] ifNotNil: [ nodes first = $/ ]) with: nodes second ]
]

{ #category : 'accessing' }
OPUmlClassBuilder >> fqn [
	^ ('::' asParser optional , symbol , ('::' asParser , symbol) star)
		==> [ :nodes | (nodes flattened asOrderedCollection removeAllSuchThat: #isNil) joinUsing: '' ]
]

{ #category : 'accessing' }
OPUmlClassBuilder >> keyword [
	^ ('<<' asParser trim , (symbol trim separatedBy: ',' asParser) withoutSeparators , '>>' asParser trimLeft) optional
		==>
			[ :nodes | 
			nodes
				ifNil: [ OrderedCollection new ]
				ifNotNil:
					[ (nodes second removeAllSuchThat: #isEmpty) collect: [ :each | OPFAMIXStereotype named: each ] as: OrderedCollection ] ]
]

{ #category : 'accessing' }
OPUmlClassBuilder >> start [
	^ classBlock end
]

{ #category : 'accessing' }
OPUmlClassBuilder >> statement [
	^ (self dependencyAt: OPUmlMethodBuilder) operation
		/ (self dependencyAt: OPUmlAttributeBuilder) property
]

{ #category : 'accessing' }
OPUmlClassBuilder >> statements [
	^ ((statement , #newline asParser star) ==> [ :nodes | nodes first ]) star
]

{ #category : 'accessing' }
OPUmlClassBuilder >> symbol [
	^ #word asParser plus ==> [ :nodes | nodes joinUsing: '' ]
]
