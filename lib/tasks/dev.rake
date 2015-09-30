namespace :dev do
  desc 'Create 10 fake users'
  task create_users: :environment do
    10.times do |i|
      User.create(email: "fake#{i}@test.com",
        password: '12345678',
        password_confirmation: '12345678')
    end
  end
end
