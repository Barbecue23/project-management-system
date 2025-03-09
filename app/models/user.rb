class User < ApplicationRecord
    belongs_to :role, optional: true
end
