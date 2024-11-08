class Department < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    ["id", "department_name"]
  end
end
