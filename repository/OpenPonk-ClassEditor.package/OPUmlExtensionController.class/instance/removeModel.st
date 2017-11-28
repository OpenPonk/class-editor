removing
removeModel
	| ctrls owner |
	owner := self diagramController model.
	"extra work to trigger update of the end classes... maybe this should be automatic for edges"
	ctrls := self model memberEnds asArray
		collect: [ :each | diagramController controllerForModel: each type ].
	self remove.
	owner packagedElements remove: self model.
	[ self model memberEnds isNotEmpty ]
		whileTrue: [ | end |
			end := self model memberEnds first.
			end association: nil.
			end owningClass: nil.
			end owningAssociation: nil ].
	ctrls do: #refreshFigure