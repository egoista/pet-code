# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# PetKinds
horse = PetKind.create(name: 'cavalo')
dog = PetKind.create(name: 'cachorro')
parrot = PetKind.create(name: 'papagaio')
llama = PetKind.create(name: 'lhama')
iguana = PetKind.create(name: 'iguana')
platypus = PetKind.create(name: 'ornitorrinco')
swallow = PetKind.create(name: 'andorinha')

# People
johnny = Person.create(name: 'Johnny Cash',	document: '555555555', birthdate:	'26/02/1932'.to_date)
sid = Person.create(name: 'Sid Vicious',	document: '555555555', birthdate:	'10/05/1957'.to_date)
axl = Person.create(name: 'Axl Rose',	document: '555555555', birthdate:	'06/02/1962'.to_date)
joey = Person.create(name: 'Joey Ramone',	document: '555555555', birthdate:	'19/05/1951'.to_date)
bruce = Person.create(name: 'Bruce Dickinson',	document: '555555555', birthdate:	'07/08/1958'.to_date)
kurt = Person.create(name: 'Kurt Cobain',	document: '555555555', birthdate:	'20/02/1967'.to_date)
elvis = Person.create(name: 'Elvis Presley',	document: '555555555', birthdate:	'17/08/2008'.to_date)

# Pets
Pet.create([
  { name: "Pé de Pano", monthly_cost: 199.99, pet_kind: horse, owner: johnny },
  { name: "Rex", monthly_cost: 99.99, pet_kind: dog, owner: sid },
  { name: "Ajudante do Papai Noel", monthly_cost: 99.99, pet_kind: dog, owner: axl },
  { name: "Rex", monthly_cost: 103.99, pet_kind: parrot, owner: joey },
  { name: "Flora", monthly_cost: 103.99, pet_kind: llama, owner: bruce },
  { name: "Dino", monthly_cost: 177.99, pet_kind: iguana, owner: kurt },
  { name: "Lassie", monthly_cost: 407.99, pet_kind: platypus, owner: elvis }
])