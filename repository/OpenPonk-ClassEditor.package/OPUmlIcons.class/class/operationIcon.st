accessing - icons
operationIcon
	"Private - Generated method"
	^ self icons
		at: #operationIcon
		ifAbsentPut: [ Form
				fromBinaryStream: (self operationIconContents base64Decoded readStream) ]