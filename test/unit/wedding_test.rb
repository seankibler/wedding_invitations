require 'test_helper'

class WeddingTest < ActiveSupport::TestCase
  test "should have bride and groom name in name" do
    bride = Bride.new(first_name: 'Brenda', last_name: 'Carver')
    groom = Groom.new(first_name: 'Brandon', last_name: 'Claver')
    wedding = Wedding.new(bride: bride, groom: groom, wedding_date: Date.parse('June 14, 2013'))
    assert wedding.name  == 'Joining of Brandon Claver and Brenda Carver on June 14, 2013'
  end
end
