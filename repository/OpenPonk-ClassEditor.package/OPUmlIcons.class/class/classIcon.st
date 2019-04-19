accessing - icons
classIcon
	"Private - Generated method"
	^ self icons
		at: #classIcon
		ifAbsentPut: [ Form
				fromBinaryStream: (self classIconContents base64Decoded readStream) ]