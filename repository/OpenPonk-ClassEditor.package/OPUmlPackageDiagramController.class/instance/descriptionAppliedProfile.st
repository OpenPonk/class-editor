forms
descriptionAppliedProfile
	<magritteDescription>
	| profiles options |
	profiles := OPUmlCustomProfile allSubclasses collect: #profile.
	options := self isAppliedProfileInUse
		ifTrue: [ | current |
			current := model profileApplications first appliedProfile.
			{current -> current name} ]
		ifFalse: [ {nil -> ''} , profiles collect: [ :each | each -> each name ] ].
	^ MASingleOptionDescription new
		optionsAndLabels: options;
		reference: MAStringDescription new;
		accessor:
			(MAPluggableAccessor
				read: [ :me | 
					(me model profileApplications collect: #appliedProfile)
						ifEmpty: [ nil ]
						ifNotEmpty: #first ]
				write: [ :me :newValue | 
					newValue
						ifNil: [ [ me model profileApplications isNotEmpty ]
								whileTrue: [ me model profileApplications remove: me model profileApplications first ] ]
						ifNotNil: [ me model profileApplications
								ifEmpty: [ me model profileApplications
										add: (OPUMLProfileApplication new uuid: me model uuid , '-_profileApplication.0') ].
							me model profileApplications first appliedProfile: newValue ].
					self refreshFigure ]);
		label: 'Applied Profile';
		priority: 10;
		beSorted;
		yourself