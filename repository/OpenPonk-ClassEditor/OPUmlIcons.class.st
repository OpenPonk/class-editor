"
I am an icon provider for the UML Class Diagram editor. I supply specific icons for UML elements such as classes, attributes, operations, generalizations, associations, and stereotypes.
"
Class {
	#name : 'OPUmlIcons',
	#superclass : 'OPIcons',
	#category : 'OpenPonk-ClassEditor-Plugin',
	#package : 'OpenPonk-ClassEditor',
	#tag : 'Plugin'
}

{ #category : 'accessing - icons' }
OPUmlIcons class >> attributeIcon [

	^ Form fromBinaryStream: self attributeIconContents base64Decoded asByteArray readStream
]

{ #category : 'private - contents' }
OPUmlIcons class >> attributeIconContents [
	"Private - Method generated with the content of the file File @ D:\OpenPonk\icons\uml\attribute.png"
	^ 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABHNCSVQICAgIfAhkiAAAAAlw
SFlzAAAG7AAABuwBHnU4NQAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoA
AADuSURBVDiN3ZCxSgNhEIS/Ta4RuzSSKjGNrdoLBkLIRfQi6Pv4BPouXnFozvy+gKBvcEUg
RawNSu4fmwTEy5lYCU417MwOOwv/G2Gqi96DLn/yWJlw7BRs5UwAZlXqj22br/JVygK2c46A
DMgWfCWCMsFDBMRfuPvVBQZn5rlFxMAAqbRuAeFQB2Gq8XIpTJX177W/cQWDSOLpxHHISPic
F4wB8LxRgIwIaHm/eJ5RARrA1Xdv4Qc9pyawF8yoJx2rJR2r8cGOoNW90+7aAOacG4ziU3tb
jpK+vSNcNSBaH2BMZVwXasGNxGvB/+f4BO9vTXGCt0WuAAAAAElFTkSuQmCC'
]

{ #category : 'accessing - icons' }
OPUmlIcons class >> classIcon [

	^ Form fromBinaryStream: self classIconContents base64Decoded asByteArray readStream
]

{ #category : 'private - contents' }
OPUmlIcons class >> classIconContents [
	"Private - Method generated with the content of the file File @ D:\OpenPonk\icons\uml\class.png"
	^ 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABHNCSVQICAgIfAhkiAAAAAlw
SFlzAAAG7AAABuwBHnU4NQAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoA
AABdSURBVDiN3ZExCoBQDENfiwf5Ryk46am8lYMI/2TGQXRwK18QfVuGJLSBtzGAYVW1jZox
yom5twBgXDRlm0+PZ413mgM6AImSPUOiXOLbP/hBwDGjE+kZnWgtf4YdGb0c7kGP8hkAAAAA
SUVORK5CYII='
]

{ #category : 'accessing - icons' }
OPUmlIcons class >> constraintIcon [

	^ Form fromBinaryStream: self constraintIconContents base64Decoded asByteArray readStream
]

{ #category : 'private - contents' }
OPUmlIcons class >> constraintIconContents [
	"Private - Method generated with the content of the file File @ D:\OpenPonk\icons\uml\constraint.png"
	^ 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABHNCSVQICAgIfAhkiAAAAAlw
SFlzAAAG7AAABuwBHnU4NQAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoA
AADUSURBVDiN1ZIxagJRGIS//2FuYCHbBnKAIITVdLrBJ2lSBSFXsLHMQSztcgNRYt6aRjyE
IX0auwhWO1ZWeZJlUwSnnH/+DwYGzl526tALSg1agm8H77OubWI5FzN9rrHBDEgd3MpY9YKe
Ytnaj+egR8QDRnPesU+AbKHkwnFdqpN/06sPei4VjlYwriTW1QHQcLD9C+DLjHp1gNgUkFYH
GBNg6HNdHq1soaQfdB8DRIfkc40RAyAH9kAGjOZdeykFAOgvdUNBu4BdrWA5vbOP3+r8jw7O
3TzgcNrvaAAAAABJRU5ErkJggg=='
]

{ #category : 'accessing - icons' }
OPUmlIcons class >> dataTypeIcon [

	^ Form fromBinaryStream: self dataTypeIconContents base64Decoded asByteArray readStream
]

{ #category : 'private - contents' }
OPUmlIcons class >> dataTypeIconContents [
	"Private - Method generated with the content of the file File @ D:\OpenPonk\icons\uml\dataType.png"
	^ 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABHNCSVQICAgIfAhkiAAAAAlw
SFlzAAAG7AAABuwBHnU4NQAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoA
AADbSURBVDiNxZIxTsNAEEXfX5OCI4CUm1BYeAXBUk4A3IMOaCiQ6LkAR4AN4ETpuQEdosgJ
gAKUnyoSWI4sQyR+ObP//Z3RwH9LAAdjTzVn2sXoQJ4K5QCUjz7rmrz0hK7GujbqVIstmdlc
3I6ingZjn8psf3v2kqIuGgEO7KRCce/e/Szjsqx8c1foHGBQeTKK2q3/oHGEh329SpwYjtpG
WLmDLPCG2fw14POLY4lJG+DHDjAfZeVrQw/x/B64WrYkZq2AFDVclZQKHTbV13MHDuRdr9GB
/K/h69EC9xhByVkP+hoAAAAASUVORK5CYII='
]

{ #category : 'accessing - icons' }
OPUmlIcons class >> directedAssociationIcon [

	^ Form fromBinaryStream: self directedAssociationIconContents base64Decoded asByteArray readStream
]

{ #category : 'private - contents' }
OPUmlIcons class >> directedAssociationIconContents [
	"Private - Method generated with the content of the file File @ D:\OpenPonk\icons\uml\directedAssociation.png"
	^ 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABHNCSVQICAgIfAhkiAAAAAlw
SFlzAAAG7AAABuwBHnU4NQAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoA
AADnSURBVDiNY2CgB/A+/F/Q+/B/QWxyLMQY8PcHw1QoMwpdjomQZq89/30YGBiuMTAwXPLY
+z+QJAMC9v8X+M/AYMnAwHCEgYHhBON/Bgv3Hf+FiDbg11+Gqn9/GHph/N//GdoYWRhKiDLA
a89/n/8MDMd2ejC+g4ntcWX8+P8/w1HPPf8D8BrgsP8/z38GBpvtLowb0OV2ujJuZWBgsHDY
/58HpwEHHBm/vBJgqMXlulcCDLUHHBm/4PXCWRPG38TIEYxGQmDgDYAnZY/d/x1wKWJkYjD4
/4/hAtku+P+P4QIHC3YDKAYABoVHXkJDbNUAAAAASUVORK5CYII='
]

{ #category : 'accessing - icons' }
OPUmlIcons class >> enumIcon [

	^ Form fromBinaryStream: self enumIconContents base64Decoded asByteArray readStream
]

{ #category : 'private - contents' }
OPUmlIcons class >> enumIconContents [
	"Private - Method generated with the content of the file File @ D:\OpenPonk\icons\uml\enum.png"
	^ 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABHNCSVQICAgIfAhkiAAAAAlw
SFlzAAAG7AAABuwBHnU4NQAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoA
AACmSURBVDiNxZIxDgFRFEXP/eY3FmAlFvCTicIkeuuwAovQW4BoTWEk04sNWIYGmfA0SIjC
i0nc/p57igv/jgCGG6t1pfYULZDKXAmAYm1T7/KjE7zF92Qv1MomBj0AGdvVQEsXwGAUYQzQ
NBzdBhjxDH2AmLEHDj4DIYkuwMWIbgPBqcy1+Kb4EYDoFJXN7za7MtfMBXgew5F2fmCB5H2j
BdKv4+3kBmsPLbxzYn3TAAAAAElFTkSuQmCC'
]

{ #category : 'accessing - icons' }
OPUmlIcons class >> extensionIcon [

	^ Form fromBinaryStream: self extensionIconContents base64Decoded asByteArray readStream
]

{ #category : 'private - contents' }
OPUmlIcons class >> extensionIconContents [
	"Private - Method generated with the content of the file File @ D:\OpenPonk\icons\uml\extension.png"
	^ 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABHNCSVQICAgIfAhkiAAAAAlw
SFlzAAAG7AAABuwBHnU4NQAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoA
AADRSURBVDiNxZExbsJQEETffvtHQrkJDUphRUoTURnTcBVuwJHSkAojYQqqUOQ6gHZoEImM
LRuKZKqvHentzF/4CxVbDYuthk1e2otwYH95DepW6NxeaoeRSCTTUl93AWaV3oAMEc2IDqN8
qXFvwPHEml81DdIw4LMXoCi1EyT1uZy0WP9UaQRMNspMvCJi3TMjIl4mG2XQcoXE8SMsDA4A
QYwA3PgGkHiKjrelv1G+0jxfad7kdZ6xS/8PuH5iW0eAEHh3p3o4gTvVc+Dj/nw9dAZN7EIy
hsjryAAAAABJRU5ErkJggg=='
]

{ #category : 'accessing - icons' }
OPUmlIcons class >> generalizationIcon [

	^ Form fromBinaryStream: self generalizationIconContents base64Decoded asByteArray readStream
]

{ #category : 'private - contents' }
OPUmlIcons class >> generalizationIconContents [
	"Private - Method generated with the content of the file File @ D:\OpenPonk\icons\uml\generalization.png"
	^ 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABHNCSVQICAgIfAhkiAAAAAlw
SFlzAAAG7AAABuwBHnU4NQAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoA
AADvSURBVDiNxZK9TgJBFIW/u7shPAEViQUvYGsHiYEdSxJbewt6WzrfwAews7NxE1ik2sSS
F6CCd/AnOMfG3RCd1Y0meqqZe2a+e+5k4C80LNQZFuqEvKQJIH7k9n159NGz7y67XFMTLQ/P
ZrSzY7to0hSA8UIHaa6igi304O7U2z8TfQV4ght74azcv+44VYvrRgCXa4rnPjuxdVmbjWyD
mLlcl2Ut+AZuqS47lt44D/mRuCJhkA1sG0wQe+SNyV6XnkE1uzcmsUd16T8pnaufztUPpmlM
qdH/A6qvXDcjgEUcyrP6cQJ5Vu0kDPi13gDJkkfqaimOAQAAAABJRU5ErkJggg=='
]

{ #category : 'accessing - icons' }
OPUmlIcons class >> literalIcon [

	^ Form fromBinaryStream: self literalIconContents base64Decoded asByteArray readStream
]

{ #category : 'private - contents' }
OPUmlIcons class >> literalIconContents [
	"Private - Method generated with the content of the file File @ D:\OpenPonk\icons\uml\literal.png"
	^ 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABHNCSVQICAgIfAhkiAAAAAlw
SFlzAAAG7AAABuwBHnU4NQAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoA
AABZSURBVDiNY2AYnsBz9/84933/9YlRy4RDNI7xH4MB+QaQAEYNGAwGMGIT9Nz7f8///wyc
TAwM9+AKGRmmb3VmPIaulgWrsf8YFjExMCghC/1lYPhCoWNpBADt2xHuYm6+EwAAAABJRU5E
rkJggg=='
]

{ #category : 'accessing - icons' }
OPUmlIcons class >> operationIcon [

	^ Form fromBinaryStream: self operationIconContents base64Decoded asByteArray readStream
]

{ #category : 'private - contents' }
OPUmlIcons class >> operationIconContents [
	"Private - Method generated with the content of the file File @ D:\OpenPonk\icons\uml\operation.png"
	^ 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABHNCSVQICAgIfAhkiAAAAAlw
SFlzAAAG7AAABuwBHnU4NQAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoA
AAD1SURBVDiN1ZIxTsNAEEXfeHwEBEpJEQRHIEiRSIi9qaih9QVyFC5ACzVVNsYpLYr0CFJR
ghA3iDMUKI29Ie4Qv3z79+lrtfDvI9sOkpkda4wDqFb4PJWXUC8KQVdYpsoCo4/RV2XhCsta
LUhmdqjKM8LldCg5wHhuCcaDKSf+XN5+XaAx1wjl5jLAdCg5QhlVXNX7cWOTcQSUTcwTRrfO
Q29wYPAVEH+a0Gkj+BDYq0Mx9iN43y0Qlgi9AD8FljsF1Yo7jDP3aOmGjeeWAL21ct/0BuIK
ywRugAIwYGQw8Rdy20oAPz8xVlKAdYT3A3nd1v3bfAO26kn9hYnb5AAAAABJRU5ErkJggg=='
]

{ #category : 'accessing - icons' }
OPUmlIcons class >> packageIcon [

	^ Form fromBinaryStream: self packageIconContents base64Decoded asByteArray readStream
]

{ #category : 'private - contents' }
OPUmlIcons class >> packageIconContents [
	"Private - Method generated with the content of the file File @ D:\OpenPonk\icons\uml\package.png"
	^ 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABHNCSVQICAgIfAhkiAAAAAlw
SFlzAAAG7AAABuwBHnU4NQAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoA
AABkSURBVDiNY2AYaMDIwMDA4Ln3/wHGfwwHcCn6z8TgsN2Z0QGnKV67/zfgswWfPBMBFxIE
EC/s+f+A4T/DAwIKDyDzUbxFyAvYAEwPxV4YNYAKBrAwMEDilNSo/M/E4ECp5dQBALRhHivV
PnSaAAAAAElFTkSuQmCC'
]

{ #category : 'accessing - icons' }
OPUmlIcons class >> profileIcon [

	^ Form fromBinaryStream: self profileIconContents base64Decoded asByteArray readStream
]

{ #category : 'private - contents' }
OPUmlIcons class >> profileIconContents [
	"Private - Method generated with the content of the file File @ D:\OpenPonk\icons\uml\profile.png"
	^ 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABHNCSVQICAgIfAhkiAAAAAlw
SFlzAAAG7AAABuwBHnU4NQAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoA
AAERSURBVDiNxZFNTsJQFIW/d0shdQEuAjbRBKSpc0aOS1yGmyAhsAQXUEGI3QSMGTs0xob+
vOtAjYVQGgbGM3vvnnve/e6D/5YBCNeaGEtSZ1LBj/vGr025fdaHc6+cq0vDhI36QljpDmXX
YEyq5wOsJoRT+ulpHReGC72+apPZkk6ekQK4bTxx2H9ktJeBea36D3YQrrTrCPN9Ti9XZqmH
TT1srsz2OT1HmIcr7VZ7jid4pEVAydIW9JMb8w4QPOm9tFjjMKRkAfTqAkYUTFAicZj6L3oH
IAVTLBHKBMOoFiEemG1piTouG9cw9lLESxHXMO64bEpLFA/M9hwCx0v61tuJu98AFfxLv1IF
/xL/3+kTGRtla/geVQcAAAAASUVORK5CYII='
]

{ #category : 'accessing - icons' }
OPUmlIcons class >> stereotypeIcon [

	^ Form fromBinaryStream: self stereotypeIconContents base64Decoded asByteArray readStream
]

{ #category : 'private - contents' }
OPUmlIcons class >> stereotypeIconContents [
	"Private - Method generated with the content of the file File @ D:\OpenPonk\icons\uml\stereotype.png"
	^ 'iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABHNCSVQICAgIfAhkiAAAAAlw
SFlzAAAG7AAABuwBHnU4NQAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoA
AADBSURBVDiN3ZGxDgFhEIS/3VxzqFQe54RwJ6KjUXgNlfAoCo1ScycIlWdRqQ6JyL8qImgu
JBLTbTHf7GTg1xKAaGUbcWyyGE0J4ooEADQWNsyafPNoVuOzPgZ4j0d7a356ZOidGF18BnFV
+o2lNU04i8N3RprUZPX2g3pixfTIRGB98Zk4YQqQ3xPjiJxQUqUVLq331Qp3wDyUfSFH16Ds
neiq0QE4FIlQYjV2zjFLqjJ+ofzBjKYEWWuYEnwa/h1dATYvRy5RNn8sAAAAAElFTkSuQmCC'
]
