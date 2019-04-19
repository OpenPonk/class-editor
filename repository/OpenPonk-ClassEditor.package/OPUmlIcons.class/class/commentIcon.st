accessing - icons
commentIcon
	"Private - Generated method"
	^ self icons
		at: #commentIcon
		ifAbsentPut: [ Form
				fromBinaryStream: (self commentIconContents base64Decoded readStream) ]