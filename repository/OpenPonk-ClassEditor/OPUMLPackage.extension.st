Extension { #name : #OPUMLPackage }

{ #category : #'*OpenPonk-ClassEditor' }
OPUMLPackage >> hasPackagedElement: anElement [

	^ self packagedElements anySatisfy: [ :any | 
		  any = anElement or: [ 
			  (any oclIsKindOf: #Package) and: [ 
				  any hasPackagedElement: anElement ] ] ]
]
