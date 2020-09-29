require 'rails_helper'

RSpec.feature 'Unlogged user', type: :feature do
  let(:user) { create(:user) }
  let!(:event) { create(:event, user: user) }
  let!(:event_with_pincode) { create(:event, user: user, pincode: '987654321') }

  scenario 'view event' do
    visit '/'
    expect(page).to have_text("#{event.title}")
    click_link "#{event.title}" # show Event

    expect(page).to have_current_path event_path(event)
    expect(page).to have_text("#{event.description}")
    expect(page).to have_text("#{event.address}")
    expect(page).to have_text("#{I18n.l(event.datetime, format: :short)}")
    expect(page).to have_css('div.yandex-map')
    # <div id="map" data-address="Moscow river"></div>

  end

  scenario 'posts comment' do
    visit event_path(event)
    expect(page).to have_no_text('My great comment')
    fill_in 'comment_body', with: 'My great comment'
    fill_in 'comment_user_name', with: 'John Doe jr'
    click_button 'Отправить'

    expect(page).to have_text('My great comment')
    expect(page).to have_text('John Doe jr')
    expect(page).to have_text("#{I18n.l(Time.zone.now, format: :short)}")
  end

  scenario 'get errors when posts empty comment' do
    visit event_path(event)
    expect(page).to have_no_text('My great comment')
    click_button 'Отправить'

    # expect(page).to have_text('Отправить')
    expect(page).to have_css('div.alert-danger')
  end

  scenario 'subscribes' do
    visit event_path(event)
    expect(page).to have_no_text('Alica Fox')
    fill_in 'subscription_user_name', with: 'Alica Fox'
    fill_in 'subscription_user_email', with: 'alice@alice.ru'
    click_button 'Подписаться'

    expect(page).to have_text('Alica Fox')
  end

  scenario 'get errors when empty subscribe' do
    visit event_path(event)
    expect(page).to have_no_text('Alica Fox')
    click_button 'Подписаться'

    # expect(page).to have_text('Подписаться')
    expect(page).to have_css('div.alert-danger')
  end

  scenario 'view protected event with PIN-code' do
    visit event_path(event_with_pincode)
    expect(page).to have_no_text("#{event_with_pincode.title}")
    expect(page).to have_text("#{I18n.t('access_only_by_pincode')}")

    fill_in 'pincode', with: '987654321'
    click_button "#{I18n.t('action.save')}"

    expect(page).to have_current_path event_path(event_with_pincode)
    expect(page).to have_text("#{event_with_pincode.description}")
    expect(page).to have_text("#{event_with_pincode.address}")
    expect(page).to have_text("#{I18n.l(event_with_pincode.datetime, format: :short)}")
    expect(page).to have_css('div.yandex-map')
  end
end
