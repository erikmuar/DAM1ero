1.

Characters --> 87 --> Comando para verificar: db.getCollection("Characters").countDocuments({})
Planets --> 61 --> Comando para verificar: db.getCollection("Planets").countDocuments({})
Species --> 37 --> Comando para verificar: db.getCollection("Species ").countDocuments({})
Starships --> 37  --> Comando para verificar: db.getCollection("Starships ").countDocuments({})
Vehicles --> 39 --> Comando para verificar: db.getCollection("Vehicles ").countDocuments({})


2. 

db.getCollection("Characters").insertOne({
    "name": "Cassian Andor",
    "height": NumberInt(180),
    "mass": NumberInt(75),
    "hair_color": "brown",
    "skin_color": "light",
    "eye_color": "brown",
    "birth_year": "26BBY",
    "gender": "male",
    "homeworld": "Fest",
    "species": "Human"
});



db.getCollection("Planets").insertOne({
    "name": "Fest",
    "rotation_period": NumberInt(26),
    "orbital_period": NumberInt(380),
    "diameter": NumberInt(11200),
    "climate": "cold",
    "gravity": "1 standard",
    "terrain": "tundra, forests",
    "surface_water": NumberInt(30),
    "population": NumberInt(450000000)
});


db.getCollection("Species").insertOne({
    "name": "Shistavanen",
    "classification": "mammal",
    "designation": "sentient",
    "average_height": NumberInt(190),
    "skin_colors": "gray, black",
    "hair_colors": "gray, black, brown",
    "eye_colors": "yellow, red",
    "average_lifespan": NumberInt(120),
    "language": "Shistavanen",
    "homeworld": "Uvena Prime"
});





db.getCollection("Starships").insertOne({
    "name": "TIE Reaper",
    "model": "Sienar Fleet Systems TIE Reaper",
    "manufacturer": "Sienar Fleet Systems",
    "cost_in_credits": NumberInt(250000),
    "length": NumberInt(19),
    "max_atmosphering_speed": "1200",
    "crew": NumberInt(4),
    "passengers": NumberInt(20),
    "cargo_capacity": NumberInt(5000),
    "consumables": "2 days",
    "hyperdrive_rating": NumberInt(1),
    "MGLT": NumberInt(90),
    "starship_class": "Troop transport"
});


db.getCollection("Vehicles").insertOne({
    "name": "Flash Speeder",
    "model": "Flash",
    "manufacturer": "CZERKA Corporation",
    "cost_in_credits": NumberInt(12000),
    "length": 3.5,
    "max_atmosphering_speed": NumberInt(300),
    "crew": NumberInt(1),
    "passengers": NumberInt(1),
    "cargo_capacity": NumberInt(50),
    "consumables": "1 day",
    "vehicle_class": "repulsorlift land speeder"
});



3.a 

db.getCollection("Vehicles").updateMany(
  { name: { $regex: /^AT/ } },
  { $inc: { max_atmosphering_speed: 5 } }
);


3.b 

const sandCrawler = db.getCollection("Vehicles").findOne({ name: "Sand Crawler" });
const cargoCapacity = sandCrawler.cargo_capacity;

db.getCollection("Vehicles").updateOne(
  { name: "Geonosian starfighter" },
  { $set: { cargo_capacity: cargoCapacity } }
);


3.c 

db.getCollection("Species").updateMany(
  { average_height: { $gte: 190 } },
  { $set: { size: "top_size" } }
);


3.d 

const cursor = db.getCollection("Species").find();

cursor.forEach(doc => {
  let updateNeeded = false;
  const updateFields = {};

  for (const [key, value] of Object.entries(doc)) {
    if (value === "NA") {
      updateNeeded = true;
      updateFields[key] = "unknown";
    }
  }

  if (updateNeeded) {
    db.getCollection("Species").updateOne(
      { _id: doc._id },
      { $set: updateFields }
    );
  }
});



3.e 

db.getCollection("Planets").updateOne(
  { name: "Dagobah" },
  { $set: { gravity: "1.2 standard" } }
);



4.a 

db.getCollection("Planets").deleteOne({ name: "Alderaan" });


4.b 

db.getCollection("Starships").deleteOne({ name: "Death Star" });



4.c 

db.getCollection("Characters").deleteMany({
  gender: "female",
  species: "Human",
  homeworld: "Tatooine"
});


4.d 



5.a 

db.getCollection("Planets").find(
  { terrain: /mountains/i },
  { name: 1, climate: 1, _id: 0 }
);

5.b 

db.getCollection("Species").find().sort({ name: 1 });


5.c 

db.getCollection("Species").find().sort({
  classification: 1,
  average_lifespan: -1
});



5.d 

db.getCollection("Starships")
  .find(
    { cargo_capacity: { $type: "int" } }
  )
  .sort({ cargo_capacity: -1 })
  .limit(3);


  5.e  

db.getCollection("Planets").aggregate([
  {
    $match: {
      population: { $type: [ "int", "long", "double" ] } // Asegura que el campo sea numérico
    }
  },
  {
    $group: {
      _id: null,
      totalPopulation: { $sum: "$population" }
    }
  }
]);

5.f 

db.getCollection("Vehicles").find(
  {
    cost_in_credits: { $gte: 5000, $lte: 60000 },
    vehicle_class: { $nin: ["airspeeder", "speeder"] }
  }
);

5.g 

db.getCollection("Vehicles").countDocuments({ vehicle_class: "starfighter" });

respuesta 4 

5.h 

db.getCollection("Starships").countDocuments({ starship_class: "starfighter" });


5.i  

db.getCollection("Characters").find({
  $or: [
    { gender: "male", homeworld: "Naboo" },
    { gender: "female", homeworld: "Coruscant" }
  ]
});


5.j 

db.getCollection("Species").find({ size: { $exists: true } });