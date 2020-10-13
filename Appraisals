# frozen_string_literal: true

appraise 'rails-5.1-stable' do
  gem 'rails', github: 'rails/rails', branch: '5-1-stable'
end

appraise 'rails-5.2-stable' do
  gem 'rails', github: 'rails/rails', branch: '5-2-stable'
end

appraise 'rails-6.0-stable' do
  gem 'rails', github: 'rails/rails', branch: '6-0-stable'
  gem 'sqlite3', '~> 1.4'
end

appraise 'rails-edge' do
  gem 'rails', github: 'rails/rails', branch: :master
  gem 'arel', github: 'rails/arel', branch: :master
  gem 'sqlite3', '~> 1.4'
end
