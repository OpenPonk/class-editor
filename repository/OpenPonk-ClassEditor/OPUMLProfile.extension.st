Extension { #name : #OPUMLProfile }

{ #category : #'*OpenPonk-ClassEditor' }
OPUMLProfile >> hasPackagedElement: anElement [

	^ self packagedElements anySatisfy: [ :any | 
		  any = anElement or: [ 
			  (any oclIsKindOf: #Package) and: [ 
				  any hasPackagedElement: anElement ] ] ]
]
