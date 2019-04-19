accessing - icons
objectIcon
	"Private - Generated method"
	^ self icons
		at: #objectIcon
		ifAbsentPut: [ Form
				fromBinaryStream: (self objectIconContents base64Decoded readStream) ]