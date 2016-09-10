transforming
copyClassesFrom: sourceModel to: targetModel
	sourceModel allClasses
		do: [ :cls | 
			| copy |
			copy := self classFor: cls.
			typesLookup at: cls put: copy.
			targetModel add: copy ].
	sourceModel allInheritanceDefinitions
		do: [ :each | 
			targetModel
				add:
					(FAMIXInheritance
						subclass: (typesLookup at: each subclass)
						superclass: (typesLookup at: each superclass)) ]