describe UserPolicy do
  subject { UserPolicy }

  let (:admin) { FactoryGirl.create(:user, :with_admin_role) }
  let (:current_user) { FactoryGirl.create(:user, :with_user_role) }
  let (:other_user) { FactoryGirl.create(:user, :with_user_role)  }
  let (:guest) { FactoryGirl.create(:user, :with_guest_role)  }

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
    context 'admin user or authorized user' do
      it 'permit access users list' do
        expect(subject).to permit(admin)
      end
    end

    context 'unauthorized user' do
      it 'denies access users list' do
        expect(subject).not_to permit(guest)
      end
    end
  end

  permissions :show? do
    context 'admin user or owner' do
      it 'allow access index' do
        expect(subject).to permit(admin)
      end
      it 'allow user to show own account' do #should allow a user to see things in their own account
        expect(subject).to permit(current_user, current_user)
      end
      it 'allow an admin to see any profile' do
        expect(subject).to permit(admin)
      end
    end

    context 'other users' do
      it 'denies access users from seeing your account' do #should not allow a user to see things from other accounts
        expect(subject).not_to permit(guest, other_user)
      end
    end


  end

  permissions :create? do
    context 'admin user or authorized user' do
      it 'permit create a user' do
        expect(subject).to permit(admin)
      end
    end

    context 'unauthorized user' do
      it 'denies create user' do
        expect(subject).not_to permit(guest)
      end
    end
  end

  permissions :update? do
    context 'admin user or ownner' do
      it 'allows update own account' do
        expect(subject).to permit(admin, admin)
      end

      it 'allows update other account' do
        expect(subject).to permit(admin, current_user)
      end
    end

    context 'unauthorized user' do
      it 'denies a sample user to update aother account' do
        expect(subject).not_to permit(guest, other_user)
      end
    end

  end

  permissions :destroy? do
    it 'prevents deleting yourself' do
      expect(subject).not_to permit(admin, admin)
    end
    it 'allows an admin to delete any other user' do
      expect(subject).to permit(admin, other_user)
    end
  end

end