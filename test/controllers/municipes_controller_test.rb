# frozen_string_literal: true

require 'test_helper'

class MunicipesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @municipe = municipes(:active)
    sign_in users(:john_doe)
  end

  test 'should get index' do
    get municipes_url

    assert_response :success
  end

  test 'should get new' do
    get new_municipe_url

    assert_response :success
  end

  test 'should create municipe' do
    assert_difference('Municipe.count') do
      post municipes_url,
           params: {
             municipe: {
               birthday: @municipe.birthday,
               cns: '850060419640018',
               cpf: '37731877698',
               email: @municipe.email,
               name: @municipe.name,
               phone: @municipe.phone
             }
           }
    end

    assert_redirected_to municipe_url(Municipe.last)
  end

  test 'should show municipe' do
    get municipe_url(@municipe)

    assert_response :success
  end

  test 'should get edit' do
    get edit_municipe_url(@municipe)

    assert_response :success
  end

  test 'should update municipe' do
    patch municipe_url(@municipe),
          params: { municipe: { birthday: @municipe.birthday, cns: @municipe.cns, cpf: @municipe.cpf, email: @municipe.email,
                                name: @municipe.name, status: @municipe.status, phone: @municipe.phone } }

    assert_redirected_to municipe_url(@municipe)
  end

  test 'should destroy municipe' do
    assert_difference('Municipe.count', -1) do
      delete municipe_url(@municipe)
    end

    assert_redirected_to municipes_url
  end
end
