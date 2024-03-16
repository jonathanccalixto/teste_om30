# frozen_string_literal: true

require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  def setup
    @address = Address.new(
      municipe: municipes(:active),
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
    test "invalid when #{attribute} is blank" do
      @address[attribute] = nil

      @address.valid?

      assert_includes @address.errors[attribute], "can't be blank"
    end

    test "valid when #{attribute} is filled" do
      @address[attribute] = 'some value'

      @address.valid?

      assert_not_includes @address.errors[attribute], "can't be blank"
    end
  end

  %w[12345678 54321098].each do |zip_code|
    test "zip code is valid when your value is #{zip_code}" do
      @address.zip_code = zip_code

      @address.valid?

      assert_not_includes @address.errors[:zip_code], 'is invalid'
    end
  end

  %w[1234 12345-6789 1234A ABCDE 12345-678].each do |zip_code|
    test "zip code is invalid when your value is #{zip_code}" do
      @address.zip_code = zip_code

      @address.valid?

      assert_includes @address.errors[:zip_code], 'is invalid'
    end
  end

  %w[123 123A 12B 1C S/N 123a s/n].each do |number|
    test "number is valid when your value is #{number}" do
      @address.number = number

      @address.valid?

      assert_not_includes @address.errors[:zip_code], 'is invalid'
    end
  end

  ['A123', '12-', '12.3', 'asd'].each do |number|
    test "number is invalid when your value is #{number}" do
      @address.number = number

      @address.valid?

      assert_includes @address.errors[:number], 'is invalid'
    end
  end
end
