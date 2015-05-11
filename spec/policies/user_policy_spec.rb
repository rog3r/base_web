describe UserPolicy do
  subject { UserPolicy }

   let (:admin) {FactoryGirl.create(:user, :with_admin_role) }
  # let (:admin) { FactoryGirl.build_stubbed(:user, :with_admin_role) }
  # let (:current_user) { FactoryGirl.build_stubbed :user }
  # let (:other_user) { FactoryGirl.build_stubbed :user }

  #admin = FactoryGirl.create(:user, :with_admin_role)   # FactoryGirl.create(:admin)
  current_user = FactoryGirl.create(:user, :with_user_role) #FactoryGirl.create(:user_w)
  other_user = FactoryGirl.create(:user, :with_user_role) #FactoryGirl.create(:user_w)
  guest = FactoryGirl.create(:user, :with_guest_role)   #FactoryGirl.create(:guest)


  # T - admin can create user
  # UserPolicy.new(admin,User.new).create?

  # T - admin can update own profile
  # UserPolicy.new(admin,admin).update?


  # T - admin can update other user
  # UserPolicy.new(admin,guest).update?


  # T - admin can index users
  # UserPolicy.new(admin,nil).index?

  # T - admin can destroy? other user
  # UserPolicy.new(admin,guest).destroy?

  # F - admin can self destroy?
  # UserPolicy.new(admin,admin).destroy?


  # F - can't
  # UserPolicy.new(guest,User.new).create?

  # T - can
  # UserPolicy.new(guest,guest).update?


  # F - can't
  # UserPolicy.new(guest,admin).update?


  # F - can't
  # UserPolicy.new(guest,nil).index?


  permissions :index? do
    context 'admin user or authorized user'  do
      it 'can access index' do
        expect(subject).to permit(admin)
      end
    end

    context 'unauthorized user'  do
      it "can't access index" do
        expect(subject).not_to permit(guest)
      end
    end
    #
    # it 'denies access if not an admin' do
    #   expect(UserPolicy).not_to permit(guest)
    #   #expect(UserPolicy).not_to permit(current_user)
    # end
    # it 'allows access for an admin' do
    #   expect(UserPolicy).to permit(admin)
    # end
  end

  permissions :show? do
    it 'prevents other users from seeing your profile' do
      expect(subject).not_to permit(current_user, other_user)
    end
    it 'allows you to see your own profile' do
      expect(subject).to permit(current_user, current_user)
    end
    it 'allows an admin to see any profile' do
      expect(subject).to permit(admin)
    end
  end

  permissions :update? do
    it 'prevents updates if not an admin' do
      expect(subject).not_to permit(current_user)
    end
    it 'allows an admin to make updates' do
      expect(subject).to permit(admin)
    end
  end

  permissions :destroy? do
    it 'prevents deleting yourself' do
      expect(subject).not_to permit(current_user, current_user)
    end
    it 'allows an admin to delete any user' do
      expect(subject).to permit(admin, other_user)
    end
  end

end