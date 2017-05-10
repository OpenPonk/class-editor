forms
buildEditorForm: aForm
"	self buildStereotypeEditorForm: aForm."
	self buildNameEditorForm: aForm.
	self buildAbstractEditorForm: aForm.
"	(aForm addDroplist: 'Color')
		items: self supportedColors;
		displayBlock: [ :each | each asString ];
		iconHolder: [ :each | Morph new color: (Color perform: each) ];
		setSelectedItem: self diagramElement sharedStyle fillColor name;
		whenSelectedItemChanged: [ :newValue | 
			self diagramElement sharedStyle
				fillColor: (Color perform: newValue);
				strokeColor: (Color perform: newValue) muchDarker.
			self refreshFigure ]"