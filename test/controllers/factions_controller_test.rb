require 'test_helper'

class FactionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @faction = factions(:one)
  end

  test "should get index" do
    get factions_url
    assert_response :success
  end

  test "should get new" do
    get new_faction_url
    assert_response :success
  end

  test "should create faction" do
    assert_difference('Faction.count') do
      post factions_url, params: { faction: { faction_name: @faction.faction_name, member_id: @faction.member_id } }
    end

    assert_redirected_to faction_url(Faction.last)
  end

  test "should show faction" do
    get faction_url(@faction)
    assert_response :success
  end

  test "should get edit" do
    get edit_faction_url(@faction)
    assert_response :success
  end

  test "should update faction" do
    patch faction_url(@faction), params: { faction: { faction_name: @faction.faction_name, member_id: @faction.member_id } }
    assert_redirected_to faction_url(@faction)
  end

  test "should destroy faction" do
    assert_difference('Faction.count', -1) do
      delete faction_url(@faction)
    end

    assert_redirected_to factions_url
  end
end
