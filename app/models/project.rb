class Project < ApplicationRecord
  belongs_to :client
  encrypts :secret_token

end
