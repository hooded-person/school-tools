#let math = (:)
#let chem = (:)
#let bio = (:)
#let style = (:)

#import "math/vector.typ"
#math.insert("vector", vector)
#import "chem/boeTable.typ": boeTable
#chem.insert("boeTable", boeTable)
#import "chem/molecularMass.typ": molecularMass
#chem.insert("molecularMass", molecularMass)
#import "bio/crossTable.typ": crossTable
#bio.insert("crossTable", crossTable)
#import "style/colorScheme.typ": colorScheme
#style.insert("colorScheme", colorScheme)