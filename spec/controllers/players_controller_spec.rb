require 'rails_helper'

describe PlayersController do
  describe 'GET show' do
    it 'renders the show template' do
      player = Player.create
      get(:show, {'id' => "1"})
      expect(response).to render_template('show')
    end
  end
end