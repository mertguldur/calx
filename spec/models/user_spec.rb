require 'rails_helper'

describe User do
  it 'creates a user' do
    user = build(:user)
    expect(user.save).to eq(true)
  end

  it 'validates the presence of email' do
    user = build(:user, email: '')
    expect(user.save).to eq(false)
    expect(user.errors.full_messages.first).to eq("Email can't be blank")
  end

  it 'validates the length of email' do
    user = build(:user, email: 'a' * 256)
    expect(user.save).to eq(false)
    expect(user.errors.full_messages.first).to eq('Email is too long (maximum is 255 characters)')
  end

  it 'validates the format of email' do
    user = build(:user, email: 'foo')
    expect(user.save).to eq(false)
    expect(user.errors.full_messages.first).to eq('Email is invalid')
  end

  it 'validates the uniqueness of email' do
    create(:user, email: 'foo@bar.com')
    user = build(:user, email: 'foo@bar.com')
    expect(user.save).to eq(false)
    expect(user.errors.full_messages.first).to eq('Email has already been taken')
  end

  it 'saves the email with lower characters' do
    user = create(:user, email: 'FOO@bar.com')
    expect(user.email).to eq('foo@bar.com')
  end

  it 'validates the presence of password' do
    user = build(:user, password: '')
    expect(user.save).to eq(false)
    expect(user.errors.full_messages.first).to eq("Password can't be blank")
  end

  it 'validates the length of password' do
    user = build(:user, password: '12345', password_confirmation: '12345')
    expect(user.save).to eq(false)
    expect(user.errors.full_messages.first).to eq('Password is too short (minimum is 6 characters)')
  end

  it 'checks if password and password confirmation are the same' do
    user = build(:user, password: '123456', password_confirmation: 'testtest')
    expect(user.save).to eq(false)
    expect(user.errors.full_messages.first).to eq("Password confirmation doesn't match Password")
  end

  it 'persists a password digest' do
    user = create(:user)
    expect(user.password_digest).to_not be_nil
  end

  it 'persists a remember digest' do
    user = create(:user)
    expect(user.remember_digest).to_not be_nil
  end

  it 'persists an API ID' do
    user = create(:user)
    expect(user.api_id).to_not be_nil
  end

  it 'validates the presence of time zone' do
    user = build(:user, time_zone: nil)
    expect(user.save).to eq(false)
    expect(user.errors.full_messages.first).to eq("Time zone can't be blank")
  end
end
