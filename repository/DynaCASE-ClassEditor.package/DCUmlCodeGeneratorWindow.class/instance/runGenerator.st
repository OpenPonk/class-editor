actions
runGenerator
	| generator |
	generator := DCUmlToCodeGenerator new.
	generator category: self categoryInput text.
	self accessorsCheckbox state
		ifTrue: [ generator withAccessors ].
	generator withProgressBar.
	generator generateFromModel: model