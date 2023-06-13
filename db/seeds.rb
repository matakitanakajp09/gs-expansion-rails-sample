# frozen_string_literal: true

# bin/rails db:seed

categories = Category.create(
  [
    {
      name: "business"
    },
    {
      name: "technology"
    },
    {
      name: "career"
    },
    {
      name: "finance"
    }
  ]
)
authors = Author.create(
  [
    {
      name: "MyCMS編集部",
      bio: "編集部"
    },
    {
      name: "Yuki",
      bio: "Yuki Tanaka"
    }
  ]
)
