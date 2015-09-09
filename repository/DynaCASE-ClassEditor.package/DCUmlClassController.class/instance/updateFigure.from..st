figures
updateFigure: aFigure from: aModel
	| attrs methods |
	aFigure name: aModel name.
	attrs := aModel attributes collect: [ :each | each name , ' : ' , each declaredType name ].
	aFigure attributes: attrs.
	methods := aModel methods
		collect:
			[ :each | 
			each name , '('
				,
					((each parameters collect: [ :p | p name , ' : ' , p declaredType name ]) joinUsing: ', ')
				, ')' ].
	aFigure methods: methods