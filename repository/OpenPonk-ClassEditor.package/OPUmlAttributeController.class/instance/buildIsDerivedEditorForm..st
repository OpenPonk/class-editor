forms
buildIsDerivedEditorForm: aForm
	(aForm addCheckbox: 'Is Derived')
		state: self model isDerived;
		whenChangedDo: [ :val | 
			self model isDerived: val.
			self refreshFigure ]