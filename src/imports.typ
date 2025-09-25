#let tools = (
  math: (:),
  chem: (:),
  bio: (:),
  style: (:),
)

#import "math/vector.typ"
#tools.math.insert("vector", vector)
#import "chem/boeTable.typ": boeTable
#tools.chem.insert("boeTable", boeTable)
#import "chem/molecularMass.typ": molecularMass
#tools.chem.insert("molecularMass", molecularMass)
#import "bio/crossTable.typ": crossTable
#tools.bio.insert("crossTable", crossTable)
#import "style/colorScheme.typ": colorScheme
#tools.style.insert("colorScheme", colorScheme)