Class {
	#name : #LIVInstanceModelTest,
	#superclass : #TestCase,
	#instVars : [
		'model'
	],
	#category : 'LiveInstanceVisualization-Tests'
}

{ #category : #running }
LIVInstanceModelTest >> setUp [
	| specBuilder history |
	super setUp.
	specBuilder := LIVInstanceCompositeSpecificationBuilder new.
	self setupBuilder: specBuilder.
	history := LIVInstanceHistory new.
	history specificationBuilder: specBuilder.
	model := history newState
]

{ #category : #running }
LIVInstanceModelTest >> setupBuilder: aBuilder [
	aBuilder
		addSpec: [ :spec | 
			spec classifier: LIVTestContainer.
			spec name: #identityHash.
			spec addSlot: #items -> [ OrderedCollection new ] ].
	aBuilder
		addSpec: [ :spec | 
			spec classifier: LIVTestItem.
			spec name: #identityHash.
			spec addSlot: #container -> nil ]
]

{ #category : #'tests - adding' }
LIVInstanceModelTest >> testAddLinkFromToAt [
	| container item |
	container := LIVTestContainer new.
	item := LIVTestItem new.
	model addLinkFrom: container to: item at: #items.
	self
		assert: ((model specificationFor: container) slots at: #items) asArray
		equals: {model specificationFor: item}
]

{ #category : #'tests - adding' }
LIVInstanceModelTest >> testEnsureInstance [
	| inst |
	inst := LIVTestItem new.
	self deny: (model specificationFor: inst ifNone: [ false ]).
	model ensureInstanceFor: inst.
	self assert: (model specificationFor: inst) instanceHash equals: inst identityHash
]

{ #category : #'tests - removing' }
LIVInstanceModelTest >> testRemoveInstance [
	| container item |
	container := LIVTestContainer new.
	item := LIVTestItem new.
	model addLinkFrom: container to: item at: #items.
	model removeLinkFrom: container to: item at: #items.
	self assert: model elements asArray equals: {model specificationFor: container}
]

{ #category : #'tests - removing' }
LIVInstanceModelTest >> testRemoveInstanceNot [
	| container item |
	container := LIVTestContainer new.
	item := LIVTestItem new.
	model addLinkFrom: container to: item at: #items.
	model removeInstance: (model specificationFor: item).
	self
		assert: model elements asArray
		equals:
			{model specificationFor: container.
			model specificationFor: item}
]

{ #category : #'tests - removing' }
LIVInstanceModelTest >> testRemoveLinkFromToAt [
	| container item |
	container := LIVTestContainer new.
	item := LIVTestItem new.
	model addLinkFrom: container to: item at: #items.
	model removeLinkFrom: container to: item at: #items.
	self assert: ((model specificationFor: container) slots at: #items) asArray equals: #()
]

{ #category : #'tests - removing' }
LIVInstanceModelTest >> testRemoveLinksFromAtCollection [
	| container item |
	container := LIVTestContainer new.
	item := LIVTestItem new.
	model addLinkFrom: container to: item at: #items.
	model removeLinksFrom: container at: #items.
	self assert: ((model specificationFor: container) slots at: #items) asArray equals: #().
	self assert: model elements asArray equals: {model specificationFor: container}
]

{ #category : #'tests - removing' }
LIVInstanceModelTest >> testRemoveLinksFromAtDirect [
	| container item |
	container := LIVTestContainer new.
	item := LIVTestItem new.
	model setLinkFrom: item to: container at: #container.
	model removeLinksFrom: item at: #container.
	self assert: ((model specificationFor: item) slots at: #container) equals: nil.
	self assert: model elements asArray equals: {model specificationFor: item}
]

{ #category : #'tests - adding' }
LIVInstanceModelTest >> testSetLinkFromToAt [
	| container item |
	container := LIVTestContainer new.
	item := LIVTestItem new.
	model setLinkFrom: item to: container at: #container.
	self
		assert: ((model specificationFor: item) slots at: #container)
		equals: (model specificationFor: container)
]

{ #category : #'tests - adding' }
LIVInstanceModelTest >> testSetValueFromToAt [
	| container item |
	container := LIVTestContainer new.
	item := LIVTestItem new.
	model setValueFrom: item to: container at: #container.
	self assert: ((model specificationFor: item) slots at: #container) equals: container
]

{ #category : #'tests - removing' }
LIVInstanceModelTest >> testUnsetLinkFromAt [
	| container item |
	container := LIVTestContainer new.
	item := LIVTestItem new.
	model setLinkFrom: item to: container at: #container.
	model unsetLinkFrom: item at: #container.
	self assert: ((model specificationFor: item) slots at: #container) equals: nil
]
