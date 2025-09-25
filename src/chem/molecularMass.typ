#import "@preview/fletcher:0.5.2": diagram, node, edge

#import "@preview/cetz-plot:0.1.0": plot, chart
#import "@preview/cetz:0.3.1": canvas, draw

#import "@preview/whalogen:0.2.0": ce
#import "@preview/alchemist:0.1.2": *

#set text(lang: "nl")

#let periodicTable = json("/data/periodicTable.json")

#let showMolecularMass(formula, value, decimals: 2, varSymbol: "M") = {
  value = calc.round(value, digits: decimals)
  $#varSymbol _#ce(formula) = #value $ 
}
#let valCount(count) = {
  count = if count == none {1} else { count }
  count = int(count)
  return count
}
#let valCharge(charge) = {
  charge = if charge == none {"0"} else { charge.replace("^","") }
  let prefix = if charge.last() == "-" {"-"} else {""}
  
  charge = charge.replace(regex("[+-]"),"")
  charge = if charge == "" {"1"} else {charge}

  charge = int(prefix + charge)
  return charge
}
#let getMass(sym, count, charge) = {
    count = valCount(count)
    charge = valCharge(charge)
    
    let index = periodicTable.symToIndex.at(sym)
    let element = periodicTable.elements.at(index)
    return count * element.atomic_mass
}
#let molecularMass(formula, decimals: 2, varSymbol: "M") = {
  let totalMass = 0
  let re = regex("([A-Z][a-z]*)(?:_?(\d+))?((?:\^\d+(?:-|\+?))|[+-])?")
  for match in formula.matches(re) {
    let (sym, count, charge) = match.captures
    let mass = getMass(sym, count, charge)    
    
    totalMass += mass
  }
  showMolecularMass(formula, totalMass, decimals: decimals, varSymbol: varSymbol)
}

// usage examples
#molecularMass("C") \
#molecularMass("H2O") \
#molecularMass("CO_2") \
#molecularMass("Fe2^3+ O3^2-") \