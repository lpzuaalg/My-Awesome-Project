module Types
  class LinkType < Types::BaseObject
    # it has the following fields
    field :id, ID, null: false
    field :url, String, null: false
    field :description, String, null: false
    # add postedBy field to Link type
    # - "-> { }": helps against loading issues between types
    # - "property": remaps field to an attribute of Link model
    field :posted_by, Types::UserType, null: true, method: :user
    field :votes, [Types::VoteType], null: false

    def user
      AssociationLoader.for(Link, :user).load(object)
    end

    def votes
      AssociationLoader.for(Link, :votes).load(object)
    end
  end
end
