require 'spec_helper'

describe DirtyAssociations do

  before do
    @team = Team.create(title: 'Real Madrid')
    @player_ronaldo_id = @team.players.create(name: 'Ronaldo', number: 7, position: 'S').id
    @player_benzema_id = @team.players.create(name: 'Benzema', number: 10, position: 'S').id
    @team.reload
  end

  it 'has a version number' do
    expect(DirtyAssociations::VERSION).not_to be nil
  end

  context 'changed attribute on existing record' do
    before do
      @team.attributes = {players_attributes: [{id: @player_ronaldo_id, number: 8}]}
    end
    it 'set "changed?" to true' do
      expect(@team.changed?).to be(true)
    end

    it 'returns changed_attributes' do
      expect(@team.changed_attributes[:players].size).to eq(1)
      expect(@team.changed_attributes[:players][0].name).to eq('Ronaldo')
      expect(@team.changed_attributes[:players][0].number).to eq(8)
    end

    it 'returns changes' do
      expect(@team.changes.size).to eq(1)
      expect(@team.changes).to eq({'players'=>[{'number' => [7, 8]}]})
    end
  end

  context 'change to current attribute on existing record' do
    before do
      @team.attributes = {players_attributes: [{id: @player_ronaldo_id, number: 7}]}
    end
    it 'set "changed?" to false' do
      expect(@team.changed?).to be(false)
    end

    it 'returns no changed_attributes' do
      expect(@team.changed_attributes.size).to eq(0)
    end
  end

  context 'add new record' do
    before do
      @team.attributes = {players_attributes: [{name: 'Bale', position: 'M', number: 7}]}
    end
    it 'set "changed?" to false' do
      expect(@team.changed?).to be(true)
    end

    it 'returns changes' do
      expect(@team.changes.size).to eq(1)
      expect(@team.changes).to eq({'players' => [{'name' => [nil, "Bale"], 'position' => [nil, "M"], 'number' => [nil, 7], 'team_id' => [nil, @team.id]}]})
    end
  end

  context 'mark_for_destruction' do
    before do
      @team.attributes = {players_attributes: [{id: @player_benzema_id, _destroy: true}]}
    end
    it 'set "changed?" to false' do
      expect(@team.changed?).to be(true)
    end

    it 'returns changes' do
      expect(@team.changes.size).to eq(1)
      expect(@team.changes).to eq({"players"=>[{}]})
    end
  end

  context 'change updated_at when saving parent' do
    before do
      @team.attributes = {players_attributes: [{id: @player_benzema_id, _destroy: true}]}
    end
    it 'returns diferent updated_at' do
      updated_at_before_save = @team.updated_at.dup
      @team.save
      expect(@team.updated_at).to_not eq(updated_at_before_save)
    end
  end

end
