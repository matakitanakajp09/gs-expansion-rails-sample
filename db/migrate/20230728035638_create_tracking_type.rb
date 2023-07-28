# frozen_string_literal: true

class CreateTrackingType < ActiveRecord::Migration[7.0]
  def up
    create_enum :tracking_type, %w[imp click]
  end

  def down
    # While there is a `create_enum` method, there is no way to drop it. You can
    # how ever, use raw SQL to drop the enum type.
    execute <<-SQL
      DROP TYPE tracking_type;
    SQL
  end
end
