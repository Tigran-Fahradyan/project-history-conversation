user = User.find_by(email: 'someemail@host.com')
if user.blank?
  user = User.create!(
    email: 'someemail@host.com',
    password: '123456',
    password_confirmation: '123456',
    name: 'Some User'
  )
end

if user.projects.blank?
  Project.create!(
    name: 'Sample Project',
    description: 'This is a sample project created for demonstration purposes.',
    user: user,
    status: :idle
  )
end

