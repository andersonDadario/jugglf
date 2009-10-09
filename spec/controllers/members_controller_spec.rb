require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

# before_filter :find_member, :only => [:show, :edit, :update, :destroy]
def find_member
  @member ||= mock_model(Member, :to_param => '1', :name => 'Name')
  Member.should_receive(:find).with('1').and_return(@member)
end

# -----------------------------------------------------------------------------
# Index
# -----------------------------------------------------------------------------

# GET /members/index
describe MembersController, "#index" do
  def get_response(args = {})
    get :index, args
  end
  
  describe "as admin" do
    before(:each) do
      login(:admin)
      Member.should_receive(:active).and_return(Member)
      Member.should_receive(:find).and_return(nil)
    end
    
    it "should render" do
      get_response
      response.should render_template(:index)
      response.should be_success
    end
    
    it "should render lua" do
      get_response(:format => 'lua')
      response.should be_success
    end
  end
  
  describe "as user" do
    it "should render" do
      login
      get_response
      response.should render_template(:index)
    end
  end
  
  describe "as anonymous" do
    it "should render" do
      get_response
      response.should render_template(:index)
    end
  end
end

# -----------------------------------------------------------------------------
# Show
# -----------------------------------------------------------------------------

# GET /members/:id
describe MembersController, "#show" do
  def get_response(params = {})
    get :show, params.merge!(:id => '1-name')
  end
  
  before(:each) do
    @mock = mock_model(Member, :id => '1', :name => 'Name',
      :punishments            => mock_model(Punishment, :active => 'punishments'),
      :loots                  => mock_model(Loot, :find => 'loots', :paginate => 'loots'),
      :wishlists              => mock_model(Wishlist, :find => 'wishlists'),
      :completed_achievements => mock_model(CompletedAchievement, :find => 'achievements'))
  end
  
  describe "as admin" do
    before(:each) do
      login(:admin)
      Member.should_receive(:find).with('1-name').and_return(@mock)
    end
    
    %w(loots punishments wishlist achievements).each do |tab|
      it "should render #{tab} tab" do
        get_response(:tab => tab)
        assigns[tab.pluralize.intern].should_not be_nil
        response.should render_template("members/_#{tab}")
      end
    end
  end
  
  describe "as user" do
    it "should not render if the member doesn't belong to the current user" do
      login(:user, :member => Member.make_unsaved(:id => '999', :name => 'Name'))
      get_response
      response.should redirect_to(root_url)
    end
    
    it "should not render if the current user has no associated member" do
      login
      get_response
      response.should redirect_to(root_url)
    end
    
    it "should render when the current member belongs to the current user" do
      login(:user, :member => Member.make_unsaved(:id => '1', :name => 'Name'))
      get_response
      response.should be_success
      response.should render_template(:show)
    end
  end
  
  describe "as anonymous" do
    it "should redirect to login" do
      get_response
      response.should redirect_to(new_user_session_url)
    end
  end
end

# -----------------------------------------------------------------------------
# New
# -----------------------------------------------------------------------------

# GET /members/new
describe MembersController, "#new" do
  def get_response
    get :new
  end
  
  describe "as admin" do
    before(:each) do
      Member.should_receive(:new).and_return(nil)
    end
    
    it "should render" do
      login(:admin)
      get_response
      response.should render_template(:new)
      response.should be_success
    end
  end
  
  describe "as user" do
    it "should not render" do
      login
      get_response
      response.should redirect_to(root_url)
    end
  end
  
  describe "as anonymous" do
    it "should redirect to login" do
      get_response
      response.should redirect_to(new_user_session_url)
    end
  end
end

# -----------------------------------------------------------------------------
# Edit
# -----------------------------------------------------------------------------

