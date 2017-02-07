adding
addConfigPane
	| pane |
	pane := WizardSinglePane new.
	pane name: 'Export model to a *.xml.st file'.
	pane
		addPart:
			(SaveChooseFilePart new
				validExtensions: #('xml.st' 'st');
				yourself)
		associatedTo: #targetFile.
	self addPane: pane