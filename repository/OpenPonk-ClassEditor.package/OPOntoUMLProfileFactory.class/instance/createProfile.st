as yet unclassified
createProfile
	| profile classMetaclass sortals mixins associationMetaclass associations moments |
	profile := OPUMLProfile new name: 'OntoUML [WIP]'.
	classMetaclass := OPUMLClass new name: 'Class'.
	sortals := #(Kind Quantity Collective SubKind Phase Role).
	mixins := #(RoleMixin Mixin Category).
	moments := #(Relator Mode Quality).
	(sortals , mixins , moments) sorted
		do:
			[ :each | profile packagedElements addAll: (self newStereotype: each to: classMetaclass) ].
	associationMetaclass := OPUMLClass new name: 'Association'.
	associations := {#related -> #(Formal Material).
	#dependency -> #(Characterization Mediation Derivation).
	#meronymic -> #(subQuantityOf subCollectionOf memberOf componentOf)} asOrderedDictionary.
	associations values
		do: [ :arr | 
			arr sorted
				do:
					[ :each | profile packagedElements addAll: (self newStereotype: each to: associationMetaclass) ] ].
	(associations at: #meronymic)
		do: [ :each | 
			| cls |
			cls := profile packagedElements detect: [ :e | e name = each ].
			OPUMLProperty new
				name: 'essential';
				owningClass: cls;
				type: (OPUMLPrimitiveType new name: 'Boolean');
				defaultValue: (OPUMLLiteralBoolean new value: false).
			OPUMLProperty new
				name: 'inseparable';
				owningClass: cls;
				type: (OPUMLPrimitiveType new name: 'Boolean');
				defaultValue: (OPUMLLiteralBoolean new value: false) ].
	^ profile