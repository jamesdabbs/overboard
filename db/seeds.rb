Campus.create([
  { name: "Atlanta", aliases: ["ATL"] },
  { name: "Austin", },
  { name: "Charleston", aliases: ["CHS"] },
  { name: "Columbia" },
  { name: "Greenville", aliases: ["GVL", "GLV"] }, # lol
  { name: "Houston", aliases: ["HOU", "HTX"] },
  { name: "Indianapolis" },
  { name: "Las Vegas" },
  { name: "Little Rock" },
  { name: "Nashville" },
  { name: "Orlando", aliases: ["ORL"] },
  { name: "Raleigh-Durham", aliases: ["Durham"] },
  { name: "Tampa-St. Petersburg", aliases: ["Tampa", "St. Pete"] },
  { name: "Washington, D.C.", aliases: ["Washington", "DC"] }
])

Topic.create([
  { title: "Front End Engineering", aliases: ["JS", "Javascript", "FE", "FEE"] },
  { title: "Mobile Engineering", aliases: ["iOS"] },
  { title: ".NET Engineering" },
  { title: "Python Engineering", aliases: ["py"] },
  { title: "Rails Engineering", aliases: ["ROR", "rb", "ruby", "rubies"] },
  { title: "User Interface Design", aliases: ["design"] }
])

Teamwork.sync.employees!
Teamwork.sync.journals!
