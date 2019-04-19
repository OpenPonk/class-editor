accessing - icons
extensionIcon
	"Private - Generated method"
	^ self icons
		at: #extensionIcon
		ifAbsentPut: [ Form
				fromBinaryStream: (self extensionIconContents base64Decoded readStream) ]