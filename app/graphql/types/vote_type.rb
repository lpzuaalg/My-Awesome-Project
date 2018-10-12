module Types
  class VoteType < Types::BaseObject
    field :id, ID, null: false
    field :user, Types::UserType, null: false
    field :link, Types::LinkType, null: false

    def user
      AssociationLoader.for(Vote, :user).load(object)
    end

    def link
      AssociationLoader.for(Vote, :link).load(object)
    end
  end
end
