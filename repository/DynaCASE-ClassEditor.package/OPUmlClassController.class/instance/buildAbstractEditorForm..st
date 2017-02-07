ui hooks
buildAbstractEditorForm: aForm
	(aForm addCheckbox: 'Is Abstract')
		state: self model isAbstract;
		whenChangedDo: [ :val | 
			self model isAbstract: val.
			self diagramController model isCormasModel
				ifTrue: [ self model isAbstract
						ifTrue: [ self removeAutomaticCormasAssociation ]
						ifFalse: [ self addAutomaticCormasAssociation ] ].
			self refreshFigure ]