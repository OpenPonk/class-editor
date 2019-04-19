accessing - icons
profileIcon
	"Private - Generated method"
	^ self icons
		at: #profileIcon
		ifAbsentPut: [ Form
				fromBinaryStream: (self profileIconContents base64Decoded readStream) ]