class Admin < ApplicationRecord
  devise :trackable, :timeoutable
end
