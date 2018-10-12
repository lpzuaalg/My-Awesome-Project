module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me

    # queries are just represented as fields
    field :all_links, [LinkType], null: false do
      argument :first, Integer, required: false, default_value: 100, as: :limit
      argument :skip, Integer, required: false, default_value: 0, as: :offset
    end

    def all_links(limit:, offset:)
      Link.limit(limit).offset(offset)
    end
          # resolve: -> (obj, args, ctx) { Link.all }
      # resolve would be called in order to fetch data for that field
      # resolve -> (obj, args, ctx) { Link.all }
    # field :test_field, String, null: false,
    #   description: "An example field added by the generator"
    # def test_field
    #   "Hello World!"
    # end

    # Then provide an implementation:
    # def all_links
    #   Link.all
    # end
  end
end
