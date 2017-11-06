adding
addTo: aCollection attribute: anAttribute of: aStereotype
	anAttribute type name = #Boolean
		ifTrue: [ aCollection
				add:
					(MABooleanDescription new
						accessor: (self accessorFor: anAttribute of: aStereotype);
						label: 'Is ' , anAttribute name capitalized;
						yourself) ].
	anAttribute type name = #String
		ifTrue: [ aCollection
				add:
					(MAStringDescription new
						accessor: (self accessorFor: anAttribute of: aStereotype);
						label: anAttribute name capitalized;
						yourself) ]