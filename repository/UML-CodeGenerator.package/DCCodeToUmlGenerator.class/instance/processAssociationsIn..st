as yet unclassified
processAssociationsIn: aClass
	(aClass smalltalkClass methods flatCollect: #pragmas)
		select: [ :each | each keyword = #DCAssociation: ]
		thenDo: [ :pragma | 
			| assoc name |
			assoc := OPUmlDSLFactory new association: pragma arguments first , ';'.
			(aClass mooseModel allBinaryAssociations
				anySatisfy: [ :each | 
					each sourceEnd name = assoc sourceEnd name & (each targetEnd name = assoc targetEnd name)
						& (each source name = assoc source name) & (each target name = assoc target name) ])
				ifFalse: [ assoc
						source: (aClass mooseModel allModelClasses detect: [ :each | each name = assoc source name ]).
					assoc
						target: (aClass mooseModel allModelClasses detect: [ :each | each name = assoc target name ]).
					aClass mooseModel add: assoc ].
			name := pragma method selector.
			aClass attributes
				detect: [ :each | each name = name ]
				ifFound: [ :each | 
					each removeFromModel.
					aClass attributes remove: each ].
			(Array
				with: name
				with: name , ':'
				with: 'add' , name asEnglishSingular capitalized , ':'
				with: 'remove' , name asEnglishSingular capitalized , ':')
				do: [ :each | 
					aClass methods
						detect: [ :method | method name = each ]
						ifFound: [ :method | 
							method removeFromModel.
							aClass methods remove: method ] ] ]