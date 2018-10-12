class Mutations::CreateLink < Mutations::BaseMutation
  # arguments passed as "args"
  argument :description, String, required: true
  argument :url, String, required: true

  # return type from the mutation
  field :link, Types::LinkType, null: true
  field :errors, [String], null: false

  # the mutation method
  def resolve(description:, url:)
    link = Link.new(
      description: description,
      url: url,
      user: context[:current_user]
    )
    link.save!

    # Successful creation, return the created object with no errors
    {
      link: link,
      errors: [],
    }
  rescue ActiveRecord::RecordInvalid => e
    # this would catch all validation errors and translate them to GraphQL::ExecutionError
    GraphQL::ExecutionError.new("Invalid input: #{e.record.errors.full_messages.join(', ')}")
  end
end
