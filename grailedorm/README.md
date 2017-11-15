# GrailedORM
GrailedORM is an object-relational mapping system written with Ruby inspired by Active Record.


## [GrailedORM::Base](./base.rb)
The `Base` class defines attribute methods for column names for each object via `::finalize`. This `Base` class creates basic database functionality of these objects similar to Active Record. Methods such as `::find` can return a specific object that matches the input `id`.
`#insert` creates a new object into that particular column, while `#save` can create and call `#update` depending on if the object's id already exist in the column.

## [GrailedORM::Associatable](./associatable.rb)

Associatable creates relationships between objects from different classes. Available methods include `::has_many`, `::belongs_to`, `::has_one_through`, `::has_many_through`.

## [GrailedORM::Searchable](./searchable.rb)

Searchable gives a powerful `::where` method where users can query the database use any parameters passed as an object to find results.
