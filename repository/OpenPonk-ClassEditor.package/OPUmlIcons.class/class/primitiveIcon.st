accessing - icons
primitiveIcon
	"Private - Generated method"
	^ self icons
		at: #primitiveIcon
		ifAbsentPut: [ Form
				fromBinaryStream: (self primitiveIconContents base64Decoded readStream) ]