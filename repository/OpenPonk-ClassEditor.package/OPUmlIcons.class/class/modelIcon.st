accessing - icons
modelIcon
	"Private - Generated method"
	^ self icons
		at: #modelIcon
		ifAbsentPut: [ Form
				fromBinaryStream: (self modelIconContents base64Decoded readStream) ]