rendering
allShowableElementsInModel: aClassModel
	| queue |
	queue := OrderedCollection new.
	(self diagramController model isKindOf: OPUMLProfile)
		ifFalse: [ queue addAll: aClassModel ownedAttributes.
			queue addAll: aClassModel ownedOperations ].
	"queue addAll: each ownedComments."
	^ queue asArray select: [ :each | diagramController hasSupportForModel: each ]