accessing - icons
enumIcon
	"Private - Generated method"
	^ self icons
		at: #enumIcon
		ifAbsentPut: [ Form
				fromBinaryStream: (self enumIconContents base64Decoded readStream) ]