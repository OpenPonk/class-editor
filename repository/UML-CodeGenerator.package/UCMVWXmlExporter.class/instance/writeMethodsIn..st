as yet unclassified
writeMethodsIn: aModel
	(self sortedHierarchyFor: aModel allClasses)
		do: [ :cls | 
			((cls methods reject: #isStatic) groupedBy: #protocol)
				valuesDo: [ :group | 
					group
						ifNotEmpty: [ writer
								tag: 'methods'
								with: [ writer
										tag: 'class-id' with: environment , '.' , cls name;
										tag: 'category' with: group anyOne protocol.
									group
										do: [ :method | 
											writer
												tag: 'body'
												attributes: (Dictionary with: #package -> packageName with: 'selector' -> method name)
												with: method sourceText ] ] ] ].
			((cls methods select: #isStatic) groupedBy: #protocol)
				valuesDo: [ :group | 
					group
						ifNotEmpty: [ writer
								tag: 'methods'
								with: [ writer
										tag: 'class-id' with: environment , '.' , cls name , ' class';
										tag: 'category' with: group anyOne protocol.
									group
										do: [ :method | 
											writer
												tag: 'body'
												attributes: (Dictionary with: #package -> packageName with: 'selector' -> method name)
												with: method sourceText ] ] ] ] ]