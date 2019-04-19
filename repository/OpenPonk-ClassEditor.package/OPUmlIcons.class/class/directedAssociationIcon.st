accessing - icons
directedAssociationIcon
	"Private - Generated method"
	^ self icons
		at: #directedAssociationIcon
		ifAbsentPut: [ Form
				fromBinaryStream: (self directedAssociationIconContents base64Decoded readStream) ]