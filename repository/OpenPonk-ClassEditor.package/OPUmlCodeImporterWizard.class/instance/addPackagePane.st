adding
addPackagePane
	"Here we initialize the first wizard panel, which is related to selecting the packages
	 that will be added to the model"

	| pane packageList packagePanel |
	pane := WizardSinglePane new.
	pane name: 'Select packages to import'.
	packageList := RPackage organizer packageNames asSortedCollection: [ :a :b | a < b ].
	packagePanel := MultiSelectionItemSelectorPart new
		initialList: packageList;
		yourself.
	pane addPart: packagePanel associatedTo: #packagesSelected.
	self addPane: pane