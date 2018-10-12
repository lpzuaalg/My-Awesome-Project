module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :email, String, null: false
    field :votes, [Types::VoteType], null: false

    def votes
      AssociationLoader.for(User, :votes).load(object)
    end
  end
end
