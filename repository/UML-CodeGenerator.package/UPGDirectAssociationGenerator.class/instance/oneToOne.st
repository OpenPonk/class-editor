templates
oneToOne
	^ '{name}: {param}
	|oldRef|
	{name} = {param} ifTrue: [ ^ self ].
	oldRef := {name}.
	{name} := {param}.
	oldRef ifNotNil: [ oldRef {otherName}: nil ].
	{name} ifNotNil: [ {name} {otherName}: self ]'