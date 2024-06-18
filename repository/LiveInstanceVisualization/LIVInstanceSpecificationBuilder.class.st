Class {
	#name : 'LIVInstanceSpecificationBuilder',
	#superclass : 'Object',
	#instVars : [
		'name',
		'slots',
		'classifier'
	],
	#category : 'LiveInstanceVisualization-Models',
	#package : 'LiveInstanceVisualization',
	#tag : 'Models'
}

{ #category : 'as yet unclassified' }
LIVInstanceSpecificationBuilder class >> example1 [
	<playground>
| inst builder model v el |
inst := OPUmlStyle new fontSize: 11; fontUnderline: true.

builder := LIVInstanceSpecificationBuilder new.
builder name: nil.
builder addFromAssociation: #fontSize -> #fontSize.
builder addFromAssociation: #fontUnderline -> #fontUnderline.

model := builder instanceOn: inst.

v := RTView new.
el := model asShape.
el renderIn: v.
el rtElement when: TRMouseLeftClick do: [ :evt |  ].
el rtElement @ RTResizable @ RTDraggable.
v
]

{ #category : 'as yet unclassified' }
LIVInstanceSpecificationBuilder class >> exampleWithHistory [
	<playground>
| b1 b2 hist m1 ui m2 m3 m4 m5 uiM bM m6 v from to diff colorer |
b1 := LIVInstanceSpecificationBuilder new.
b1 name: 'source'.

b2 := LIVInstanceSpecificationBuilder new.
b2 name: 'button'.
b2 addFromAssociation: #owner -> nil.

hist := LIVInstanceHistory new.
m1 := LIVInstanceModel new.
hist add: m1.

ui := DynamicComposableModel new.
m2 := LIVInstanceModel new.
m2 add: (b1 instanceOn: ui).
hist add: m2.

ui instantiateModels: #(button ButtonModel).
b1 addFromAssociation: #button -> nil.
m3 := LIVInstanceModel new.
m3 add: (b1 instanceOn: ui).
hist add: m3.

m4 := LIVInstanceModel new.
m4 add: (b1 instanceOn: ui).
m4 add: (b2 instanceOn: ui button).
hist add: m4.

m5 := LIVInstanceModel new.
uiM := b1 instanceOn: ui.
bM := b2 instanceOn: ui button.
uiM slots at: #button put: bM.
m5 add: uiM; add: bM.
hist add: m5.

m6 := LIVInstanceModel new.
uiM := b1 instanceOn: ui.
bM := b2 instanceOn: ui button.
uiM slots at: #button put: bM.
bM slots at: #owner put: uiM.
m6 add: uiM; add: bM.
hist add: m6.

v := RTView new.

from := hist models second.
to := hist models sixth.

diff := LIVInstanceModelDiff new diffBetween: from and: to.

to renderIn: v.

colorer := LIVInstanceDiffColorer new.
colorer colorAll: diff in: v.

v
]

{ #category : 'as yet unclassified' }
LIVInstanceSpecificationBuilder class >> exampleWithMetalinks [
	<playground>
| history wrapperSpec modelSpec wrapSelectorLink wrapInstanceLink cmInitLink cmSpecLink links |
history := LIVInstanceHistory new.
history add: (LIVInstanceModel new).

"added to SpecWrapper>>instance:selector: #after"
(wrapperSpec := LIVInstanceSpecificationBuilder new)
	name: [ :obj | obj hash asString ];
	addFromAssociation: #selector -> nil;
	addFromAssociation: #instance -> nil.

"added to ComposableModel>>#initialize #before"
(modelSpec := LIVInstanceSpecificationBuilder new)
	name: [ :obj | obj hash asString ];
	addFromAssociation: #spec -> nil.

(wrapSelectorLink := MTMetaLinkUser new)
	target: SpecWrapper>>#selector:;
	control: #after;
	action: [ :object |
		history newState in: [ :model |
			(model specificationFor: object ifAbsentPut: [ wrapperSpec instanceOn: object ])
				slots at: #selector put: object selector
		]
	].	

(wrapInstanceLink := MTMetaLinkUser new)
	target: SpecWrapper>>#instance:;
	control: #after;
	action: [ :object |
		history newState in: [ :model | |objectModel|
			objectModel := model specificationFor: object ifAbsentPut: [ wrapperSpec instanceOn: object ].
			(object instance isKindOf: ComposableModel) ifTrue: [ 
			objectModel slots at: #instance put: (model specificationFor: object instance ifAbsentPut: [ modelSpec instanceOn: object instance]) ]
		ifFalse: [ objectModel slots at: #instance put: object instance printString ]
			]
	].


(cmInitLink := MTMetaLinkUser new)
	target: ComposableModel>>#initialize;
	control: #before;
	action: [ :object |
		history newState add: (modelSpec instanceOn: object)
	].

(cmSpecLink := MTMetaLinkUser new)
	target: ComposableModel>>#spec:;
	control: #after;
	action: [ :object |
		history newState in: [ :model |
			(model specificationFor: object) in: [ :instSpec |
				instSpec slots at: #spec put: (model specificationFor: object spec ifAbsentPut: [ wrapperSpec instanceOn: object spec])
			].
		].
	].

links := { 
	wrapSelectorLink.
	wrapInstanceLink.
	cmInitLink.
	cmSpecLink.
}.

links do: #install.

history inspect.

"
links do: #uninstall.
"
]

{ #category : 'adding' }
LIVInstanceSpecificationBuilder >> addSlot: anAssociation [
	slots add: anAssociation
]

{ #category : 'accessing' }
LIVInstanceSpecificationBuilder >> classifier [
	^ classifier
]

{ #category : 'accessing' }
LIVInstanceSpecificationBuilder >> classifier: anObject [
	classifier := anObject
]

{ #category : 'initialization' }
LIVInstanceSpecificationBuilder >> initialize [
	super initialize.
	name := nil.
	slots := OrderedDictionary new
]

{ #category : 'as yet unclassified' }
LIVInstanceSpecificationBuilder >> instanceOn: anObject [
	| model |
	model := self newModel.
	model classifier: anObject class.
	model instanceHash: anObject hash.
	name ifNotNil: [ model name: (name cull: anObject) ].
	slots
		keysAndValuesDo: [ :key :value | model slots at: key put: (value ifNotNil: [ value cull: anObject ]) ].
	^ model
]

{ #category : 'accessing' }
LIVInstanceSpecificationBuilder >> name: aStringOrBlock [
	aStringOrBlock isString & aStringOrBlock isSymbol not
		ifTrue: [ name := [ :obj | aStringOrBlock ] ]
		ifFalse: [ name := aStringOrBlock ]
]

{ #category : 'as yet unclassified' }
LIVInstanceSpecificationBuilder >> newModel [
	^ LIVInstanceSpecification new
]
