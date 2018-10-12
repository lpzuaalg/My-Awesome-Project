class Mutations::CreateUser < Mutations::BaseMutation

  AuthProviderInput = GraphQL::InputObjectType.define do
    name 'AuthProviderSignupData'

    argument :email, Types::AuthProviderEmailInput
  end

  # arguments passed as "args"
  argument :name, String, required: true
  argument :auth_provider, AuthProviderInput, required: true

  # return type from the mutation
  field :user, Types::UserType, null: true
  field :errors, [String], null: false

  # the mutation method
  def resolve(name:, auth_provider:)
    user = User.new(
      name: name,
      email: auth_provider.email.email,
      password: auth_provider.email.password
    )
    if user.save
      # Successful creation, return the created object with no errors
      {
        user: user,
        errors: [],
      }
    else
      # Failed save, return the errors to the client
      {
        user: nil,
        errors: user.errors.full_messages
      }
    end
  end
end
