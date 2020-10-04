require 'rails_helper'

RSpec.feature 'Signed user', type: :feature do
  let(:owner) { create(:user) }
  let(:user) { create(:user) }
  let!(:event) { create(:event, user: owner) }
  let!(:event_with_pincode) { create(:event, user: owner, pincode: '987654321') }
  let(:new_event) { build(:event, address: 'Perm') }
  let(:own_event) { create(:event, user: user) }

  before(:each) { sign_in user }

  scenario 'view events' do
    visit '/'
    expect(page).to have_text(event.title.to_s)
    click_link event.title.to_s # show Event

    expect(page).to have_current_path event_path(event)
    expect(page).to have_text(event.description.to_s)
    expect(page).to have_text(event.address.to_s)
    expect(page).to have_text(I18n.l(event.datetime, format: :short).to_s)
    expect(page).to have_css('div.yandex-map')
  end

  scenario 'create event' do
    visit '/'
    expect(page).to have_text(event.title.to_s)
    expect(page).to have_link I18n.t('action.create_event'), href: new_event_path
    click_on I18n.t('action.create_event')

    fill_in 'event_title', with: new_event.title
    fill_in 'event_address', with: new_event.address
    fill_in 'event_datetime', with: new_event.datetime
    fill_in 'event_description', with: new_event.description
    click_button 'Сохранить'

    expect(page).to have_text(new_event.title)
    expect(page).to have_text(new_event.address.to_s)
    expect(page).to have_text(I18n.l(new_event.datetime, format: :short).to_s)
    expect(page).to have_link I18n.t('action.update')
    expect(page).to have_link I18n.t('action.destroy')

    visit '/'
    expect(page).to have_text(new_event.title.to_s)
  end

  context 'own events' do
    scenario 'view own event' do
      visit event_path(own_event)
      expect(page).to have_text(own_event.title)
      expect(page).to have_link I18n.t('action.update')
      expect(page).to have_link I18n.t('action.destroy')
    end
  end

  context 'other user`s events`' do
    scenario 'posts comment' do
      visit event_path(event)
      expect(page).to have_no_text('My great comment')
      fill_in 'comment_body', with: 'My great comment'
      click_button 'Отправить'

      expect(page).to have_text('My great comment')
      expect(page).to have_text(user.name)
      expect(page).to have_text(I18n.l(Time.zone.now, format: :short).to_s)
    end

    scenario 'get errors when posts empty comment' do
      visit event_path(event)
      expect(page).to have_no_text('My great comment')
      click_button 'Отправить'
      expect(page).to have_button('Отправить')
      expect(page).to have_css('div.alert-danger')
    end

    scenario 'subscribes' do
      visit event_path(event)
      click_button 'Подписаться'

      expect(page).to have_text('Вы подписаны на это событие')
    end

    scenario 'view protected event with PIN-code' do
      visit event_path(event_with_pincode)
      expect(page).to have_no_text(event_with_pincode.title.to_s)
      expect(page).to have_text(I18n.t('access_only_by_pincode').to_s)

      fill_in 'pincode', with: '987654321'
      click_button I18n.t('action.save').to_s

      expect(page).to have_current_path event_path(event_with_pincode)
      expect(page).to have_text(event_with_pincode.description.to_s)
      expect(page).to have_text(event_with_pincode.address.to_s)
      expect(page).to have_text(I18n.l(event_with_pincode.datetime, format: :short).to_s)
      expect(page).to have_css('div.yandex-map')
    end

    scenario 'upload images' do
      visit event_path(event)

      expect(page).to have_field('photo_photo')
      expect(page).to have_button(I18n.t('action.upload'))
    end
  end
end
