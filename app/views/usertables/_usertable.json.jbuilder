json.extract! usertable, :id, :TypeMem, :name, :email, :password, :active, :age, :gender, :created_at, :updated_at
json.url usertable_url(usertable, format: :json)
