removing
removeModel
	| ctrls |
	"extra work to trigger update of the end classes... maybe this should be automatic for edges"
	ctrls := self model memberEnds asArray
		collect: [ :each | diagramController controllerForModel: each type ].
	super removeModel.
	ctrls do: #refreshFigure