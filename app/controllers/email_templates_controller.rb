class EmailTemplatesController < ApplicationController
  before_action :set_template, only: [ :show, :edit, :update, :destroy, :preview ]

  def index
    @email_templates = EmailTemplate.order(:id)
  end

  def new
    @template = EmailTemplate.new
  end

  def create
    @template = EmailTemplate.new(template_params)
    if @template.save
      redirect_to email_templates_path, notice: "Template created."
    else
      render :new
    end
  end

  def edit; end

  def update
    if @template.update(template_params)
      redirect_to email_templates_path, notice: "Template updated."
    else
      render :edit
    end
  end

  def show; end

  def destroy
    @template.destroy
    redirect_to email_templates_path, notice: "Template deleted."
  end

  def preview
    @template = EmailTemplate.find(params[:id])
    @contacts = Contact.all
  end

  private

  def set_template
    @template = EmailTemplate.find(params[:id])
  end

  def template_params
    params.require(:email_template).permit(:subject, :body)
  end
end
