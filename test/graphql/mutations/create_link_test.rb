require 'test_helper'

class Mutations::CreateLinkTest < ActiveSupport::TestCase
  def perform(args = {})
    Mutations::CreateLink.new(object: nil, context: nil).resolve(args).fetch(:link)
  end

  test 'creating new link' do
    link = perform(
      url: 'http://example.com',
      description: 'description',
    )

    assert link.persisted?
    assert_equal link.description, 'description'
    assert_equal link.url, 'http://example.com'
  end
end
