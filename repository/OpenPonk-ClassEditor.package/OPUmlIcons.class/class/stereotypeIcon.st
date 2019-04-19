accessing - icons
stereotypeIcon
	"Private - Generated method"
	^ self icons
		at: #stereotypeIcon
		ifAbsentPut: [ Form
				fromBinaryStream: (self stereotypeIconContents base64Decoded readStream) ]