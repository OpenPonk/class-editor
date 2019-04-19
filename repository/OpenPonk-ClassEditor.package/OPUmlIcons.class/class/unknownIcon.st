accessing - icons
unknownIcon
	"Private - Generated method"
	^ self icons
		at: #unknownIcon
		ifAbsentPut: [ Form
				fromBinaryStream: (self unknownIconContents base64Decoded readStream) ]