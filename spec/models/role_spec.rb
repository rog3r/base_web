require 'spec_helper'

describe Role do

  # role
  let(:user_role) { FactoryGirl.create(:user_role) }

  # ability
  let(:foo_index)   { FactoryGirl.create(:foo_index) }
  let(:foo_show)    { FactoryGirl.create(:foo_show) }
  let(:foo_create)  { FactoryGirl.create(:foo_create) }
  let(:foo_udpate)  { FactoryGirl.create(:foo_udpate) }
  let(:foo_destroy) { FactoryGirl.create(:foo_destroy) }

  let(:all_update) do
    {
      "name" => "fuga",
      "abilities_roles_attributes" => [
        { "ability_id" => foo_index.to_param },
        { "ability_id" => foo_show.to_param }
      ]
    }
  end

  let(:not_update) do
    {
      "name" => user_role.name,
      "abilities_roles_attributes" => [
        { "ability_id" => user_role.abilities_roles[0].ability_id },
        { "ability_id" => user_role.abilities_roles[1].ability_id },
        { "ability_id" => user_role.abilities_roles[2].ability_id },
        { "ability_id" => user_role.abilities_roles[3].ability_id },
        { "ability_id" => user_role.abilities_roles[4].ability_id }
      ]
    }
  end

  let(:some_update) do
    {
      "name" => "fuga",
      "abilities_roles_attributes" => [
        { "ability_id" => user_role.abilities_roles[0].ability_id },
        { "ability_id" => user_role.abilities_roles[1].ability_id },
        { "ability_id" => user_role.abilities_roles[2].ability_id },
        { "ability_id" => user_role.abilities_roles[3].ability_id },
        { "ability_id" => foo_index.to_param }
      ]
    }
  end

  let(:not_include_abilities_roles_attributes) { { "name" => "fuga" } }

  describe 'relationship' do
    it { should have_one(:user) }
    it { should have_many(:abilities_roles).dependent(:destroy) }
    it { should have_many(:abilities).through(:abilities_roles) }
    it { should accept_nested_attributes_for(:abilities_roles).update_only(true) }
  end

  #describe "#ability" do
  #  subject { user_role.ability }
  #  it { should include "user" }
  #end
  #
  #describe "#get_destroy_id", "roleに紐づくability_idの更新時に、削除するability_idを取得する" do
  #  context "全更新" do
  #    it "現在紐づいているability_id全て" do
  #      expect(user_role.get_destroy_id all_update).to eq user_role.ability_id_to_a
  #    end
  #  end
  #
  #  context "更新無し" do
  #    it "空配列が返る" do
  #      expect(user_role.get_destroy_id not_update).to eq []
  #    end
  #  end
  #
  #  context "一部更新" do
  #    it "削除されるidが返る" do
  #      expect(user_role.get_destroy_id some_update).to eq [user_role.abilities_roles[4].ability_id]
  #    end
  #  end
  #
  #  context "abilities_roles_attributesが無い" do
  #    it "例外発生する" do
  #      expect { user_role.get_destroy_id not_include_abilities_roles_attributes }.to raise_error ActiveRecord::Rollback
  #    end
  #  end
  #end
  #
  #describe "#destroy_old_abilities" do
  #  let(:old_id) { user_role.abilities_roles.map(&:id) }
  #
  #  context "全更新" do
  #    it "abilities_roles.idは0件になる" do
  #      user_role.destroy_old_abilities all_update
  #      expect(RolesAbility.where(id: old_id).count).to eq 0
  #    end
  #  end
  #
  #  context "更新無し" do
  #    it "abilities_roles.idは5件のまま" do
  #      user_role.destroy_old_abilities not_update
  #      expect(RolesAbility.where(id: old_id).count).to eq 5
  #    end
  #  end
  #
  #  context "一部更新" do
  #    it "abilities_roles.idは4件になる" do
  #      user_role.destroy_old_abilities some_update
  #      expect(RolesAbility.where(id: old_id).count).to eq 4
  #    end
  #  end
  #end
  #
  #describe "#push_current_abilities_roles_id" do
  #  context "全更新 全ての要素にabilities_roles.idが含まれていない" do
  #    subject do
  #      user_role.push_current_abilities_roles_id(all_update)["abilities_roles_attributes"]
  #    end
  #
  #    its([0]) { should_not include "id" }
  #    its([1]) { should_not include "id" }
  #  end
  #
  #  context "一部更新 abilities_roles.idが含まれている要素がある" do
  #    subject do
  #      user_role.push_current_abilities_roles_id(some_update)["abilities_roles_attributes"]
  #    end
  #
  #    its([0]) { should include "id" }
  #    its([1]) { should include "id" }
  #    its([2]) { should include "id" }
  #    its([3]) { should include "id" }
  #    its([4]) { should_not include "id" }
  #  end
  #
  #  context "更新なし 全ての要素にabilities_roles.idが含まれている" do
  #    subject do
  #      user_role.push_current_abilities_roles_id(not_update)["abilities_roles_attributes"]
  #    end
  #
  #    its([0]) { should include "id" }
  #    its([1]) { should include "id" }
  #  end
  #end
  #
  #describe "#destroy_and_update" do
  #  context "abilities_roles_attributesなし" do
  #    before  { user_role.destroy_and_update not_include_abilities_roles_attributes }
  #    subject { user_role.reload }
  #
  #    it "abilityは残っている" do
  #      expect(subject.ability).to include('user')
  #    end
  #
  #    it "名前も変わらない" do
  #      expect(subject.name).to eq "User権限"
  #    end
  #  end
  #
  #  context "全更新" do
  #    let(:old_ability_id) { user_role.get_destroy_id(all_update) }
  #
  #    before  { user_role.destroy_and_update all_update }
  #    subject { user_role.reload }
  #
  #    it "新しく作成したdomainが存在する" do
  #      expect(subject.ability).to include foo_index.domain
  #    end
  #
  #    it "削除したdomainが存在しない" do
  #      expect(subject.ability).not_to include 'user'
  #    end
  #
  #    it "user_roleに紐づくability_idがattributesと一致している" do
  #      attrs_ability_id = all_update["abilities_roles_attributes"].map { |i| i['ability_id'].to_i }
  #      expect(subject.ability_id_to_a).to eq attrs_ability_id
  #    end
  #
  #    it "物理削除したability_idが存在しない1" do
  #      expect(Role.exists? old_ability_id[0]).to be_false
  #    end
  #
  #    it "物理削除したability_idが存在しない2" do
  #      expect(Role.exists? old_ability_id[1]).to be_false
  #    end
  #  end
  #
  #  context "更新なし" do
  #    before  { user_role.destroy_and_update not_update }
  #    subject { user_role.reload }
  #
  #    it "user_roleに紐づくability_idがattributesと一致している" do
  #      attrs_ability_id = not_update["abilities_roles_attributes"].map { |i| i['ability_id'].to_i }
  #      expect(subject.ability_id_to_a).to eq attrs_ability_id
  #    end
  #  end
  #
  #  context "一部更新" do
  #    let(:old_ability_id) { user_role.get_destroy_id(some_update) }
  #
  #    before  { user_role.destroy_and_update some_update }
  #    subject { user_role.reload }
  #
  #    it "新しく作成したdomainが存在する" do
  #      expect(subject.ability).to include foo_index.domain
  #    end
  #
  #    it "user_roleに紐づくability_idがattributesと一致している" do
  #      attrs_ability_id = some_update["abilities_roles_attributes"].map { |i| i['ability_id'].to_i }
  #      expect(subject.ability_id_to_a).to eq attrs_ability_id
  #    end
  #
  #    it "物理削除したability_idが存在しない" do
  #      expect(Role.exists? old_ability_id[0]).to be_false
  #    end
  #  end
  #
  #  context "ロールバック" do
  #    context "古いレコードの削除が失敗した場合" do
  #      it "return false" do
  #        Role.any_instance.stub(:destroy_old_abilities).and_raise
  #        expect(user_role.destroy_and_update all_update).to be_false
  #      end
  #    end
  #
  #    context "新しいレコードの作成が失敗した場合" do
  #      it "return false" do
  #        Role.any_instance.stub(:save).and_return(false)
  #        expect(user_role.destroy_and_update all_update).to be_false
  #      end
  #    end
  #
  #    context "abilities_roles_attributesが無い" do
  #      let(:attrs) { { "name" => "fuga" } }
  #
  #      it "return false" do
  #        expect(user_role.destroy_and_update attrs).to be_false
  #      end
  #    end
  #
  #    context "abilities_roles_attributesが空" do
  #      let(:attrs) { { "name" => "fuga", "abilities_roles_attributes" => [] } }
  #
  #      it "return false" do
  #        expect(user_role.destroy_and_update attrs).to be_false
  #      end
  #    end
  #  end
  #end
end
