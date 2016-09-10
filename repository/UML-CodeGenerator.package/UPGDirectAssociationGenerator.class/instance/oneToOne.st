templates
oneToOne
	^ '{name}: {param}
	|oldRef|
	{name} = {param} ifTrue: [ ^ self ].
	oldRef := {name}.
	{name} := {param}.
	"oldRef ifNotNil: [ oldRef {otherName}: nil ]."
	oldRef ifNotNil: [ oldRef forgetAttribute: #{otherName} ].
	{name} ifNotNil: [ {name} {otherName}: self ]'