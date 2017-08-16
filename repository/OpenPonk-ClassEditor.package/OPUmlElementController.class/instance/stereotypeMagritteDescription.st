accessing
stereotypeMagritteDescription
	| descriptions |
	descriptions := OrderedCollection new.
	self model appliedStereotypes
		do: [ :stereo | 
			stereo ownedAttributes
				do: [ :attr | 
					attr type name = #Boolean
						ifTrue: [ descriptions
								add:
									(MABooleanDescription new
										accessor:
											(MAPluggableAccessor
												read: [ :me | stereo tags at: attr name ifAbsent: [ attr defaultValue value ] ]
												write: [ :me :newValue | 
													stereo tags at: attr name put: newValue.
													me refreshFigure ]);
										label: attr name;
										yourself) ] ] ].
	^ descriptions