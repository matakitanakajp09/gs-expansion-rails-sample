# frozen_string_literal: true

# == Schema Information
#
# Table name: article_tags
#
#  id                                    :bigint           not null, primary key
#  created_at                            :datetime         not null
#  updated_at                            :datetime         not null
#  article_id(Articleテーブルの外部キー) :uuid
#  tag_id(Tagテーブルの外部キー)         :uuid
#
# Indexes
#
#  index_article_tags_on_article_id  (article_id)
#  index_article_tags_on_tag_id      (tag_id)
#
# Foreign Keys
#
#  fk_rails_...  (article_id => articles.id)
#  fk_rails_...  (tag_id => tags.id)
#
class ArticleTag < ApplicationRecord
  belongs_to :article
  belongs_to :tag
end
