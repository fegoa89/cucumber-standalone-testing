Given("I am on the home page") do
  visit('/')
end

Given("I search for {string}") do |string|
  fill_in 'search_form_input_homepage', with: string
  click_on('search_button_homepage')
end

Then("I will hopefully see {string} in my search results") do |string|
  expect(page).to have_content(string)
end
