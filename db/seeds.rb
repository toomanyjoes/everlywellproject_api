# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = User.create([
                         {first_name: "John", last_name: "Smith", website: "http://www.johnsmith.com"},
                         {first_name: "Tom", last_name: "Petty", website: "http://www.tompetty.com"},
                         {first_name: "Willie", last_name: "Nelson", website: "http://www.willienelson.com"},
                         {first_name: "Sarah", last_name: "Palin", website: "http://www.sarahpalin.com"},
                         {first_name: "Nancy", last_name: "Drew", website: "http://www.nancydrew.com"},
                         {first_name: "Rebecca", last_name: "Wise", website: "http://www.rebeccawise.com"},
                         {first_name: "Theo", last_name: "Ifrits", website: "http://www.theoifrits.com"},
                         {first_name: "Richard", last_name: "White", website: "http://www.richardwhite.com"},
                     ])

friends = Friend.create([
                            {user_id: 1, friend_id:2},
                            {user_id: 1, friend_id:3},
                            {user_id: 1, friend_id:4},
                            {user_id: 1, friend_id:5},
                            {user_id: 1, friend_id:6},
                            {user_id: 2, friend_id:1},
                            {user_id: 3, friend_id:1},
                            {user_id: 4, friend_id:1},
                            {user_id: 5, friend_id:1},
                            {user_id: 6, friend_id:1},
                            {user_id: 6, friend_id:5},
                            {user_id: 5, friend_id:6},
                         ])

userdata = Userdatum.create([
                              {user_id: 1, data_type: 'heading', data: "my expert heading 1"},
                              {user_id: 1, data_type: 'heading', data: "my expert heading 2"},
                              {user_id: 1, data_type: 'heading', data: "my expert heading 3"},
                              {user_id: 1, data_type: 'heading', data: "my expert heading 4"},
                              {user_id: 1, data_type: 'heading', data: "my expert heading 5"},
                              {user_id: 2, data_type: 'heading', data: "my expert heading 1"},
                              {user_id: 2, data_type: 'heading', data: "my expert heading 2"},
                              {user_id: 2, data_type: 'heading', data: "my expert heading 3"},
                              {user_id: 2, data_type: 'heading', data: "my expert heading 4"},
                              {user_id: 3, data_type: 'heading', data: "my expert heading 1"},
                              {user_id: 3, data_type: 'heading', data: "my expert heading 2"},
                              {user_id: 4, data_type: 'heading', data: "my expert heading 1"},
                              {user_id: 4, data_type: 'heading', data: "my expert heading 2"},
                              {user_id: 5, data_type: 'heading', data: "my expert heading 1"},
                              {user_id: 6, data_type: 'heading', data: "my expert heading 1"},
                            ])