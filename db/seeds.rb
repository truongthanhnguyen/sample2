User.create!(name: "Example User", email: "example@railstutorial.org", password: "foobar", password_confirmation: "foobar", admin: true, activated: true, activated_at: Time.zone.now)

30.times do |n|
	name  = Faker::Name.name
	email = "example-#{n+1}@railstutorial.org"
	password = "password"
	User.create!(name: name, email: email, password: password, password_confirmation: password, activated: true, activated_at: Time.zone.now)
end

users = User.order(:created_at).take(6)
10.times do
	title = Faker::Lorem.sentence(1)
	content = Faker::Lorem.sentence(5)
	users.each { |user| user.microposts.create!(content: content, title: title) }
end

users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

Micropost.all.each do |m|
	5.times do |n|
		str = Faker::Lorem.sentence(2)
		i = n+1
		Comment.create(content: str, micropost_id: m.id, user_id: i)
	end
end
