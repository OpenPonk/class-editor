ui hooks
buildIsClassSideEditorForm: aForm
	(aForm addCheckbox: 'Is Class-side')
		state: self model isStatic;
		whenChangedDo: [ :val | 
			self model isStatic: val.
			self refreshFigure ]