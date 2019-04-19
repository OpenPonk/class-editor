accessing - icons
literalIcon
	"Private - Generated method"
	^ self icons
		at: #literalIcon
		ifAbsentPut: [ Form
				fromBinaryStream: (self literalIconContents base64Decoded readStream) ]