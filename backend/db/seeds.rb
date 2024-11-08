# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

[
  {name: "開発部"},
  {name: "デザイン部"},
  {name: "営業部"},
  {name: "総務部"},
].each do |department|
  Department.find_or_create_by!(department_name: department[:name])
end

[
  {name: "東京"},
  {name: "仙台"},
  {name: "日南"},
  {name: "鹿児島"},
].each do |office|
  Office.find_or_create_by!(office_name: office[:name])
end

# 部署
development = Department.find(1)
design = Department.find(2)
sales = Department.find(3)
back_office = Department.find(4)

# 拠点
tokyo = Office.find(1)
sendai = Office.find(2)
nichinan = Office.find(3)
kagoshima = Office.find(4)

[
  {screen_name: "東京総務部太郎", status: 1, email: "taro1@example.com", password: "password", office: tokyo, department: back_office},
  {screen_name: "東京開発太郎", status: 1, email: "taro2@example.com", password: "password", office: tokyo, department: development},
  {screen_name: "東京デザイン太郎", status: 1, email: "taro3@example.com", password: "password", office: tokyo, department: design},
  {screen_name: "東京営業太郎", status: 1, email: "taro4@example.com", password: "password", office: tokyo, department: sales},
  {screen_name: "仙台総務部太郎", status: 1, email: "taro5@example.com", password: "password", office: sendai, department: back_office},
  {screen_name: "仙台開発太郎", status: 1, email: "taro6@example.com", password: "password", office: sendai, department: development},
  {screen_name: "仙台デザイン太郎", status: 1, email: "taro7@example.com", password: "password", office: sendai, department: design},
  {screen_name: "仙台営業太郎", status: 1, email: "taro8@example.com", password: "password", office: sendai, department: sales},
  {screen_name: "日南総務部太郎", status: 1, email: "taro9@example.com", password: "password", office: nichinan, department: back_office},
  {screen_name: "日南開発太郎", status: 1, email: "taro10@example.com", password: "password", office: nichinan, department: development},
  {screen_name: "日南デザイン太郎", status: 1, email: "taro11@example.com", password: "password", office: nichinan, department: design},
  {screen_name: "日南営業太郎", status: 1, email: "taro12@example.com", password: "password", office: nichinan, department: sales},
  {screen_name: "鹿児島総務部太郎", status: 1, email: "taro13@example.com", password: "password", office: kagoshima, department: back_office},
  {screen_name: "鹿児島開発太郎", status: 1, email: "taro14@example.com", password: "password", office: kagoshima, department: development},
  {screen_name: "鹿児島デザイン太郎", status: 1, email: "taro15@example.com", password: "password", office: kagoshima, department: design},
  {screen_name: "鹿児島営業太郎", status: 1, email: "taro16@example.com", password: "password", office: kagoshima, department: sales},
].each do |user|
  User.new(user).save
end
