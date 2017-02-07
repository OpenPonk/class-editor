instance creation
fromArray: anArray
	"anArray can be either one element array #(1), #(*), #(7), or a two element array #(1 2) #(0 *)"

	anArray size = 1
		ifTrue: [ anArray first = '*'
				ifTrue: [ ^ self zeroToMany ]
				ifFalse: [ ^ self lower: anArray first asNumber upper: anArray first asNumber ] ].
	^ self new
		lower: anArray first asNumber;
		upper:
			(anArray second = '*'
				ifTrue: [ OPUnlimitedNatural max ]
				ifFalse: [ anArray second asNumber ]);
		yourself