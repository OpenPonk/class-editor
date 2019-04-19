accessing - icons
generalizationIcon
	"Private - Generated method"
	^ self icons
		at: #generalizationIcon
		ifAbsentPut: [ Form
				fromBinaryStream: (self generalizationIconContents base64Decoded readStream) ]