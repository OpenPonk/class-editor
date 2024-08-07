Class {
	#name : 'LIVInstanceCompositeSpecificationBuilder',
	#superclass : 'Object',
	#instVars : [
		'specs',
		'defaultBuilder'
	],
	#category : 'LiveInstanceVisualization-Models',
	#package : 'LiveInstanceVisualization',
	#tag : 'Models'
}

{ #category : 'as yet unclassified' }
LIVInstanceCompositeSpecificationBuilder class >> exampleSpec [
| modelDefs history links |
modelDefs := LIVInstanceCompositeSpecificationBuilder new.
modelDefs addSpec: [ :spec |
	spec classifier: SpecWrapper.
	spec name: #hash.
	spec
		addSlot: #selector -> nil;
		addSlot: #instance -> nil.
].
modelDefs addSpec: [ :spec |
	spec classifier: ComposableModel.
	spec name: #hash.
	spec addSlot: #spec -> nil.
].
modelDefs addSpec: [ :spec |
	spec classifier: MorphicContainerAdapter.
	spec name: #hash.
	spec addSlot: #added -> [ OrderedCollection new ]
].

history := LIVInstanceHistory new.
history specificationBuilder: modelDefs.

links := MTMetaLinkRegistration new.

links addLink: [ :link |
link
	target: SpecWrapper>>#selector:;
	control: #after;
	action: [ :object |
		history inNewState: [ :model |
			model to: object at: #selector put: object selector
		]
	]
].

links addLink: [ :link |
link
	target: SpecWrapper>>#instance:;
	control: #after;
	action: [ :object |
		history inNewState: [ :model |
			model setLinkFrom: object to: object instance at: #instance.
		]
	]
].

links addLink: [ :link |
link
	target: ComposableModel>>#initialize;
	control: #before;
	action: [ :object |
		history inNewState: [ :model | model ensureInstanceFor: object ]
	]
].

links addLink: [ :link |
link
	target: ComposableModel>>#spec:;
	control: #before;
	action: [ :object :arguments |
		(object spec = arguments first) not & object spec isNotNil ifTrue: [
			history inNewState: [ :model |
				model removeLinkFrom: object at: #spec.
			]
		]
	]
].

links addLink: [ :link |
link
	target: ComposableModel>>#spec:;
	control: #after;
	action: [ :object |
		history inNewState: [ :model |
			model setLinkFrom: object to: object spec at: #spec.
		]
	]
].

links addLink: [ :link |
link
	target: AbstractMorphicAdapter>>#add:;
	control: #after;
	action: [ :object :arguments |
		history inNewState: [ :model |
			model addLinkFrom: object to: arguments first at: #added
		]
	]
].
	
links install.
history inspect.

"
links uninstall
"
]

{ #category : 'adding' }
LIVInstanceCompositeSpecificationBuilder >> addSpec: aOneArgBlock [
	| spec |
	spec := LIVInstanceSpecificationBuilder new.
	aOneArgBlock value: spec.
	specs add: spec
]

{ #category : 'as yet unclassified' }
LIVInstanceCompositeSpecificationBuilder >> defaultInstanceBuilder [
	^ LIVInstanceSpecificationBuilder new name: #hash
]

{ #category : 'initialization' }
LIVInstanceCompositeSpecificationBuilder >> initialize [
	super initialize.
	specs := OrderedCollection new.
	defaultBuilder := self defaultInstanceBuilder
]

{ #category : 'as yet unclassified' }
LIVInstanceCompositeSpecificationBuilder >> instanceOn: anObject [
	^ specs
		detect: [ :each | anObject isKindOf: each classifier ]
		ifFound: [ :each | each instanceOn: anObject ]
		ifNone: [ defaultBuilder instanceOn: anObject ]
]
