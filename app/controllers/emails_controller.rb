class EmailsController < ApplicationController
  def index
    @all_emails = Email.all
  end

  def show
    @email = Email.find_by(id: params[:id])
    @object_email = @email.object
    @email.read = true
    @email.save
    respond_to do |format|
      format.html {}
      format.js {}
    end
  end

  def create
    @email = Email.create(object: Faker::Lorem.sentence , body: Faker::Lorem.sentence*12, read: false)
    @index_email = Email.all.count

    respond_to do |format|
      format.html {redirect_to root_path}
      format.js {}
    end
  end

  def update
    @email = Email.find(params[:id])
    @object_email = @email.object
    if @email.read
      @email.read = false
      @email.save
    elsif !@email.read
      @email.read = true
      @email.save
    end

    respond_to do |format|
      format.html {redirect_to root_path}
      format.js {}
    end
  end

  def destroy
    @email = Email.find(params[:id])

    @email_index = Email.all.index(@email)
    @email_object = @email.object
    @email_body = @email.body

    @email.destroy

    respond_to do |format|
      format.html {redirect_to root_path}
      format.js {}
    end
  end
end
