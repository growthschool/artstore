class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_required

  # before_action :xxxxx if is_admin
  layout "admin"

end