# GET /members/edit/:id
describe MembersController, "#edit" do
  def get_response
    get :edit, :id => '1'
  end
  
  describe "as admin" do
    before(:each) do
      login(:admin)
      InvisionUser.should_receive(:juggernaut).and_return('users')
      find_member
      get_response
    end
    
    it "should assign @users" do
      assigns[:users].should == 'users'
    end

    it "should assign @member" do
      assigns[:member].should === @member
    end
    
    it "should render" do
      response.should render_template(:edit)
      response.should be_success
    end
  end
  
  describe "as user" do
    it "should not render" do
      login
      get_response
      response.should redirect_to(root_url)
    end
  end
  
  describe "as anonymous" do
    it "should redirect to login" do
      get_response
      response.should redirect_to(new_user_session_url)
    end
  end
end

# -----------------------------------------------------------------------------
# Create
# -----------------------------------------------------------------------------

# POST /members
describe MembersController, "#create" do
  def get_response
    post :create, :member => @params
  end
  
  describe "as admin" do
    describe "when successful" do
      before(:each) do
        login(:admin)
        @member = mock_model(Member, :to_param => '1', :save => true)
        @params = Member.plan.stringify_keys!
        Member.should_receive(:new).with(@params).and_return(@member)
        get_response
      end
      
      it "should create a new member from params" do
        # All handled by before
      end
      
      it "should add a flash success message" do
        flash[:success].should == 'Member was successfully created.'
      end
    
      it "should redirect to the new member" do
        response.should redirect_to(member_url('1'))
      end
    end
  
    describe "when unsuccessful" do
      before(:each) do
        login(:admin)
        @member = mock_model(Member, :save => false)
        Member.stub!(:new).and_return(@member)
      end
    
      it "should render template :new" do
        get_response
        response.should render_template(:new)
      end
    end
  end
  
  describe "as user" do
    it "should not render" do
      login
      get_response
      response.should redirect_to(root_url)
    end
  end
  
  describe "as anonymous" do
    it "should redirect to login" do
      get_response
      response.should redirect_to(new_user_session_url)
    end
  end
end

# -----------------------------------------------------------------------------
# Update
# -----------------------------------------------------------------------------

# PUT /members/:id
describe MembersController, "#update" do
  def get_response
    put :update, :id => '1', :member => @params
  end
  
  describe "as admin" do
    before(:each) do
      login(:admin)
      find_member
      @params = Member.plan.stringify_keys!
    end
    
    describe "when successful" do
      before(:each) do
        @member.should_receive(:update_attributes).with(@params).and_return(true)
        get_response
      end
      
      it "should assign @member from params" do
        assigns[:member].should == @member
      end
      
      it "should update attributes from params" do
        # All handled by before
      end
      
      it "should add a flash success message" do
        flash[:success].should == 'Member was successfully updated.'
      end
      
      it "should redirect back to the member index" do
        response.should redirect_to(members_url)
      end
    end
    
    describe "when unsuccessful" do
      it "should render the edit form" do
        @member.should_receive(:update_attributes).and_return(false)
        get_response
        response.should render_template(:edit)
      end
    end
  end
  
  describe "as user" do
    it "should not render" do
      login
      get_response
      response.should redirect_to(root_url)
    end
  end
  
  describe "as anonymous" do
    it "should redirect to login" do
      get_response
      response.should redirect_to(new_user_session_url)
    end
  end
end

# -----------------------------------------------------------------------------
# Destroy
# -----------------------------------------------------------------------------

# DELETE /members/:id
describe MembersController, "#destroy" do
  def get_response
    delete :destroy, :id => '1'
  end
  
  describe "as admin" do
    before(:each) do
      login(:admin)
      find_member
      @member.should_receive(:destroy).and_return(nil)
      get_response
    end
    
    it "should add a flash success message" do
      flash[:success].should == 'Member was successfully deleted.'
    end
    
    it "should redirect to #index" do
      response.should redirect_to(members_url)
    end
  end
  
  describe "as user" do
    it "should do nothing" do
      login
      get_response
      response.should redirect_to(root_url)
    end
  end
  
  describe "as anonymous" do
    it "should redirect to login" do
      get_response
      response.should redirect_to(new_user_session_url)
    end
  end
end