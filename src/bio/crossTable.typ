#let splitString(item) = {
  let pairsInStr = int( item.len()/2 )
  let pairs = ()
  for i in range(0, pairsInStr) {
    let pair = item.slice(i*2, i*2+2)
    // return pair
    let gametes = ()
    gametes.push(pair.at(0))
    if pair.at(0) != pair.at(1) {
      gametes.push( pair.at(1) )
    }
    pairs.push(gametes)
  }
  return pairs
}
#let genCombies(gameteList) = {
  let combies = gameteList.remove(0)
  for gameteSet in gameteList {
    let newCombies = ()
    for gamete in gameteSet {
      for combie in combies {
        newCombies.push(combie+gamete)
      }
    }
    combies = newCombies
  }
  return combies
}

#let combineGametes(side, top) = {
  let minLen = calc.min(side.len(), top.len())
  let combie = ""
  for i in range(minLen) {
    let one = side.slice(i,i+1)
    let two = top.slice(i,i+1)
    combie = combie + (one, two).sorted().join()
  }
  return combie
}

#let applyColorScheme(cell, colorScheme) = {
  let style = (text:(:),cell:(:))
  let dispCell = cell
  for item in colorScheme.rev() {
    if cell.contains(item.match) {
      if "style" in item {
        style.insert(item.apply, style.at(item.apply) + item.style)
      }
      if "callback" in item {
        let callback = item.callback
        dispCell = callback(cell)
      }
    }
  }
  return table.cell( text(dispCell, ..style.text,), ..style.cell )
}


#let crossTable(itemTop, itemSide, colorScheme: ()) = {
  let itemTopArray = splitString(itemTop)
  let topCombinations = genCombies(itemTopArray)
  
  let itemSideArray = splitString(itemSide)
  let sideCombinations = genCombies(itemSideArray)
  let items

  let combieRows = ()
  for side in sideCombinations {
    let row = (side,)
    for top in topCombinations {
      let cell = combineGametes(side, top)
      row.push(applyColorScheme(cell, colorScheme))
    }
    combieRows.push(row)
  }
  
  table(
    columns: (auto,) * (topCombinations.len()+1),
    [],..topCombinations,
    ..combieRows.flatten()
  )
}