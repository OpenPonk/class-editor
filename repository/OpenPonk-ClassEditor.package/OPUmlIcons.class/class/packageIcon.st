accessing - icons
packageIcon
	"Private - Generated method"
	^ self icons
		at: #packageIcon
		ifAbsentPut: [ Form
				fromBinaryStream: (self packageIconContents base64Decoded readStream) ]