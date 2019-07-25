# README

Projeto criado para o [desafio da PetLove](CHALLENGE.md)

## Considerações

Criei a entidade suporte PetKind para associar os animais a uma entidade inves de uma string. Foi considerado usar Enum, mas como o desafio era muito focado em queries, decidi por uma nova entidade.

## Testes

Foram adicionados testes apenas para a model Person por entender que era a unica entidade com regras de negocio.

## Questões

### Qual é o custo médio dos animais do tipo cachorro?

    Pet.joins(:pet_kind).where(pet_kinds: {name: 'cachorro'}).average(:monthly_cost).to_f

### Quantos cachorros existem no sistema?

    Pet.joins(:pet_kind).where(pet_kinds: {name: 'cachorro'}).count

### Qual o nome dos donos dos cachorros (Array de nomes)

    Person.joins(pets: :pet_kind).where(pet_kinds: {name: 'cachorro'}).pluck(:name)

### Retorne as pessoas ordenando pelo custo que elas tem com os animais (Maior para menor)

    Person.joins(:pets).group(:name).order('sum_monthly_cost desc').sum(:monthly_cost)

### Levando em consideração o custo mensal, qual será o custo de 3 meses de cada pessoa?

    Person.joins(:pets).group(:name).sum("3 * monthly_cost")