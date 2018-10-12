class Mutations::SignInUser < Mutations::BaseMutation

  # arguments passed as "args"
  argument :email, String, required: true
  argument :password, String, required: true

  # return type from the mutation
  field :user, Types::UserType, null: true
  field :token, String, null: true
  field :errors, [String], null: false

  # the mutation method
  def resolve(email:, password:)
    user = User.find_by_email(email)
    if user.authenticate(password)
      crypt = ActiveSupport::MessageEncryptor.new(Rails.application.credentials.secret_key_base.byteslice(0..31))
      token = crypt.encrypt_and_sign("user-id:#{ user.id }")

      context[:session][:token] = token

      # Successful creation, return the signed in user with no errors
      {
        user: user,
        token: token,
        errors: [],
      }
    else
      # Failed save, return the errors to the client
      {
        user: nil,
        token: nil,
        errors: ['Invalid email or password.']
      }
    end
  end
end
