figures
refreshStereotype
	self model stereotypes isEmpty & stereotypeLabel isNotNil
		ifTrue: [ ^ self removeStereotype ].
	self model stereotypes isNotEmpty & stereotypeLabel isNil
		ifTrue: [ ^ self addStereotype ].
	self model stereotypes isEmpty & stereotypeLabel isNil
		ifTrue: [ ^ self ].
	stereotypeLabel text: '«' , ((self model stereotypes collect: #name) joinUsing: ',') , '»'.
	stereotypeLabel changed