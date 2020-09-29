require 'rails_helper'

RSpec.feature 'User before creating event', type: :feature do

  scenario 'must be logged' do
    visit '/'

    click_link 'Создать событие'

    expect(page).to have_current_path '/users/sign_in'
    expect(page).to have_text('Вам необходимо войти в систему или зарегистрироваться.')
  end
end
