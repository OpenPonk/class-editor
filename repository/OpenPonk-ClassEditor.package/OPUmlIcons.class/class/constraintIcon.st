accessing - icons
constraintIcon
	"Private - Generated method"
	^ self icons
		at: #constraintIcon
		ifAbsentPut: [ Form
				fromBinaryStream: (self constraintIconContents base64Decoded readStream) ]