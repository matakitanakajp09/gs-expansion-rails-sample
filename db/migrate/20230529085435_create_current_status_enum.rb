# frozen_string_literal: true

class CreateCurrentStatusEnum < ActiveRecord::Migration[7.0]
  def up
    create_enum :current_status, %w[draft published archived trashed]
  end

  def down
    # While there is a `create_enum` method, there is no way to drop it. You can
    # how ever, use raw SQL to drop the enum type.
    execute <<-SQL
      DROP TYPE current_status;
    SQL
  end
end
