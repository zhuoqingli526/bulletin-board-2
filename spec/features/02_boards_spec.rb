require "rails_helper"

describe "/boards" do
  it "lists the names of each Board record in the database", points: 2 do
    the_user = User.new
    the_user.email = "claire@example.com"
    the_user.password = "password"
    the_user.save

    visit "/users/sign_in"
    
    within(:css, "form") do
      fill_in "Email", with: the_user.email
      fill_in "Password", with: the_user.password
      click_button "Log in"
    end
    
    board_chi = Board.new
    board_chi.name = "Chicago"
    board_chi.user_id = the_user.id
    board_chi.save
    
    visit "/boards"

    expect(page).to have_text(board_chi.name),
      "Expected page to have the name, '#{board_chi.name}'"
  end
end

describe "/boards" do
  it "has a form", points: 1 do
    the_user = User.new
    the_user.email = "claire@example.com"
    the_user.password = "password"
    the_user.save

    visit "/users/sign_in"
    
    within(:css, "form") do
      fill_in "Email", with: the_user.email
      fill_in "Password", with: the_user.password
      click_button "Log in"
    end

    visit "/boards"

    expect(page).to have_css("form", minimum: 1)
  end
end

describe "/boards" do
  it "has a label for 'Name' with text: 'Name'", points: 1, hint: h("copy_must_match label_for_input") do
    the_user = User.new
    the_user.email = "claire@example.com"
    the_user.password = "password"
    the_user.save

    visit "/users/sign_in"
    
    within(:css, "form") do
      fill_in "Email", with: the_user.email
      fill_in "Password", with: the_user.password
      click_button "Log in"
    end

    visit "/boards"

    expect(page).to have_css("label", text: "Name")
  end
end

describe "/boards" do
  it "creates a Board when 'Add board' form is submitted", points: 5, hint: h("button_type") do
    the_user = User.new
    the_user.email = "claire@example.com"
    the_user.password = "password"
    the_user.save

    visit "/users/sign_in"
    
    within(:css, "form") do
      fill_in "Email", with: the_user.email
      fill_in "Password", with: the_user.password
      click_button "Log in"
    end

    initial_number_of_boards = Board.count
    test_name = "Chicago"

    visit "/boards"

    fill_in "Name", with: "Chicago"
    click_on "Add board"
    final_number_of_boards = Board.count
    expect(final_number_of_boards).to eq(initial_number_of_boards + 1)
  end
end

describe "/boards/[ID]" do
  it "has a 'Delete post' link if the user is the owner", points: 0 do
    the_user = User.new
    the_user.email = "claire@example.com"
    the_user.password = "password"
    the_user.save

    visit "/users/sign_in"
    
    within(:css, "form") do
      fill_in "Email", with: the_user.email
      fill_in "Password", with: the_user.password
      click_button "Log in"
    end
    
    board_chi = Board.new
    board_chi.name = "Chicago"
    board_chi.user_id = the_user.id
    board_chi.save

    post_1 = Post.new
    post_1.title = "Guitar lessons"
    post_1.body = "Learn with me"
    post_1.expires_on = Date.today + 7.days
    post_1.board_id = board_chi.id
    post_1.user_id = the_user.id
    post_1.save

    visit "/boards/#{board_chi.id}"
    
    expect(page).to have_tag("a", :text => /Delete post/i)
  end
end
