accessing - icons
attributeIcon
	"Private - Generated method"
	^ self icons
		at: #attributeIcon
		ifAbsentPut: [ Form
				fromBinaryStream: (self attributeIconContents base64Decoded readStream) ]