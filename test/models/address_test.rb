# frozen_string_literal: true

require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  def setup
    @address = Address.new(
      zip_code: '12345678',
      street: 'Rua ABC',
      number: '123',
      neighbourhood: 'Bairro XYZ',
      city: 'Cidade',
      state: 'Estado'
    )
  end

  test 'should be valid' do
    assert_predicate @address, :valid?
  end

  %i[zip_code street number neighbourhood city state].each do |attribute|
    test "presence of #{attribute}" do
      @address[attribute] = nil

      assert_not @address.valid?
      assert_equal ["can't be blank"], @address.errors[attribute]
    end
  end

  %w[12345678 54321098].each do |zip_code|
    test "zip code is valid when your value is #{zip_code}" do
      @address.zip_code = zip_code

      assert_predicate @address, :valid?, "#{zip_code} should be valid"
    end
  end

  %w[1234 12345-6789 1234A ABCDE 12345-678].each do |zip_code|
    test "zip code is invalid when your value is #{zip_code}" do
      @address.zip_code = zip_code

      assert_not @address.valid?, "#{zip_code} should be invalid"
      assert_equal ['is invalid'], @address.errors[:zip_code]
    end
  end

  %w[123 123A 12B 1C S/N 123a s/n].each do |number|
    test "number is valid when your value is #{number}" do
      @address.number = number

      assert_predicate @address, :valid?, "#{number} should be valid"
    end
  end

  ['A123', '12-', '12.3', 'asd'].each do |number|
    test "number is valid when your value is #{number}" do
      @address.number = number

      assert_not @address.valid?, "#{number} should be invalid"
      assert_equal ['is invalid'], @address.errors[:number]
    end
  end
end
