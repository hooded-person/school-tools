#let boeTable(items) = {
  let el = ( [], )
  let B = ( [B(egin)], )
  let O = ( [O(mzetting)], )
  let E = ( [E(ind)], )
  for item in items {
    el.push( [#item.at(0)] )
    B.push(  [#item.at(1)] )
    O.push(  [#item.at(2)] )
    E.push(  [#item.at(3)] )
  }
  
  table(columns:1+items.len(),
    ..el,
    ..B,
    ..O,
    ..E,
  )
}

#boeTable((
  ("Fe+",0,1,1),
  ("O2",0,"+2x","2x"),
))