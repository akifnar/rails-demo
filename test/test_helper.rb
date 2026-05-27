ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  #parallelize(workers: :number_of_processors)

  fixtures :all
end


class ActionDispatch::IntegrationTest
    def login_as_user(user)
      post "/login", params: { name: user.name, password: "helva" }
      session[:user_id] = user.id
    end
end
