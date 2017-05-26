rendering
allShowableElementsInModel: each
	| queue |
	queue := OrderedCollection new.
	queue addAll: each ownedAttributes.
	queue addAll: each ownedOperations.
	"queue addAll: each ownedComments."
	^ queue asArray select: [ :eeach | diagramController hasSupportForModel: eeach ]