# frozen_string_literal: true

# bin/rails db:seed

# とりあえず初回のみ実行したいので早期リターンを記述しておく
return if Author.exists?

now = Time.current
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
series = Series.create(
  [
    {
      title: "どうするZ世代",
      subtitle: "Z世代が世界を変える"
    },
    {
      title: "異次元の子育て政策、まさかのバカ異次元",
      subtitle: "異次元すぎる子育て政策について"
    }
  ]
)
tags = Tag.create(
  [
    {
      name: "ポエム"
    },
    {
      name: "非認知能力"
    }
  ]
)
titles = [
  "アドバンテストが上場来高値 NVIDIA好決算で",
  "「ペッパー」がChatGPTで賢く 話すロボに中国勢も参戦",
  "ネット広告、生成AIが作成 Googleやメタが実用化"
]
subtitles = [
  "Windowsに対話型AI搭載、デモ公開 コピペで文書要約",
  "AI開発の米アンソロピック、Googleなどから620億円調達",
  "Microsoft、ChatGPTと検索融合 最新の情報を回答"
]
authors.each do |author|
  @articles = Array.new(20).map.with_index do |_, _idx|
    article = author.articles.build(
      title: titles.sample,
      subtitle: subtitles.sample,
      category: categories.sample,
      current_status: Article.current_statuses.values.sample,
      published_at: now
    )
    article.tap(&:save)
  end
end

@articles.sample(5).each do |article|
  article_series = article.build_article_series(
    series: series.sample
  )
  article_series.save

  article.article_tags.create(
    tag: tags.sample
  )
end

# 30.times.each do |t|
#   NewsletterSubscriber.create(email: "test-#{t}@test.com")
# end
