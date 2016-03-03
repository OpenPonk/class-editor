ui hooks
buildEditorForm: aForm
	self buildStereotypeEditorForm: aForm.
	self buildNameEditorForm: aForm.
	self buildAbstractEditorForm: aForm.
	(aForm addDroplist: 'Color')
		items: Color knownColors;
		displayBlock: [ :each | each asString ];
		iconHolder: [ :each | Morph new color: (Color perform: each) ];
		setSelectedItem: self diagramElement localStyle fillColor name;
		whenSelectedItemChanged:
				[ :newValue | 
			self diagramElement localStyle fillColor: (Color perform: newValue).
			self refreshFigure ]