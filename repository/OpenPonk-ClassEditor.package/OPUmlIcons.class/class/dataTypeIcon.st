accessing - icons
dataTypeIcon
	"Private - Generated method"
	^ self icons
		at: #dataTypeIcon
		ifAbsentPut: [ Form
				fromBinaryStream: (self dataTypeIconContents base64Decoded readStream) ]