# frozen_string_literal: true

require 'test_helper'

class MunicipeTest < ActiveSupport::TestCase
  def setup
    @municipe = Municipe.new
    @active_municipe = municipes(:active)
    @inactive_municipe = municipes(:inactive)
  end

  test 'valid municipes' do
    assert_predicate @active_municipe, :valid?
  end

  %i[name cpf cns email birthday phone].each do |attribute|
    test "invalid when #{attribute} is blank" do
      @municipe[attribute] = nil

      @municipe.valid?

      assert_includes @municipe.errors[attribute], "can't be blank"
    end

    test "valid when #{attribute} is filled" do
      @municipe[attribute] = 'some value'

      @municipe.valid?

      assert_not_includes @municipe.errors[attribute], "can't be blank"
    end
  end

  %w[1234567890 812.588.044-50].each do |cpf|
    test "cpf is invalid when your value is #{cpf}" do
      @municipe.cpf = cpf

      @municipe.valid?

      assert_includes @municipe.errors[:cpf], 'is invalid'
    end
  end

  %w[37348883010 81258804450].each do |cpf|
    test "cpf is valid when your value is #{cpf}" do
      @municipe.cpf = cpf

      @municipe.valid?

      assert_not_includes @municipe.errors[:cpf], 'is invalid'
    end
  end

  ['1234567890123456', '298 6092 9649 0004'].each do |cns|
    test "cns is invalid when your value is #{cns}" do
      @municipe.cns = cns

      @municipe.valid?

      assert_includes @municipe.errors[:cns], 'is invalid'
    end
  end

  %w[734342598410005 298609296490004].each do |cns|
    test "cns is valid when your value is #{cns}" do
      @municipe.cns = cns

      @municipe.valid?

      assert_not_includes @municipe.errors[:cns], 'is invalid'
    end
  end

  %w[invalid_email +_)@email.com invalid.email.net].each do |email|
    test "email is invalid when your value is #{email}" do
      @municipe.email = email

      @municipe.valid?

      assert_includes @municipe.errors[:email], 'is invalid'
    end
  end

  %w[john.doe@email.com mary.doe@email.net].each do |email|
    test "email is valid when your value is #{email}" do
      @municipe.email = email

      @municipe.valid?

      assert_not_includes @municipe.errors[:email], 'is invalid'
    end
  end

  test 'uniqueness of cpf' do
    @municipe.cpf = @active_municipe.cpf

    @municipe.valid?

    assert_includes @municipe.errors[:cpf], 'has already been taken'
  end

  test 'uniqueness of cns' do
    @municipe.cns = @inactive_municipe.cns

    @municipe.valid?

    assert_includes @municipe.errors[:cns], 'has already been taken'
  end
end
