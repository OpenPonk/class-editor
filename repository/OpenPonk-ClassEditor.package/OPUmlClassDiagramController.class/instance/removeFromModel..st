removing
removeFromModel: aModel
	"Remove aModel from the diagram.
	It is aModel's owner's controller responsibility to remove it.
	The assertion tests whether aModel is attached to the current controller chain.
	"

	| ctrl |
	ctrl := self controllerForModel: aModel.
	self assert: ctrl model = aModel.
	(self controllerForModel: (aModel perform: ctrl parentSelector)) removeModelElement: aModel