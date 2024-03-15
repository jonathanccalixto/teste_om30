# frozen_string_literal: true

require 'test_helper'

class MunicipeTest < ActiveSupport::TestCase
  def setup
    @municipe = Municipe.new(
      name: 'John Doe',
      cpf: '123.456.789-10',
      cns: '123456789012345',
      email: 'john@example.com',
      birthday: Date.new(1990, 1, 1),
      phone: '1234567890',
      status: :active
    )
  end

  test 'should be valid' do
    assert_predicate @municipe, :valid?
  end

  # Testes de presença
  test 'name should be present' do
    @municipe.name = '     '

    assert_not @municipe.valid?
  end

  test 'cpf should be present' do
    @municipe.cpf = '     '

    assert_not @municipe.valid?
  end

  test 'cns should be present' do
    @municipe.cns = '     '

    assert_not @municipe.valid?
  end

  test 'email should be present' do
    @municipe.email = '     '

    assert_not @municipe.valid?
  end

  test 'birthday should be present' do
    @municipe.birthday = nil

    assert_not @municipe.valid?
  end

  test 'phone should be present' do
    @municipe.phone = '     '

    assert_not @municipe.valid?
  end

  # Testes de validade dos atributos
  test 'cpf should be valid format' do
    @municipe.cpf = '123'

    assert_not @municipe.valid?
  end

  test 'cns should be valid format' do
    @municipe.cns = '123'

    assert_not @municipe.valid?
  end

  test 'email should be valid format' do
    @municipe.email = 'invalid_email'

    assert_not @municipe.valid?
  end

  test 'birthday should be less than current date' do
    @municipe.birthday = Date.new(3000, 1, 1)

    assert_not @municipe.valid?
  end

  # Teste de unicidade
  test 'cpf should be unique' do
    duplicate_municipe = @municipe.dup
    @municipe.save

    assert_not duplicate_municipe.valid?
  end

  test 'cns should be unique' do
    duplicate_municipe = @municipe.dup
    @municipe.save

    assert_not duplicate_municipe.valid?
  end

  # Teste de enum
  test 'status should be either active or inactive' do
    @municipe.status = :random_status

    assert_not @municipe.valid?
  end
end
