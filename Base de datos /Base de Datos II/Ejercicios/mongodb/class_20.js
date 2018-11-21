db.films.find().forEach(function(x) { 
     x['Rental Duration'] =parseFloat(x['Rental Duration']);
      x['Replacement Cost'] =parseFloat(x['Replacement Cost']);
       x['Length'] =parseFloat(x['Length']);
       db.films.save(x);
});






// Show title and special_features of films that are PG-13
db.films.find({'Rating':'PG-13'},
{Title:1, 'Special Features':1});

// Get a list of all the different films duration.
db.films.distinct("Length");

// Show title, category and rating of films that have 'Behind the Scenes'   as special_features 
db.films.find({'Replacement Cost':{$gte:20.00, $lte:24.00 }},
{Title:1, 'Rental Duration':1,'Replacement Cost':1})

// Show title, category and rating of films that have 'Behind the Scenes'   as special_features 

db.films.find({'Special Features':'Behind the Scenes'},{'Title':1,'Special Features':1});

// Show first name and last name of actors that acted in 'ZOOLANDER FICTION'
db.films.find({'Title':'ZOOLANDER FICTION'},{'Actors.First name':1,'Actors.Last name':1});
// Show the address, city and country of the store with id 1

db.stores.find({'_id':1},{'Address':1,'City':1,'Country':1});

// Show pair of film titles and rating of films that have the same rating

db.films.aggregate(
    [
        { $group : { _id : "$Rating", films: { $push: "$Title"} } }
        ]
    )
// Get all the films that are available in store id 2 and the manager first/last name of this store (the manager will appear in all the rows).
