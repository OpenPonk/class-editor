Class {
	#name : #OPUmlAttributeControllerTest,
	#superclass : #OPUmlElementControllerTest,
	#category : 'OpenPonk-ClassEditor-Tests - Controllers'
}

{ #category : #accessing }
OPUmlAttributeControllerTest >> controllerClass [
	^ OPUmlAttributeController
]

{ #category : #accessing }
OPUmlAttributeControllerTest >> modelClass [
	^ OPUMLProperty
]

{ #category : #'tests - creation' }
OPUmlAttributeControllerTest >> testCanClassBeTarget [
	| classController |
	classController := OPUmlClassController new.
	self assert: (classController canBeTargetFor: controller)
]

{ #category : #'tests - creation' }
OPUmlAttributeControllerTest >> testClassBeTarget [
	| classController |
	classController := diagramController newControllerFor: OPUMLClass new.
	diagramController addController: classController.
	classController showInDiagram: diagramController.
	classController addAsTargetFor: controller.
	self assert: classController model ownedAttributes asArray equals: {controller model}
]

{ #category : #'tests - creation' }
OPUmlAttributeControllerTest >> testCreateDiagramElement [
	self assert: controller createDiagramElement class equals: OPUmlLabel
]

{ #category : #tests }
OPUmlAttributeControllerTest >> testDescriptionAccessorRead [
	| accessor model |
	accessor := controller descriptionAccessor: #isDerived.
	model := OPUMLProperty new.
	model isDerived: true.
	controller model: model.
	self assert: (accessor read: controller).
	model isDerived: false.
	self deny: (accessor read: controller)
]

{ #category : #tests }
OPUmlAttributeControllerTest >> testDescriptionAccessorWrite [
	| accessor model |
	accessor := controller descriptionAccessor: #isDerived.
	model := OPUMLProperty new.
	controller model: model.
	accessor write: true to: controller.
	self assert: model isDerived.
	accessor write: false to: controller.
	self deny: model isDerived
]

{ #category : #tests }
OPUmlAttributeControllerTest >> testDescriptions [
	| container |
	container := controller magritteDescription.
	self assert: (container anySatisfy: [ :each | each label = 'Name' ]).
	self assert: (container anySatisfy: [ :each | each label = 'Is Derived' ]).
]

{ #category : #tests }
OPUmlAttributeControllerTest >> testNotationText [
	self
		assert:
			(controller
				notationTextFor:
					(OPUMLProperty new
						name: 'attr';
						isDerived: true))
		equals: '/attr'
]

{ #category : #'tests - removing' }
OPUmlAttributeControllerTest >> testRemoveFromView [
	| class compartment prop |
	class := OPUMLClass new.
	prop := OPUMLProperty new.
	class ownedAttributes add: prop.
	diagramController showModelInDiagram: class.
	controller := diagramController controllerForModel: prop.
	compartment := controller diagramElement owningElement.
	controller remove.
	self assert: compartment ownedElements asArray equals: #()
]

{ #category : #tests }
OPUmlAttributeControllerTest >> testSupport [
	self assert: (diagramController hasSupportForModel: OPUMLProperty new)
]

{ #category : #tests }
OPUmlAttributeControllerTest >> testWriteMultiplicity [
	| prop |
	prop := OPUMLProperty new.
	controller writeMultiplicityFrom: '3..*' to: prop.
	self assert: prop lowerBound value equals: 3.
	self assert: prop upperBound value equals: '*'
]

{ #category : #tests }
OPUmlAttributeControllerTest >> testWriteMultiplicityMany [
	| prop pairs |
	prop := OPUMLProperty new.
	pairs := {'0..1' -> #(0 1).
	'4' -> #(4 4).
	'3..*' -> #(3 '*').
	'*' -> #(0 '*')}.
	pairs
		do: [ :pair | 
			controller writeMultiplicityFrom: pair key to: prop.
			self assert: prop lowerBound equals: pair value first.
			self assert: prop upperBound value equals: pair value second ]
]
