# frozen_string_literal: true

# == Schema Information
#
# Table name: article_topics
#
#  id                                    :bigint           not null, primary key
#  created_at                            :datetime         not null
#  updated_at                            :datetime         not null
#  article_id(Articleテーブルの外部キー) :uuid
#  topic_id(Topicテーブルの外部キー)     :uuid
#
# Indexes
#
#  index_article_topics_on_article_id  (article_id)
#  index_article_topics_on_topic_id    (topic_id)
#
# Foreign Keys
#
#  fk_rails_...  (article_id => articles.id)
#  fk_rails_...  (topic_id => topics.id)
#
class ArticleSeries < ApplicationRecord
  belongs_to :article
  belongs_to :series

  acts_as_list scope: :series

  def self.update_position!(article_series = [])
    change_columns = %i[position]
    return false if article_series.blank?

    targets = article_series.map.with_index do |as, idx|
      order = idx + 1
      as.position = order
      as
    end
    import targets, on_duplicate_key_update: change_columns, validate: false
    true
  end
end
