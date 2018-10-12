class Mutations::CreateVote < Mutations::BaseMutation
  # arguments passed as "args"
  argument :link_id, ID, required: true

  # return type from the mutation
  field :vote, Types::VoteType, null: true
  field :errors, [String], null: false

  # the mutation method
  def resolve(link_id:)
    vote = Vote.new(
      link_id: link_id,
      user: context[:current_user]
    )
    if vote.save
      # Successful creation, return the created object with no errors
      {
        vote: vote,
        errors: [],
      }
    else
      # Failed save, return the errors to the client
      {
        vote: nil,
        errors: link.errors.full_messages
      }
    end
  end
end
